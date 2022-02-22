import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/league_standing/league_standing_screen.dart';
import 'package:kick74/screens/player_details/player_details_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamHead extends StatelessWidget {
  final KickCubit cubit;
  const TeamHead({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultNetworkImage(
            url: cubit.teamModel!.crestUrl!, width: 100, height: 100),
        const SizedBox(
          height: 15,
        ),
        Text(
          "${cubit.teamModel!.name}",
          style:
              TextStyle(fontSize: 20, color: grey, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class TeamDetailsItem extends StatelessWidget {
  final String icon;
  final String text;
  bool? isLink;
  TeamDetailsItem(
      {Key? key, required this.icon, required this.text, this.isLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ImageIcon(
            AssetImage(icon),
            color: darkGrey,
            size: 22,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              if (isLink == true) {
                _launchURL(text);
              }
            },
            child: Text(
              text,
              style: TextStyle(
                color: isLink == true ? Colors.blue.withOpacity(0.7) : darkGrey,
                fontWeight: FontWeight.normal,
                fontStyle: isLink == true ? FontStyle.italic : FontStyle.normal,
                fontSize: 18,
              ),
              //overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}

class FoundedAndStadium extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const FoundedAndStadium({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> league = cubit.leagues.firstWhere((element) =>
        element['id'] == leagueID);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: (){
              cubit.getLeagueStandings(leagueID: leagueID);
              Get.to(()=>LeagueStandingScreen(leagueID: leagueID));
            },
            child: Row(
              children: [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("${league['image']}")),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "${league['name']}",
                    style: TextStyle(
                      color: darkGrey,
                         fontSize: 20, fontWeight: FontWeight.normal),
                    //overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TeamDetailsItem(
              icon: "assets/images/founded.png",
              text: "${cubit.teamModel!.founded!}"),
        ),
        Expanded(
          child: TeamDetailsItem(
              icon: "assets/images/stade.png", text: cubit.teamModel!.venue!),
        ),
      ],
    );
  }
}

class TeamSquad extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const TeamSquad({Key? key, required this.cubit, required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: grey),
              ),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage("assets/images/squad.png"),
                    color: darkGrey,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Squad",
                      style: TextStyle(
                        color: darkGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PlayerInSquad(
                  cubit: cubit,
                  index: index,
                  leagueID: leagueID,
                ),
            itemCount: cubit.teamModel!.squad!.length)
      ],
    );
  }
}

class PlayerInSquad extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final int index;
  const PlayerInSquad(
      {Key? key,
      required this.cubit,
      required this.index,
      required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      color: index % 2 == 0 ? Colors.grey.withOpacity(0.1) : Colors.white,
      child: InkWell(
        onTap: () {
          cubit.getPlayerAllDetails(
              playerID: cubit.teamModel!.squad![index].id, leagueID: leagueID);
          // cubit.getPlayerDetails(playerID: cubit.teamModel!.squad![index].id);
          Get.to(() => PlayerDetailsScreen(
                leagueID: leagueID,
                teamID: cubit.teamModel!.id!,
                teamName: cubit.teamModel!.name!,
                teamImage: cubit.teamModel!.crestUrl!,
              ));
          print(cubit.teamModel!.squad![index].position!);
        },
        child: Row(
          children: [
            Text(
              "${cubit.teamModel!.squad![index].name}",
              style: TextStyle(
                  color: grey, fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const Spacer(),
            Text(
              "${cubit.teamModel!.squad![index].nationality}",
              style: TextStyle(
                  color: grey, fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamTopScorers extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final int teamID;
  const TeamTopScorers({Key? key, required this.cubit, required this.leagueID, required this.teamID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Scorers> teamScorers = cubit.scorers[leagueID]!.where((element) =>
    element.team!.id==teamID).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: darkGrey),
              ),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage("assets/images/matches.png"),
                    color: darkGrey,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Top Scorers",
                      style: TextStyle(
                        color: darkGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ScorerPlayer(
                  leagueID: leagueID,
                  teamID: teamID,
                  cubit: cubit,
                  scorer: teamScorers[index],
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
            itemCount:teamScorers.length>=10?10:teamScorers.length)
      ],
    );
  }
}

class ScorerPlayer extends StatelessWidget {
  final KickCubit cubit;
  final Scorers scorer;
  final int leagueID;
  final int teamID;

  const ScorerPlayer({
    Key? key,
    required this.scorer,
    required this.cubit,
    required this.leagueID,
    required this.teamID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Teams> teams = cubit.leagues
        .firstWhere((element) => element['id'] == leagueID)['teams'];

    Teams team = teams.firstWhere((element) => element.id == teamID);

    return InkWell(
      onTap: () {
        //cubit.getPlayerDetails(playerID: scorer.player!.id!);
        cubit.getPlayerAllDetails(
            playerID: scorer.player!.id!, leagueID: leagueID);
        Get.to(() => PlayerDetailsScreen(
            leagueID: leagueID,
            teamID: teamID,
            teamName: team.name!,
            teamImage: team.crestUrl!));
      },
      child: Row(
        children: [
          Text(
            "${scorer.player!.name}",
            style: TextStyle(
                color: grey, fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const Spacer(),
          Text(
            "${scorer.numberOfGoals!} Goal",
            style: TextStyle(
                color: grey, fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
