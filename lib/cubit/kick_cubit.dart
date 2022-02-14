import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/models/AllMatchesModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/models/UserModel.dart';
import 'package:kick74/models/FavTeamModel.dart';
import 'package:kick74/network/reomte/dio_helper.dart';
import 'package:kick74/network/reomte/end_points.dart';
import 'package:kick74/screens/matches/matches_screen.dart';
import 'package:kick74/screens/profile/profile_screen.dart';
import 'package:kick74/screens/settings/settings_screen.dart';
import 'package:kick74/screens/sign_in/sign_in_screen.dart';
import 'package:kick74/shared/constants.dart';

class KickCubit extends Cubit<KickStates>{
  KickCubit() : super(KickInitState());
  static KickCubit get(context)=>BlocProvider.of(context);

  String? selectedValue=lang ?? (defaultLang=='ar'?'ar':'en');
  void changeAppLanguage(String value){
    selectedValue=value;
    GetStorage d = GetStorage();
    d.write('lang', value).then((v){
      lang=value;
      Get.updateLocale(Locale(value));
      print(lang);
    });
    emit(KickChangeLanguageState());
  }


  bool isLanguageSelected=false;
  bool ar = false;
  bool en = false;
  Color arColor=Colors.white;
  Color enColor=Colors.white;
  Color arTextColor=Colors.grey.shade500;
  Color enTextColor=Colors.grey.shade500;
  Color nextButtonColor=Colors.grey.shade200;
  Color nextIconColor=havan.withOpacity(0.4);
  void selectLanguage({@required bool? arabic,@required bool? english}){
    if(arabic==true){
      ar=true;
      en=false;
      arColor=Colors.grey.withOpacity(0.02);
      enColor=enColor=Colors.white;
      arTextColor=havan;
      enTextColor=Colors.grey.shade500;
      changeAppLanguage('ar');
    }else{
      en=true;
      ar=false;
      enColor=Colors.grey.withOpacity(0.02);
      arColor=Colors.white;
      enTextColor=havan;
      arTextColor=Colors.grey.shade500;
      changeAppLanguage('en');
    }
    isLanguageSelected=true;
    nextButtonColor=havan;
    nextIconColor=white;
    emit(KickSelectLanguageState());
  }

  void signOut() {
    GetStorage().remove('uId')
        .then((value){
          Get.off(()=>const SignInScreen());
        });
    emit(KickSignOutSuccessState());
  }

  List<Widget> screens = [
    const ProfileScreen(),
    const MatchesScreen(),
    const SettingsScreen(),
  ];

  List<Widget> screenIcon = [
    Image.asset(
      'assets/images/black_user.png',
      width: 50,height: 50,
    ),

    Image.asset(
      'assets/images/black_settings.png',
      width: 50,height: 50,
    ),
  ];


  int currentIndex = 1;
  void changeNavBar(int index,) {
    currentIndex = index;
    emit(KickNavBarState());
  }

  int leagueIndex = 0;
  void changeLeagueIndex(int index){
    leagueIndex=index;
    emit(KickLeagueIndexState());
  }

  UserModel? userModel;
  void getUserData(){
    emit(KickGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uID)
        .get()
        .then((value){
          userModel = UserModel.fromJson(value.data()!);
      emit(KickGetUserDataSuccessState());
    }).catchError((error){
      printError("getUserData",error.toString());
      emit(KickGetUserDataErrorState());
    });
  }

  List<Map<String,dynamic>> leagues = [
    // {
    //   "id":1,
    //   "name":"My Teams",
    //   "image":"assets/images/matches.png",
    //   "teams":<List<Teams>>[],
    // },
    {
      "id":0,
      "name":"All",
      "image":"assets/images/matches.png",
      "teams":<List<Teams>>[],
    },
    {
      "id":2021,
      "name":"Premier League",
      "image":"assets/images/pl.png",
      "teams":<Teams>[],
    },
    {
      "id":2014,
      "name":"La Liga Santander",
      "image":"assets/images/laliga.png",
      "teams":<Teams>[],
    },
    {
      "id":2019,
      "name":"Lega Calcio",
      "image":"assets/images/calcio.png",
      "teams":<Teams>[],
    },
    {
      "id":2002,
      "name":"Bundesliga",
      "image":"assets/images/bundesliga.png",
      "teams":<Teams>[],
    },
    {
      "id":2015,
      "name":"Ligue 1",
      "image":"assets/images/ligue 1.png",
      "teams":<Teams>[],
    },
  ];

  List<int> leaguesIDs = [2021,2014,2019,2002,2015];
  Map<int,List<Matches>> shownMatches = {
    //1:<Matches>[],
    0:<Matches>[],
    2021:<Matches>[],
    2014:<Matches>[],
    2019:<Matches>[],
    2002:<Matches>[],
    2015:<Matches>[],
  };

  void getAllMatches(){
    emit(KickGetAllMatchesLoadingState());
    DioHelper.getData(url: ALL_MATCHES)
    .then((value){
      AllMatchesModel? allMatchesModel;
      allMatchesModel = AllMatchesModel.fromJson(value.data);
      for (var element in allMatchesModel.matches!) {
        if(leaguesIDs.contains(element.competition!.id)) {
          int competitionID = element.competition!.id!;
          shownMatches[0]!.add(element);
          shownMatches[competitionID]!.add(element);
          // Teams? homeTeam = leagues[1]['teams'][element.homeTeam!.id!];
          // Teams? awayTeam = leagues[1]['teams'][element.awayTeam!.id!];
          // if((favouriteTeams.contains(homeTeam)
          //     ||favouriteTeams.contains(awayTeam))&&(homeTeam!=null||awayTeam!=null)){
          //   shownMatches[1]!.add(element);
          // }
        }
      }
      print(shownMatches[0]!.length);
      emit(KickGetAllMatchesSuccessState());
    }).catchError((error){
      printError("getAllMatches",error.toString());
      emit(KickGetAllMatchesErrorState());
    });
  }

  void getLeagueTeams(){
    emit(KickGetLeagueTeamsLoadingState());
    for(int i=0;i<leaguesIDs.length;i++){
      DioHelper.getData(url: LEAGUE_TEAMS(leagueID: leaguesIDs[i]))
          .then((value){
            LeagueTeamsModel leagueTeamsModel =
            LeagueTeamsModel.fromJson(value.data);
           // allLeaguesTeams.add(leagueTeamsModel.teams!);
            leagues[0]['teams'].add(leagueTeamsModel.teams!);
            if (i==0){
              leagues[1]['teams']=leagueTeamsModel.teams!;
              print(leagues[1]['teams'][0].name);
            }
            else if (i==1){
              leagues[2]['teams']=leagueTeamsModel.teams!;
              print(leagues[2]['teams'][0].name);
            }
            else if (i==2){
              leagues[3]['teams']=leagueTeamsModel.teams!;
              print(leagues[3]['teams'][0].name);
            }
            else if (i==3) {
              leagues[4]['teams']=leagueTeamsModel.teams!;
              print(leagues[4]['teams'][0].name);
            }
            else{
              leagues[5]['teams']=leagueTeamsModel.teams!;
              print(leagues[5]['teams'][0].name);
            }
            emit(KickGetLeagueTeamsSuccessState());
      }).catchError((error){
        printError("getLeagueTeams",error.toString());
        emit(KickGetLeagueTeamsErrorState());
      });
    }
  }

  int onBoardingIndex = 1;
  List<Color> indicatorColors = [
    Colors.grey.withOpacity(0.4),
    Colors.grey.withOpacity(0.4),
    Colors.grey.withOpacity(0.4),
    Colors.grey.withOpacity(0.4),
  ];
  void changeOnBoardingIndex(){
    onBoardingIndex++;
    indicatorColors[onBoardingIndex-2] = havan.withOpacity(0.8);
    print(onBoardingIndex);
    emit(KickOnBoardingIndexLoadingState());
    Future.delayed(const Duration(milliseconds: 500)).then((value){
      emit(KickOnBoardingIndexSuccessState());
    });
  }

  int? selectedTeamIndex;
  List<int> selectedTeamsIDs = [];
  List<Teams> favouriteTeams = [];
  Color selectFavColor = offWhite;
  void selectFavourite({
  @required int? index,
  @required int? teamID,
}){
    bool isFav = selectedTeamsIDs.contains(teamID);
    List<Teams> teams = leagues[onBoardingIndex]['teams'];
    Teams team = teams.firstWhere((element) => element.id==teamID);

    if(!isFav){
      selectedTeamsIDs.add(teamID!);
      addToFavourites(team: team);
    }else{
      selectedTeamsIDs.remove(teamID);
      removeFromFavourites(team: team);
    }
    print(favouriteTeams);
    emit(KickSelectFavTeamState());
  }


  void addToFavourites({@required Teams? team}){
    emit(KickAddToFavouritesLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uID)
        .collection('favourites')
        .doc("${team!.id}")
        .set(team.toJson())
        .then((value){
      emit(KickAddToFavouritesSuccessState());
    }).catchError((error){
      emit(KickAddToFavouritesErrorState());
    });
  }

  void removeFromFavourites({@required Teams? team}){
    emit(KickRemoveFromFavouritesLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uID)
        .collection('favourites')
        .doc("${team!.id}")
        .delete()
        .then((value){
      emit(KickRemoveFromFavouritesSuccessState());
    }).catchError((error){
      emit(KickRemoveFromFavouritesErrorState());
    });
  }

  void getFavourites(){
    emit(KickGetFavouritesLoadingState());
    FirebaseFirestore.instance.collection("users")
    .doc(uID!)
    .collection('favourites')
    .get()
    .then((value) {
      for (var element in value.docs) {
        favouriteTeams.add(Teams.fromJson(element));
      }
      emit(KickGetFavouritesLoadingState());
    }).catchError((error){
      printError("getFavourites", error.toString());
      emit(KickGetFavouritesLoadingState());
    });
  }
}