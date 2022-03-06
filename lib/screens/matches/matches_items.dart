import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/AllMatchesModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/match_details/match_details_screen.dart';
import 'package:kick74/screens/team/team_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class MyTeamsButton extends StatelessWidget {
  final KickCubit cubit;
  const MyTeamsButton({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            cubit.changeLeagueIndex(10);
            //cubit.getFavouritesMatches();
          },
          child: Container(
            decoration: BoxDecoration(
                color: cubit.leagueIndex==10?grey.withOpacity(0.2):Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: cubit.leagueIndex==10?havan:grey,
                    width: cubit.leagueIndex==10?2:1,
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(
                children: [
                  const ImageIcon(
                    AssetImage("assets/images/favorite.png"),
                    size: 30
                  ),
                  const SizedBox(width: 5),
                  Text("My Teams",
                    style: TextStyle(
                        color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FavouriteMatches extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  const FavouriteMatches({Key? key, required this.cubit, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: matches.isNotEmpty?
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>MatchItem(
            cubit: cubit, index: index, matches: matches),
        separatorBuilder: (context,index)=>const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: DefaultSeparator(),
        ),
        itemCount: matches.length,
      ) :NoItemsFounded(
        text: "There is no matches for your favourite teams today",
        widget: SizedBox(
          width: 200,height: 200,
          child: Icon(IconBroken.Close_Square,size: 200,
            color: Colors.grey[400],),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////

class TeamPicAndName extends StatelessWidget {
  final KickCubit cubit;
  final Teams team;
  final int leagueID;

  const TeamPicAndName({Key? key ,required this.team,
    required this.cubit, required this.leagueID}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> league = cubit.leagues.firstWhere((element) =>
    element['id']==leagueID);

    return InkWell(
      onTap: (){
        cubit.getTeamDetails(teamID: team.id!);
        cubit.getTeamAllMatches(teamID: team.id, fromFav: true, league: league);
        Get.to(()=>TeamScreen(leagueID: leagueID));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultNetworkImage(url: team.crestUrl!, width: 60, height: 60),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    team.shortName!,
                    style: TextStyle(
                        color: darkGrey,fontSize: 16,fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LeagueButton extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  const LeagueButton({Key? key, required this.index, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            cubit.changeLeagueIndex(index);
          },
          child: Container(
            decoration: BoxDecoration(
                color: cubit.leagueIndex==index?
                Colors.grey.withOpacity(0.2):Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: cubit.leagueIndex==index?havan:grey,
                    width: cubit.leagueIndex==index?2:1,
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(
                children: [
                  if (index==0) Row(
                    children: [
                      ImageIcon(
                        AssetImage("${cubit.leagues[index]['image']}"),
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                    ],
                  ) else SizedBox(
                      width: 30,height: 30,
                      child: Image.asset("${cubit.leagues[index]['image']}")
                  ),
                  const SizedBox(width: 5),
                  Text("${cubit.leagues[index]['name']}",
                    style: TextStyle(
                        color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LeagueMatches extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  const LeagueMatches({Key? key, required this.cubit, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAll = cubit.leagueIndex==0;
    return Expanded(
      child: matches.isNotEmpty?
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=> MatchItem(cubit: cubit,index: index,
        matches: matches,),
        separatorBuilder: (context,index)=>const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: DefaultSeparator(),
        ),
        itemCount: matches.length,
      )
          :NoItemsFounded(
          text: "No ${isAll?"":"${cubit.leagues[cubit.leagueIndex]['name']}"}"
              " matches today",
          widget: SizedBox(
            width: 100,height: 100,
            child: ImageIcon(
              AssetImage("${cubit.leagues[cubit.leagueIndex]['image']}"),
              size: 150,
              color: Colors.grey[400],
            ),
          ),
      ),
    );
  }
}

class MatchItem extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final List<Matches> matches;
  const MatchItem({Key? key, required this.cubit, required this.index, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int leagueIndex = cubit.leagues.indexOf(
        cubit.leagues.firstWhere((element) => element['id']
            ==matches[index].competition!.id)
    );

    int homeTeamID=matches[index].homeTeam!.id!;
    int awayTeamID=matches[index].awayTeam!.id!;
    List<Teams> teams = cubit.leagues[leagueIndex]['teams'];
    Teams homeTeam = teams.firstWhere((element) => element.id==homeTeamID);
    Teams awayTeam = teams.firstWhere((element) => element.id==awayTeamID);

    return Column(
      children: [
        Row(
          children: [
            if(cubit.leagueIndex==0||cubit.leagueIndex==10)
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 30, width: 30,
                  child: Image.asset("${cubit.leagues[leagueIndex]['image']}")
                ),
              ),
            )else
            const SizedBox(height: 5,),
          ],
        ),
        const SizedBox(height: 10,),
       if(matches[index].status=="SCHEDULED")
         ScheduledMatch(
             cubit: cubit, matches: matches,
             homeTeam: homeTeam, awayTeam: awayTeam,
             index: index, leagueIndex: leagueIndex)
        else if(matches[index].status=="IN_PLAY"||matches[index].status=="PAUSED")
          InPlayMatch(
              cubit: cubit, matches: matches,
              homeTeam: homeTeam, awayTeam: awayTeam,
              index: index, leagueIndex: leagueIndex)
       else if(matches[index].status=="FINISHED")
           FinishedMatch(
               cubit: cubit, matches: matches,
               homeTeam: homeTeam, awayTeam: awayTeam,
               index: index, leagueIndex: leagueIndex)
      ],
    );
  }
}

class ScheduledMatch extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final Teams homeTeam;
  final Teams awayTeam;
  final int index;
  final int leagueIndex;
  const ScheduledMatch({Key? key, required this.cubit, required this.matches, required this.homeTeam,
    required this.awayTeam, required this.index, required this.leagueIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width/3,
            child:
            TeamPicAndName(
              cubit: cubit,
              team: awayTeam,
              leagueID: cubit.leagues[leagueIndex]['id'],
            )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child:
            ScheduledMatchInfo(
              cubit: cubit,index: index,
              matches: matches,
              homeTeam: homeTeam,
              awayTeam: awayTeam,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: TeamPicAndName(
            cubit: cubit,
            team: homeTeam,
            leagueID: cubit.leagues[leagueIndex]['id'],
          ),
        ),
      ],
    );
  }
}

class ScheduledMatchInfo extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const ScheduledMatchInfo({Key? key, required this.cubit, required this.index,
    required this.matches, required this.homeTeam, required this.awayTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notAll = cubit.leagueIndex!=0||cubit.leagueIndex!=10;
    int leagueID = matches[index].competition!.id!;
    return InkWell(
      onTap: (){
        cubit.getMatchDetails(matchID: matches[index].id!,leagueID: leagueID);
        Get.to(()=>MatchDetailsScreen(
          leagueID: leagueID,
          homeTeam: homeTeam,
          awayTeam: awayTeam,
        ));
      },
      child: Column(
        children: [
          Text(
            timeFormat(matches[index].utcDate!),
            style: TextStyle(
                color: havan,fontSize: 25,fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: notAll?15:10,),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: havan),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    const AssetImage('assets/images/stade.png'),
                    size: 20,
                    color: darkGrey,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "${homeTeam.venue}",
                      style: TextStyle(
                        color: grey,fontSize: 14,fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: notAll?15:10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                const AssetImage("assets/images/calendar.png"),
                size: 17,
                color: darkGrey,
              ),
              const SizedBox(width: 5,),
              Text("Fixture ${matches[index].matchday}",
                style: TextStyle(
                    color: grey,fontSize: 16,fontWeight: FontWeight.normal
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}

class InPlayMatch extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final Teams homeTeam;
  final Teams awayTeam;
  final int index;
  final int leagueIndex;
  const InPlayMatch({Key? key, required this.cubit, required this.matches, required this.homeTeam,
    required this.awayTeam, required this.index, required this.leagueIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width/3,
            child:
            TeamPicAndName(
              cubit: cubit,
              team: awayTeam,
              leagueID: cubit.leagues[leagueIndex]['id'],
            )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child:
            InPlayMatchInfo(
                cubit: cubit, index: index,
                matches: matches, homeTeam: homeTeam,
                awayTeam: awayTeam),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: TeamPicAndName(
            cubit: cubit,
            team: homeTeam,
            leagueID: cubit.leagues[leagueIndex]['id'],
          ),
        ),
      ],
    );
  }
}

class InPlayMatchInfo extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const InPlayMatchInfo({Key? key, required this.cubit, required this.index,
    required this.matches, required this.homeTeam, required this.awayTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notAll = cubit.leagueIndex!=0||cubit.leagueIndex!=10;
    int leagueID = matches[index].competition!.id!;

    return InkWell(
        onTap: (){
          cubit.getMatchDetails(matchID: matches[index].id!,leagueID: leagueID);
          Get.to(()=>MatchDetailsScreen(
            leagueID: leagueID,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
          ));
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: const Text(
                "Live",
                style: TextStyle(
                  color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: havan),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${matches[index].score!.fullTime!.awayTeam}",
                    style: TextStyle(
                      color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    width: 1,height: 20,
                    color: havan,
                  ),
                  Text(
                    "${matches[index].score!.fullTime!.homeTeam}",
                    style: TextStyle(
                      color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        )
    );
  }
}


class FinishedMatch extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final Teams homeTeam;
  final Teams awayTeam;
  final int index;
  final int leagueIndex;
  const FinishedMatch({Key? key, required this.cubit, required this.matches, required this.homeTeam,
    required this.awayTeam, required this.index, required this.leagueIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width/3,
            child:
            TeamPicAndName(
              cubit: cubit,
              team: awayTeam,
              leagueID: cubit.leagues[leagueIndex]['id'],
            )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child:
            FinishedMatchInfo(
                cubit: cubit, index: index,
                matches: matches, homeTeam: homeTeam,
                awayTeam: awayTeam),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: TeamPicAndName(
            cubit: cubit,
            team: homeTeam,
            leagueID: cubit.leagues[leagueIndex]['id'],
          ),
        ),
      ],
    );
  }
}

class FinishedMatchInfo extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const FinishedMatchInfo({Key? key, required this.cubit, required this.index,
    required this.matches, required this.homeTeam, required this.awayTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int leagueID = matches[index].competition!.id!;
    return InkWell(
        onTap: (){
          cubit.getMatchDetails(matchID: matches[index].id!,leagueID: leagueID);
          Get.to(()=>MatchDetailsScreen(
            leagueID: leagueID,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
          ));
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: const Text(
                "Finished",
                style: TextStyle(
                  color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: havan),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${matches[index].score!.fullTime!.awayTeam}",
                    style: TextStyle(
                      color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    width: 1,height: 20,
                    color: havan,
                  ),
                  Text(
                    "${matches[index].score!.fullTime!.homeTeam}",
                    style: TextStyle(
                      color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
          ],
        )
    );
  }
}

