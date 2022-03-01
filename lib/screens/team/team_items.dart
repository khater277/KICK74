import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/league_details/league_details_screen.dart';
import 'package:kick74/screens/player_details/player_details_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';
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
              Get.to(()=>LeagueDetailsScreen(leagueID: leagueID));
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

class SquadAndScorersHead extends StatelessWidget {
  final String icon;
  final String text;
  final Color color;
  const SquadAndScorersHead({Key? key, required this.icon, required this.text,
    required this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              color: darkGrey,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                )),
          ],
        ),
        const SizedBox(height: 2,),
        Divider(
          thickness: 2,
          color: color,
        )
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => PlayerInSquad(
              cubit: cubit,
              index: index,
              leagueID: leagueID,
            ),
        itemCount: cubit.teamModel!.squad!.length);
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
    return InkWell(
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        color: index % 2 == 0 ? Colors.grey.withOpacity(0.1) : Colors.white,
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ScorerPlayer(
          index: index,
              leagueID: leagueID,
              teamID: teamID,
              cubit: cubit,
              scorer: teamScorers[index],
            ),
        itemCount:teamScorers.length);
  }
}

class ScorerPlayer extends StatelessWidget {
  final KickCubit cubit;
  final Scorers scorer;
  final int leagueID;
  final int teamID;
  final int index;

  const ScorerPlayer({
    Key? key,
    required this.scorer,
    required this.cubit,
    required this.leagueID,
    required this.teamID, required this.index,
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        color: index % 2 == 0 ? Colors.grey.withOpacity(0.1) : Colors.white,
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
      ),
    );
  }
}

class TeamMatchesHead extends StatelessWidget {
  final String image;
  final String name;
  const TeamMatchesHead({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: grey,),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 35,height: 35,
                child: Image.asset(image),
              ),
              const SizedBox(width: 10,),
              Text("$name matches",
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class TeamMatches extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const TeamMatches({Key? key, required this.cubit, required this.leagueID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 1.18,
        ),
        itemBuilder: (context, index) =>
            MatchInTeamMatches(
            cubit: cubit,
            index: index,
          leagueID: leagueID,
        ),
        itemCount: cubit.teamMatches.length
    );
  }
}

class MatchInTeamMatches extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final int leagueID;
  const MatchInTeamMatches({Key? key, required this.cubit, required this.index, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int leagueIndex = cubit.leaguesIDs.indexOf(leagueID)+1;
    List<Teams> teams = cubit.leagues[leagueIndex]['teams'];

    Teams homeTeam = teams.firstWhere((element) =>
    element.id==cubit.teamMatches[index].homeTeam!.id!);

    Teams awayTeam = teams.firstWhere((element) =>
    element.id==cubit.teamMatches[index].awayTeam!.id!);

    String winner = "${cubit.teamMatches[index].score!.winner}";
    Color? matchStatusColor;
    String? matchStatusLetter;
    if (winner == "AWAY_TEAM") {
      if (cubit.teamModel!.id == awayTeam.id) {
        matchStatusColor = Colors.green;
        matchStatusLetter = "W";
      } else {
        matchStatusColor = Colors.red;
        matchStatusLetter = "L";
      }
    } else if (winner == "HOME_TEAM") {
      if (cubit.teamModel!.id == homeTeam.id) {
        matchStatusColor = Colors.green;
        matchStatusLetter = "W";
      } else {
        matchStatusColor = Colors.red;
        matchStatusLetter = "L";
      }
    } else {
      matchStatusColor = havan;
      matchStatusLetter = "D";
    }

    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "Fixture ${cubit.teamMatches[index].matchday}",
              style: TextStyle(
                  color: grey, fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
          if(cubit.teamMatches[index].status=="FINISHED")
            FinishedMatch(cubit: cubit, index: index, homeTeam: homeTeam, awayTeam: awayTeam,
                matchStatusColor: matchStatusColor, matchStatusLetter: matchStatusLetter)
          else if(cubit.teamMatches[index].status=="IN_PLAY"||cubit.teamMatches[index].status=="PAUSED")
            InPlayMatch(cubit: cubit, index: index, homeTeam: homeTeam, awayTeam: awayTeam)
          else if(cubit.teamMatches[index].status=="POSTPONED")
            PostponedMatch(cubit: cubit, index: index, homeTeam: homeTeam, awayTeam: awayTeam)
          else
            ScheduledMatch(cubit: cubit, index: index, homeTeam: homeTeam, awayTeam: awayTeam),
        ],
      ),
    );
  }
}

class FinishedMatch extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  final Color matchStatusColor;
  final String matchStatusLetter;
  const FinishedMatch({Key? key, required this.cubit, required this.index, required this.homeTeam,
    required this.awayTeam, required this.matchStatusColor, required this.matchStatusLetter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultNetworkImage(
                      url: homeTeam.crestUrl, width: 30, height: 30),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${cubit.teamMatches[index].score!.fullTime!.homeTeam!}",
                    style: TextStyle(
                        color: grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: matchStatusColor,width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Text(
                  matchStatusLetter,
                  style: TextStyle(
                      fontSize: 12,
                      color: matchStatusColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultNetworkImage(
                    url: awayTeam.crestUrl, width: 30, height: 30),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${cubit.teamMatches[index].score!.fullTime!.awayTeam!}",
                  style: TextStyle(
                      color: grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InPlayMatch extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const InPlayMatch({Key? key, required this.cubit, required this.index, required this.homeTeam,
    required this.awayTeam,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultNetworkImage(
                      url: homeTeam.crestUrl, width: 30, height: 30),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${cubit.teamMatches[index].score!.fullTime!.homeTeam!}",
                    style: TextStyle(
                        color: grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5)
            ),
            child: const Text(
              "Live",
              style: TextStyle(
                  color: Colors.white,
                fontSize:15,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultNetworkImage(
                    url: awayTeam.crestUrl, width: 30, height: 30),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${cubit.teamMatches[index].score!.fullTime!.awayTeam!}",
                  style: TextStyle(
                      color: grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostponedMatch extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const PostponedMatch({Key? key, required this.cubit, required this.index, required this.homeTeam,
    required this.awayTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultNetworkImage(
                          url: homeTeam.crestUrl, width: 30, height: 30),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultNetworkImage(
                        url: awayTeam.crestUrl, width: 30, height: 30),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
              decoration: BoxDecoration(
                  color: havan,
                  borderRadius: BorderRadius.circular(3)
              ),
              child: const Text(
                "POSTPONED",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduledMatch extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final Teams homeTeam;
  final Teams awayTeam;
  const ScheduledMatch({Key? key, required this.cubit, required this.index, required this.homeTeam,
    required this.awayTeam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeFormat(cubit.teamMatches[index].utcDate!),
            style: TextStyle(
                fontSize: 13,
                color: darkGrey,
                fontWeight: FontWeight.normal
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultNetworkImage(
                          url: homeTeam.crestUrl, width: 30, height: 30),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultNetworkImage(
                        url: awayTeam.crestUrl, width: 30, height: 30),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //const SizedBox(height: 3,),
          Text(
            cubit.teamMatches[index].utcDate!.substring(0,10),
            style: TextStyle(
                fontSize: 13,
                color: darkGrey,
                fontWeight: FontWeight.normal
            ),
          ),
          const SizedBox(height: 2,),
        ],
      ),
    );
  }
}