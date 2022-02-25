import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/player_details/player_details_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

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
  const ScorersBody({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

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
        itemCount: 10
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