import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class IndicatorBuilder extends StatelessWidget {
  final KickCubit cubit;
  const IndicatorBuilder({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                LeaguesIndicator(
                  image: cubit.leagues[1]['image'],
                ),
                IndicatorBar(
                  color: cubit.indicatorColors[0],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                LeaguesIndicator(
                  image: cubit.leagues[2]['image'],
                ),
                IndicatorBar(
                  color: cubit.indicatorColors[1],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                LeaguesIndicator(
                  image: cubit.leagues[3]['image'],
                ),
                IndicatorBar(
                  color: cubit.indicatorColors[2],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                LeaguesIndicator(
                  image: cubit.leagues[4]['image'],
                ),
                IndicatorBar(
                  color: cubit.indicatorColors[3],
                ),
              ],
            ),
          ),
          LeaguesIndicator(
            image: cubit.leagues[5]['image'],
          ),
        ],
      ),
    );
  }
}

class LeaguesIndicator extends StatelessWidget {
  final String image;
  const LeaguesIndicator({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool laLiga = image == "assets/images/laliga.png";
    bool ligue1 = image == "assets/images/ligue 1.png";
    return SizedBox(
        width: laLiga
            ? 32
            : ligue1
                ? 40
                : 35,
        height: laLiga
            ? 32
            : ligue1
                ? 40
                : 35,
        child: Image.asset(image));
  }
}

class IndicatorBar extends StatelessWidget {
  final Color color;
  const IndicatorBar({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Container(
          height: 2,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }
}

class TeamsBuilder extends StatelessWidget {
  final KickCubit cubit;
  final KickStates state;
  const TeamsBuilder({Key? key, required this.cubit, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Teams> teams = cubit.leagues[cubit.onBoardingIndex]['teams'];
    return Expanded(
        child: state is! KickOnBoardingIndexLoadingState
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    //mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) => BuildTeamInGrid(
                    leagueID: cubit.leagues[cubit.onBoardingIndex]['id'],
                    team: teams[index],
                    cubit: cubit,
                    index: index,
                  ),
                  itemCount:
                      cubit.leagues[cubit.onBoardingIndex]['teams'].length,
                ),
              )
            : const DefaultProgressIndicator(icon: IconBroken.Heart,size: 35,));
  }
}

class BuildTeamInGrid extends StatelessWidget {
  final KickCubit cubit;
  final Teams team;
  final int leagueID;
  final int index;
  const BuildTeamInGrid(
      {Key? key, required this.team, required this.cubit, required this.index, required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cubit.selectOnBoardingFavourite(index: index, teamID: team.id, leagueID: leagueID);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: cubit.selectedTeamsIDs.contains(team.id) ? havan : grey,
                width: cubit.selectedTeamsIDs.contains(team.id) ? 3 : 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: OnBoardingTeamPicAndName(
                  teamName: team.shortName, teamImage: team.crestUrl)),
        ),
      ),
    );
  }
}

class OnBoardingTeamPicAndName extends StatelessWidget {
  final String? teamName;
  final String? teamImage;
  const OnBoardingTeamPicAndName(
      {Key? key, required this.teamName, required this.teamImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    KickCubit cubit = KickCubit.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultNetworkImage(url: teamImage, width: 50, height: 50),
        const SizedBox(
          height: 15,
        ),
        Text(
          teamName!,
          style: TextStyle(
              color: darkGrey, fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
