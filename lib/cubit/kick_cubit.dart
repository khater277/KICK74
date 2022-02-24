import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/models/AllMatchesModel.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueStandingModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/models/MatchDetailsModel.dart';
import 'package:kick74/models/PlayerAllDetailsModel.dart' as PLAYER_ALL_DETAILS;
import 'package:kick74/models/TeamModel.dart';
import 'package:kick74/models/UserModel.dart';
import 'package:kick74/models/FavouriteTeamModel.dart';
import 'package:kick74/models/TeamAllMatchesModel.dart' as team_matches;
import 'package:kick74/network/reomte/dio_helper.dart';
import 'package:kick74/screens/league_scorers/league_scorers_screen.dart';
import 'package:kick74/screens/league_standing/league_standing_screen.dart';
import 'package:kick74/screens/matches/matches_screen.dart';
import 'package:kick74/screens/profile/profile_screen.dart';
import 'package:kick74/screens/settings/settings_screen.dart';
import 'package:kick74/screens/sign_in/sign_in_screen.dart';
import 'package:kick74/shared/constants.dart';

class KickCubit extends Cubit<KickStates> {
  KickCubit() : super(KickInitState());
  static KickCubit get(context) => BlocProvider.of(context);

  String? selectedValue = lang ?? (defaultLang == 'ar' ? 'ar' : 'en');
  void changeAppLanguage(String value) {
    selectedValue = value;
    GetStorage d = GetStorage();
    d.write('lang', value).then((v) {
      lang = value;
      Get.updateLocale(Locale(value));
      print(lang);
    });
    emit(KickChangeLanguageState());
  }

  bool isLanguageSelected = false;
  bool ar = false;
  bool en = false;
  Color arColor = Colors.white;
  Color enColor = Colors.white;
  Color arTextColor = Colors.grey.shade500;
  Color enTextColor = Colors.grey.shade500;
  Color nextButtonColor = Colors.grey.shade200;
  Color nextIconColor = havan.withOpacity(0.4);
  void selectLanguage({@required bool? arabic, @required bool? english}) {
    if (arabic == true) {
      ar = true;
      en = false;
      arColor = Colors.grey.withOpacity(0.02);
      enColor = enColor = Colors.white;
      arTextColor = havan;
      enTextColor = Colors.grey.shade500;
      changeAppLanguage('ar');
    } else {
      en = true;
      ar = false;
      enColor = Colors.grey.withOpacity(0.02);
      arColor = Colors.white;
      enTextColor = havan;
      arTextColor = Colors.grey.shade500;
      changeAppLanguage('en');
    }
    isLanguageSelected = true;
    nextButtonColor = havan;
    nextIconColor = white;
    emit(KickSelectLanguageState());
  }

  void signOut() {
    GetStorage().remove('uId').then((value) {
      Get.off(() => const SignInScreen());
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
      width: 50,
      height: 50,
    ),
    Image.asset(
      'assets/images/black_settings.png',
      width: 50,
      height: 50,
    ),
  ];

  int currentIndex = 1;
  void changeNavBar(
    int index,
  ) {
    currentIndex = index;
    emit(KickNavBarState());
  }

  int leagueIndex = 10;
  void changeLeagueIndex(int index) {
    leagueIndex = index;
    emit(KickLeagueIndexState());
  }

  UserModel? userModel;
  void getUserData() {
    emit(KickGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(KickGetUserDataSuccessState());
    }).catchError((error) {
      printError("getUserData", error.toString());
      emit(KickGetUserDataErrorState());
    });
  }

  List<Map<String, dynamic>> leagues = [
    {
      "id": 0,
      "name": "All",
      "image": "assets/images/matches.png",
      "teams": <List<Teams>>[],
    },
    {
      "id": 2021,
      "name": "Premier League",
      "image": "assets/images/pl.png",
      "teams": <Teams>[],
      "country": "assets/images/england.png",
      "startDate": "",
      "endDate": "",
    },
    {
      "id": 2014,
      "name": "La Liga Santander",
      "image": "assets/images/laliga.png",
      "teams": <Teams>[],
      "country": "assets/images/spain.png",
      "startDate": "",
      "endDate": "",
    },
    {
      "id": 2019,
      "name": "Lega Calcio",
      "image": "assets/images/calcio.png",
      "teams": <Teams>[],
      "country": "assets/images/italy.png",
      "startDate": "",
      "endDate": "",
    },
    {
      "id": 2002,
      "name": "Bundesliga",
      "image": "assets/images/bundesliga.png",
      "teams": <Teams>[],
      "country": "assets/images/germany.png",
      "startDate": "",
      "endDate": "",
    },
    {
      "id": 2015,
      "name": "Ligue 1",
      "image": "assets/images/ligue 1.png",
      "teams": <Teams>[],
      "country": "assets/images/france.png",
      "startDate": "",
      "endDate": "",
    },
  ];

  List<int> leaguesIDs = [2021, 2014, 2019, 2002, 2015];
  Map<int, List<Matches>> shownMatches = {
    //1:<Matches>[],
    0: <Matches>[],
    2021: <Matches>[],
    2014: <Matches>[],
    2019: <Matches>[],
    2002: <Matches>[],
    2015: <Matches>[],
  };

  void getAllMatches() {
    emit(KickGetAllMatchesLoadingState());
    DioHelper.getAllMatches().then((value) {
      AllMatchesModel? allMatchesModel;
      allMatchesModel = AllMatchesModel.fromJson(value.data);
      for (var element in allMatchesModel.matches!) {
        if (leaguesIDs.contains(element.competition!.id)) {
          int competitionID = element.competition!.id!;
          shownMatches[0]!.add(element);
          shownMatches[competitionID]!.add(element);
        }
      }
      getFavouritesMatches();
      print(shownMatches[0]!.length);
      emit(KickGetAllMatchesSuccessState());
    }).catchError((error) {
      printError("getAllMatches", error.toString());
      emit(KickGetAllMatchesErrorState());
    });
  }

  List<Matches> favMatches = [];
  void getFavouritesMatches() {
    favMatches = [];
    for (var element in shownMatches[0]!) {
      for (int i = 0; i < favouriteTeams.length; i++) {
        if ((favouriteTeams[i].team!.id! == element.homeTeam!.id) ||
            (favouriteTeams[i].team!.id! == element.awayTeam!.id)) {
          favMatches.add(element);
        }
      }
      print(favMatches);
      emit(KickGetFavouritesMatchesSuccessState());
    }
  }

  void getLeagueTeams() {
    emit(KickGetLeagueTeamsLoadingState());
    for (int i = 0; i < leaguesIDs.length; i++) {
      DioHelper.getLeagueTeams(leagueID: leaguesIDs[i]).then((value) {
        LeagueTeamsModel leagueTeamsModel =
            LeagueTeamsModel.fromJson(value.data);
        leagues[0]['teams'].add(leagueTeamsModel.teams!);
        leagues[i + 1]['teams'] = leagueTeamsModel.teams!;
        leagues[i + 1]['startDate'] = leagueTeamsModel.season!.startDate;
        leagues[i + 1]['endDate'] = leagueTeamsModel.season!.endDate;
        emit(KickGetLeagueTeamsSuccessState());
      }).catchError((error) {
        printError("getLeagueTeams", error.toString());
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
  void changeOnBoardingIndex() {
    onBoardingIndex++;
    indicatorColors[onBoardingIndex - 2] = havan.withOpacity(0.8);
    print(onBoardingIndex);
    emit(KickOnBoardingIndexLoadingState());
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      emit(KickOnBoardingIndexSuccessState());
    });
  }

  int? selectedTeamIndex;
  List<int> selectedTeamsIDs = [];
  List<FavouriteTeamModel> favouriteTeams = [];
  Color selectFavColor = offWhite;
  void selectOnBoardingFavourite({
    @required int? index,
    @required int? teamID,
    @required int? leagueID,
  }) {
    bool isFav = selectedTeamsIDs.contains(teamID);
    List<Teams> teams = leagues[onBoardingIndex]['teams'];
    Teams team = teams.firstWhere((element) => element.id == teamID);
    FavouriteTeamModel favouriteTeamModel =
        FavouriteTeamModel(leagueID: leagueID, team: team);
    if (!isFav) {
      selectedTeamsIDs.add(teamID!);
      addToFavourites(team: team, leagueID: leagueID);
    } else {
      selectedTeamsIDs.remove(teamID);
      removeFromFavourites(favouriteTeamModel: favouriteTeamModel);
    }
    print(favouriteTeams);
    emit(KickSelectFavTeamState());
  }

  void addToFavourites({@required Teams? team, @required int? leagueID}) {
    FavouriteTeamModel favouriteTeamModel =
        FavouriteTeamModel(leagueID: leagueID, team: team!);
    emit(KickAddToFavouritesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('favourites')
        .doc("${team.id}")
        .set(favouriteTeamModel.toJson())
        .then((value) {
      getFavouritesMatches();
      emit(KickAddToFavouritesSuccessState());
    }).catchError((error) {
      emit(KickAddToFavouritesErrorState());
    });
  }

  void removeFromFavourites(
      {@required FavouriteTeamModel? favouriteTeamModel}) {
    emit(KickRemoveFromFavouritesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('favourites')
        .doc("${favouriteTeamModel!.team!.id}")
        .delete()
        .then((value) {
      getFavouritesMatches();
      emit(KickRemoveFromFavouritesSuccessState());
    }).catchError((error) {
      emit(KickRemoveFromFavouritesErrorState());
    });
  }

  void getFavourites() {
    if(uID!=null){
      emit(KickGetFavouritesLoadingState());
      FirebaseFirestore.instance
          .collection("users")
          .doc(uID!)
          .collection('favourites')
          .get()
          .then((value) {
        favouriteTeams = [];
        for (var element in value.docs) {
          Teams team = Teams.fromJson(element.data()['team']);
          favouriteTeams.add(FavouriteTeamModel.fromJson(
              {'leagueID': element.data()['leagueID'], 'team': team}));
        }
        emit(KickGetFavouritesSuccessState());
      }).catchError((error) {
        printError("getFavourites", error.toString());
        emit(KickGetFavouritesErrorState());
      });
    }else{
      emit(KickGetFavouritesLoadingState());
    }
  }

  ImagePicker picker = ImagePicker();
  File? profileImage;
  void selectProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(KickSelectProfileImageSuccessState());
    } else {
      emit(KickSelectProfileImageErrorState());
    }
  }

  void setProfileImage() {
    emit(KickSetProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        profileImage = null;
        updateUserData(profileImage: value);
      }).catchError((error) {
        printError("setProfileImage", error.toString());
        emit(KickSetProfileImageErrorState());
      });
    }).catchError((error) {
      printError("setProfileImage", error.toString());
      emit(KickSetProfileImageErrorState());
    });
  }

  void updateUserData({@required String? profileImage}) {
    emit(KickUpdateUserDataLoadingState());
    UserModel updatedUserModel = UserModel(
      userToken: userModel!.userToken,
      uId: userModel!.uId,
      name: userModel!.name,
      email: userModel!.email,
      profileImage: profileImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .update(updatedUserModel.toJson())
        .then((value) {
      getUserData();
      print("USER UPDATED");
      emit(KickUpdateUserDataSuccessState());
    }).catchError((error) {
      printError("updateUserData", error.toString());
      emit(KickUpdateUserDataErrorState());
    });
  }

  MatchDetailsModel? matchDetailsModel;
  void getMatchDetails({@required int? matchID, @required int? leagueID}) {
    print(matchDetailsModel);
    if (matchDetailsModel == null || matchDetailsModel!.match!.id != matchID) {
      emit(KickGetMatchDetailsLoadingState());
      DioHelper.getMatchDetails(matchID: matchID).then((value) {
        matchDetailsModel = MatchDetailsModel.fromJson(value.data);
        print(matchDetailsModel!.match!.venue);
        getTopScorers(leagueID: leagueID);
      }).catchError((error) {
        printError("getMatchDetails", error.toString());
        emit(KickGetMatchDetailsErrorState());
      });
    }
  }

  Map<int, List<Scorers>> scorers = {
    2021: [],
    2014: [],
    2019: [],
    2002: [],
    2015: [],
  };
  void getTopScorers({@required int? leagueID}) {
    if (scorers[leagueID]!.isEmpty) {
      emit(KickGetLeagueTopScorersLoadingState());
      DioHelper.getLeagueTopScorers(leagueID: leagueID!).then((value) {
        LeagueScorersModel leagueScorersModel =
            LeagueScorersModel.fromJson(value.data);
        scorers[leagueID] = leagueScorersModel.scorers!;
        print(scorers[leagueID]![0].player!.name);
        emit(KickGetLeagueTopScorersSuccessState());
      }).catchError((error) {
        printError("getTopScorers", error.toString());
        emit(KickGetLeagueTopScorersErrorState());
      });
    } else {
      emit(KickGetLeagueTopScorersSuccessState());
    }
  }

 TeamModel? teamModel;
  void getTeamDetails({@required int? teamID, bool? fromFav, int? leagueID}) {
    if (teamModel == null || teamModel!.id != teamID) {
      emit(KickGetTeamDetailsLoadingState());
      DioHelper.getTeamDetails(teamID: teamID!).then((value) {
        teamModel = TeamModel.fromJson(value.data);
        print(teamModel!.name!);
        getTeamAllMatches(teamID: teamID,fromFav: fromFav,leagueID: leagueID);
      }).catchError((error) {
        printError("getTeamDetails", error.toString());
        emit(KickGetTeamDetailsErrorState());
      });
    }
  }

  PLAYER_ALL_DETAILS.PlayerAllDetailsModel? playerAllDetailsModel;
  void getPlayerAllDetails({
    @required int? playerID,
    @required int? leagueID,
  }) {
    if (playerAllDetailsModel == null ||
        playerAllDetailsModel!.player!.id != playerID) {
      emit(KickGetPlayerAllDetailsLoadingState());
      Map<String, dynamic> league =
          leagues.firstWhere((element) => element['id'] == leagueID);
      DioHelper.getPlayerAllDetails(
        playerID: playerID!,
        endDate: league['endDate'],
        leagueID: leagueID,
        startDate: league['startDate'],
      ).then((value) {
        playerAllDetailsModel =
            PLAYER_ALL_DETAILS.PlayerAllDetailsModel.fromJson(value.data);
        print(playerAllDetailsModel!.player!.name);
        emit(KickGetPlayerAllDetailsSuccessState());
      }).catchError((error) {
        printError("getPlayerAllDetails", error.toString());
        emit(KickGetPlayerAllDetailsLoadingState());
      });
    } else {
      emit(KickGetPlayerAllDetailsSuccessState());
    }
  }


  //List<int> leaguesIDs = [2021, 2014, 2019, 2002, 2015];
  Map<int,List<Standings>> leaguesStandings = {
    2021 : <Standings>[],
    2014 : <Standings>[],
    2019 : <Standings>[],
    2002 : <Standings>[],
    2015 : <Standings>[],
  };


  void getLeagueStandings(context,{@required int? leagueID}){
    if(leaguesStandings[leagueID]!.isEmpty){
      emit(KickGetLeagueStandingsLoadingState());
      DioHelper.getLeagueStanding(leagueID: leagueID)
          .then((value){
            LeagueStandingModel leagueStandingModel =
            LeagueStandingModel.fromJson(value.data);
        leaguesStandings[leagueID!] = leagueStandingModel.standings!;
        print(leaguesStandings[leagueID]![0].table![4].team!.name!);
        emit(KickGetLeagueStandingsSuccessState());
      }).catchError((error){
        printError("getLeagueStandings", error.toString());
        emit(KickGetLeagueStandingsErrorState());
      });
    }else{
      emit(KickGetLeagueStandingsSuccessState());
    }
  }

  List<team_matches.Matches> teamMatches = [];
  void getTeamAllMatches({@required int? teamID,@required bool? fromFav,@required int? leagueID}){
    emit(KickGetTeamAllMatchesLoadingState());
    DioHelper.getTeamAllMatches(teamID: teamID)
    .then((value){
      team_matches.TeamAllMatchesModel? teamAllMatchesModel =
          team_matches.TeamAllMatchesModel.fromJson(value.data);
      teamMatches = teamAllMatchesModel.matches!;
      print(teamMatches[0].homeTeam!.name!);
      if (fromFav == true) {
        getTopScorers(leagueID: leagueID!);
      } else {
        emit(KickGetTeamAllMatchesSuccessState());
      }
    }).catchError((error){
      printError("getTeamAllMatches", error.toString());
      emit(KickGetTeamAllMatchesErrorState());
    });
  }

}
