import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/models/PlayerAllDetailsModel.dart';
import 'package:kick74/screens/match_details/match_details_items.dart';
import 'package:kick74/screens/team/team_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class PlayerHead extends StatelessWidget {
  final KickCubit cubit;
  final String teamName;
  final String teamImage;
  const PlayerHead(
      {Key? key,
      required this.cubit,
      required this.teamName,
      required this.teamImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ImageIcon(
              const AssetImage("assets/images/player.png"),
              size: 60,
              color: grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${cubit.playerAllDetailsModel!.player!.name} ${cubit.playerAllDetailsModel!.player!.id}",
                  style: TextStyle(
                      color: darkGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                DefaultNetworkImage(url: teamImage, width: 24, height: 24),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  teamName,
                  style: TextStyle(
                      color: grey, fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class PlayerDetailItem extends StatelessWidget {
  final String title;
  final String description;
  const PlayerDetailItem(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: TextStyle(
              color: grey, fontWeight: FontWeight.normal, fontSize: 18),
        ),
        Flexible(
          child: Text(
            description,
            style: TextStyle(
                color: grey, fontWeight: FontWeight.normal, fontSize: 18),
          ),
        )
      ],
    );
  }
}

class PlayerDetails extends StatelessWidget {
  final KickCubit cubit;
  final int teamID;
  const PlayerDetails({Key? key, required this.cubit, required this.teamID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int leagueID;
    bool close = false;

    for (int i = 1; i < 6; i++) {
      List<Teams> teams = cubit.leagues[i]['teams'];
      for (int j = 0; j < teams.length; j++) {
        if (teams[j].id == teamID) {
          close = true;
          leagueID = cubit.leagues[i]['id'];
        }
        if (close) {
          break;
        }
      }
      if (close) {
        break;
      }
    }
    int numberOfGoals = 0;
    try{
      numberOfGoals = cubit.scorers[leagueID]!
          .firstWhere((element) =>
      element.player!.id == cubit.playerAllDetailsModel!.player!.id)
          .numberOfGoals!;
    }catch(e){
      numberOfGoals = 0;
    }

    return Column(
      children: [
        Row(
          children: [
              Flexible(
                  child: PlayerDetailItem(
                      title: "First Name",
                      description:
                          cubit.playerAllDetailsModel!.player!.firstName??"Unknown")),
              Flexible(
                  child: PlayerDetailItem(
                      title: "Last Name",
                      description:
                          cubit.playerAllDetailsModel!.player!.lastName??"Unknown")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
          Row(
            children: [
              Flexible(
                  child: PlayerDetailItem(
                      title: "Born",
                      description:
                          cubit.playerAllDetailsModel!.player!.dateOfBirth??"Unknown")),
              Flexible(
                  child: PlayerDetailItem(
                      title: "Age",
                      description: ageFormat(
                          date: cubit
                              .playerAllDetailsModel!.player!.dateOfBirth??"Unknown"))),
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
              Flexible(
                  child: PlayerDetailItem(
                      title: "Nationality",
                      description:
                          cubit.playerAllDetailsModel!.player!.nationality??"Unknown")),
              Flexible(
                  child: PlayerDetailItem(
                      title: "Country Of Birth",
                      description: cubit
                          .playerAllDetailsModel!.player!.countryOfBirth??"Unknown")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
                child: PlayerDetailItem(
                    title: "Position",
                    description:
                        cubit.playerAllDetailsModel!.player!.position??"Unknown")),
            Flexible(
                child: PlayerDetailItem(
                    title: "Goals this season", description: "$numberOfGoals")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class MatchesPlayedHead extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const MatchesPlayedHead(
      {Key? key, required this.cubit, required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> league =
        cubit.leagues.firstWhere((element) => element['id'] == leagueID);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 30, height: 30, child: Image.asset("${league["image"]}")),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            "${league['name']} matches played (${cubit.playerAllDetailsModel!.count})",
            style: TextStyle(
              color: darkGrey,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class MatchesPlayed extends StatelessWidget {
  final int leagueID;
  final int teamID;
  final KickCubit cubit;
  const MatchesPlayed(
      {Key? key,
      required this.cubit,
      required this.leagueID,
      required this.teamID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerAllDetailsModel playerAllDetailsModel =
        cubit.playerAllDetailsModel!;
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) => BuildMatchInGrid(
              teamID: teamID,
              leagueID: leagueID,
              index: index,
              cubit: cubit,
            ),
        itemCount: playerAllDetailsModel.count);
  }
}

class BuildMatchInGrid extends StatelessWidget {
  //final PlayerAllDetailsModel player;
  final KickCubit cubit;
  final int index;
  final int leagueID;
  final int teamID;
  const BuildMatchInGrid(
      {Key? key,
      required this.index,
      required this.leagueID,
      required this.cubit,
      required this.teamID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerAllDetailsModel player = cubit.playerAllDetailsModel!;
    List<Teams> teams = cubit.leagues
        .firstWhere((element) => element['id'] == leagueID)['teams'];

    Teams homeTeam = teams.firstWhere(
        (element) => element.id == player.matches![index].homeTeam!.id);

    Teams awayTeam = teams.firstWhere(
        (element) => element.id == player.matches![index].awayTeam!.id);

    String winner = player.matches![index].score!.winner!;
    Color? matchStatusColor;
    String? matchStatusLetter;
    if (winner == "AWAY_TEAM") {
      if (teamID == awayTeam.id) {
        matchStatusColor = Colors.green;
        matchStatusLetter = "W";
      } else {
        matchStatusColor = Colors.red;
        matchStatusLetter = "L";
      }
    } else if (winner == "HOME_TEAM") {
      if (teamID == homeTeam.id) {
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
              "Fixture ${player.matches![index].matchday!}",
              style: TextStyle(
                  color: grey, fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
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
                      "${player.matches![index].score!.fullTime!.homeTeam!}",
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
                        "${player.matches![index].score!.fullTime!.awayTeam!}",
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
          ),
        ],
      ),
    );
  }
}
