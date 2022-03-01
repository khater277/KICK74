import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/league_details/league_details_screen.dart';
import 'package:kick74/screens/player_details/player_details_screen.dart';
import 'package:kick74/screens/team/team_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class Head2Head extends StatelessWidget {
  const Head2Head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: grey)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            "Last 10 Matches",
            style: TextStyle(
                fontSize: 20, color: grey, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}

class TeamPicAndName extends StatelessWidget {
  final int leagueID;
  final int teamID;
  final String teamName;
  final String teamImage;
  const TeamPicAndName(
      {Key? key,
      required this.teamName,
      required this.teamImage,
      required this.teamID, required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> league = KickCubit.get(context).leagues.firstWhere((element) =>
    element['id']==leagueID);
    return InkWell(
      onTap: () {
        KickCubit.get(context).getTeamDetails(teamID: teamID);
        KickCubit.get(context).getTeamAllMatches(teamID: teamID, fromFav: false, league: league);
        //List<Scorers> teamScorers = KickCubit.get(context).scorers[leagueID]!;
        Get.to(() => TeamScreen(leagueID: leagueID,));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          teamImage.endsWith("svg")
              ? DefaultSvgNetworkImage(url: teamImage, width: 60, height: 60)
              : DefaultFadedImage(imgUrl: teamImage, width: 60, height: 60),
          const SizedBox(
            height: 10,
          ),
          Text(
            teamName,
            style: TextStyle(
                color: darkGrey, fontSize: 16, fontWeight: FontWeight.normal),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class Head2HeadMatches extends StatelessWidget {
  final KickCubit cubit;
  final bool? isHomeTeam;
  final String matchesStatus;
  const Head2HeadMatches(
      {Key? key,
      required this.isHomeTeam,
      required this.matchesStatus,
      required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isHomeTeam == null
              ? "${cubit.matchDetailsModel!.head2head!.homeTeam!.draws}"
              : isHomeTeam == true
                  ? "${cubit.matchDetailsModel!.head2head!.homeTeam!.wins}"
                  : "${cubit.matchDetailsModel!.head2head!.awayTeam!.wins}",
          style:
              TextStyle(color: grey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          matchesStatus,
          style: TextStyle(
              color: havan, fontWeight: FontWeight.normal, fontSize: 22),
        ),
      ],
    );
  }
}

class Head2HeadDetails extends StatelessWidget {
  final KickCubit cubit;
  const Head2HeadDetails({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Head2HeadMatches(cubit: cubit, isHomeTeam: false, matchesStatus: "win"),
        const SizedBox(
          width: 30,
        ),
        Head2HeadMatches(cubit: cubit, isHomeTeam: null, matchesStatus: "draw"),
        const SizedBox(
          width: 30,
        ),
        Head2HeadMatches(cubit: cubit, isHomeTeam: true, matchesStatus: "win"),
      ],
    );
  }
}

class MatchInfoItem extends StatelessWidget {
  final String icon;
  final String text;
  const MatchInfoItem({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(icon),
          color: havan,
          size: icon=="assets/images/calendar.png"?25:30,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(
              color: grey, fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class MatchInfo extends StatelessWidget {
  final KickCubit cubit;
  const MatchInfo({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int leagueID = cubit.matchDetailsModel!.match!.competition!.id!;
    Map<String, dynamic> league =
        cubit.leagues.firstWhere((element) => element['id'] == leagueID);

    bool referee = cubit.matchDetailsModel!.match!.referees!.isNotEmpty;

    String refereeName = referee == true
        ? cubit.matchDetailsModel!.match!.referees!
            .firstWhere((element) => element.role == "REFEREE")
            .name!
        : "";

    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                cubit.getLeagueStandings(leagueID: leagueID);
                Get.to(()=>LeagueDetailsScreen(leagueID: leagueID));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 35,
                          height: 35,
                          child: Image.asset("${league['image']}")),
                      const SizedBox(width: 15),
                      Text(
                        "${league['name']}",
                        style: TextStyle(
                            fontSize: 18,
                            color: grey,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MatchInfoItem(
                        icon: "assets/images/clock.png",
                        text: timeFormat(
                            cubit.matchDetailsModel!.match!.utcDate!)),
                  ),
                  Expanded(
                    child: MatchInfoItem(
                        icon: "assets/images/calendar.png",
                        text:
                            "Fixture ${cubit.matchDetailsModel!.match!.matchday}"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MatchInfoItem(
                  icon: "assets/images/stade.png",
                  text: "${cubit.matchDetailsModel!.match!.venue}"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MatchInfoItem(
                      icon: "assets/images/referee.png",
                      text: referee ? refereeName : "Unknown",
                    ),
                  ),
                  if (referee)
                    Expanded(
                        child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("${league['country']}"),
                    ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TeamBestPlayer extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  final Teams homeTeam;
  final Teams awayTeam;
  const TeamBestPlayer(
      {Key? key,
      required this.cubit,
      required this.leagueID,
      required this.homeTeam,
      required this.awayTeam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scorers homePlayer = cubit.scorers[leagueID]!
        .firstWhere((element) => element.team!.id == homeTeam.id);

    Scorers awayPlayer = cubit.scorers[leagueID]!
        .firstWhere((element) => element.team!.id == awayTeam.id);
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: grey)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage('assets/images/matches.png'),
                      color: grey,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Top Scorers",
                      style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              BestPlayer(
                isHome: false,
                scorer: awayPlayer,
                teamID: awayTeam.id!,
                leagueID: leagueID,
                teamImage: awayTeam.crestUrl!,
                teamName: awayTeam.name!,
                cubit: cubit,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: BestPlayer(
                  isHome: true,
                  scorer: homePlayer,
                  teamID: homeTeam.id!,
                  leagueID: leagueID,
                  teamImage: homeTeam.crestUrl!,
                  teamName: homeTeam.name!,
                  cubit: cubit,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BestPlayer extends StatelessWidget {
  final KickCubit cubit;
  final Scorers scorer;
  final int teamID;
  final int leagueID;
  final String teamImage;
  final String teamName;
  final bool isHome;
  const BestPlayer(
      {Key? key,
      required this.scorer,
      required this.teamImage,
      required this.isHome,
      required this.cubit,
      required this.teamName,
      required this.teamID,
      required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Player? player = scorer.player!;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.getPlayerAllDetails(
                        playerID: scorer.player!.id!, leagueID: leagueID);
                    // cubit.getPlayerDetails(playerID: scorer.player!.id!);
                    Get.to(() => PlayerDetailsScreen(
                          leagueID: leagueID,
                          teamID: teamID,
                          teamName: teamName,
                          teamImage: teamImage,
                        ));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                          width: 30,
                          height: 30,
                          child: DefaultNetworkImage(
                              url: teamImage, width: 30, height: 30)),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text(
                          "${player.name}",
                          style: TextStyle(
                              color: grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TopScorerDetails(
              isGoals: isHome,
              icon: "assets/images/goal.png",
              property: "${scorer.numberOfGoals!} Goals"),
          const SizedBox(
            height: 10,
          ),
          TopScorerDetails(
              icon: "assets/images/position.png",
              property: "${player.position}"),
          const SizedBox(
            height: 10,
          ),
          TopScorerDetails(
              isGoals: isHome,
              icon: "assets/images/age.png",
              property: ageFormat(date: "${player.dateOfBirth}")),
          const SizedBox(
            height: 10,
          ),
          TopScorerDetails(
              icon: "assets/images/country.png",
              property: "${player.nationality}"),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TopScorerDetails extends StatelessWidget {
  final String icon;
  final String property;
  bool? isGoals;
  TopScorerDetails(
      {Key? key, required this.icon, required this.property, this.isGoals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(icon),
          color: Colors.grey,
          size: 25,
        ),
        const SizedBox(
          width: 20,
        ),
        Directionality(
          textDirection:
              isGoals == false ? TextDirection.ltr : TextDirection.rtl,
          child: Text(
            property,
            style: TextStyle(
                color: grey, fontWeight: FontWeight.normal, fontSize: 20),
          ),
        ),
      ],
    );
  }
}

String ageFormat({@required String? date}) {
  int dateYear = int.parse(date!.substring(0, 4));
  int nowYear = DateTime.now().year;
  int age = nowYear - dateYear;
  return "$age Years old";
}
