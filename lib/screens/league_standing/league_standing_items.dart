import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueStandingModel.dart' as standing;
import 'package:kick74/screens/team/team_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

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
              Expanded(
                child: Text(
                  "P",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkGrey,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              //const SizedBox(width: 20,),
              Expanded(
                child: Text(
                  "+ / -",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkGrey,
                  ),
                  textAlign: TextAlign.end,
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
    return InkWell(
      onTap: (){
        cubit.getTeamDetails(teamID: table[index].team!.id!);
        Get.to(()=>TeamScreen(leagueID: leagueID));
      },
      child: Row(
        children: [
          DefaultNetworkImage(url: "${table[index].team!.crestUrl}", width: 30, height: 30),
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
