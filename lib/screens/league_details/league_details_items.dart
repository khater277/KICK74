import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/player_details/player_details_screen.dart';
import 'package:kick74/screens/show_all_scorers/show_all_scorers_screen.dart';
import 'package:kick74/screens/team/team_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/models/LeagueStandingModel.dart' as standing;


class StandingHead extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const StandingHead({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> league = cubit.leagues.firstWhere((element) => element['id']==leagueID);
    return Center(
      child: SizedBox(
        width: 200,height: 200,
          child: Image.asset("${league['image']}")
      ),
    );
  }
}

class StandingAndScorers extends StatelessWidget {
  final String text;
  const StandingAndScorers({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: darkGrey,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }
}

////////////////////////////////////////////////////////////////////

class ScorersDetails extends StatelessWidget {
  const ScorersDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Player",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: darkGrey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            "Goal",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: darkGrey,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class ScorersBody extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final int length;
  const ScorersBody({Key? key, required this.cubit, required this.leagueID, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<standing.Table> table = cubit.leaguesStandings[leagueID]![0].table!;
    List<Scorers> scorers = cubit.scorers[leagueID]!;
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=> PlayerInScorers(
          index: index,
          scorers: scorers,
          cubit: cubit,
          leagueID: leagueID,
        ),
        separatorBuilder: (context,index)=>const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DefaultSeparator(),
        ),
        itemCount: length
      //scorers.length
    );
  }
}

class PlayerInScorers extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final List<Scorers> scorers;
  final int index;
  const PlayerInScorers({Key? key, required this.index, required this.scorers, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Teams> teams = cubit.leagues.firstWhere((element) => element["id"]==leagueID)['teams'];
    Teams team = teams.firstWhere((element) => element.id==scorers[index].team!.id!);

    return InkWell(
      onTap: (){
        cubit.getPlayerAllDetails(playerID: scorers[index].player!.id, leagueID: leagueID);
        Get.to(()=>PlayerDetailsScreen(
            teamName: team.name!,
            teamImage: team.crestUrl!,
            teamID: team.id!,
            leagueID: leagueID));
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                DefaultNetworkImage(url: "${team.crestUrl}", width: 40, height: 40),
                const SizedBox(width: 10,),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${scorers[index].player!.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20
                        ),
                        //maxLines: 2,
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "${scorers[index].player!.position}",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "${scorers[index].numberOfGoals!}",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ShowLeagueScorers extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const ShowLeagueScorers({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ScorersDetails(),
        ScorersBody(cubit: cubit, leagueID: leagueID,length: 20,),
        const SizedBox(height: 10,),
        TextButton(
            onPressed:(){
              Get.to(()=>ShowAllScorersScreen(leagueID: leagueID));
            },
            child: Text(
              "view all",
              style: TextStyle(
                  color: havan,
                  fontSize: 20
              ),
            )
        )
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////////

class StandingDetails extends StatelessWidget {
  const StandingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Teams",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: darkGrey,
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "",
                ),
              ),
              //const SizedBox(width: 20,),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "P",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: darkGrey,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      "+ / -",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: darkGrey,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              //const SizedBox(width: 20,),
              Expanded(
                child: Text(
                  "PTS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkGrey,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StandingBody extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const StandingBody({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<standing.Table> table = cubit.leaguesStandings[leagueID]![0].table!;
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=> TeamInStanding(
          index: index,
          table: table,
          cubit: cubit,
          leagueID: leagueID,
        ),
        separatorBuilder: (context,index)=>const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DefaultSeparator(),
        ),
        itemCount: table.length
    );
  }
}

class TeamInStanding extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final List<standing.Table> table;
  final int index;
  const TeamInStanding({Key? key, required this.index, required this.table, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Map<String,dynamic> league = cubit.leagues.firstWhere((element) =>
    element['id']==leagueID);

    return InkWell(
      onTap: (){
        cubit.getTeamDetails(teamID: table[index].team!.id!);
        cubit.getTeamAllMatches(teamID: table[index].team!.id!, fromFav: false, league: league);
        Get.to(()=>TeamScreen(leagueID: leagueID));
      },
      child: Row(
        children: [
          DefaultNetworkImage(url: "${table[index].team!.crestUrl}", width: 40, height: 40),
          const SizedBox(width: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width/2-40,
            child: Text(
              "${table[index].team!.name}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${table[index].playedGames}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${table[index].goalsFor}:${table[index].goalsAgainst}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${table[index].points}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class ShowLeagueStanding extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const ShowLeagueStanding({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StandingDetails(),
        StandingBody(cubit: cubit, leagueID: leagueID),
      ],
    );
  }
}


