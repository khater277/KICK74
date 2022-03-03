import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/FavouriteTeamModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class LeagueBuilder extends StatelessWidget {
  final Map<String, dynamic> league;
  const LeagueBuilder({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeagueHead(image: league['image'], name: league['name']),
        TeamsBuilder(league: league),
      ],
    );
  }
}

class LeagueHead extends StatelessWidget {
  final String image;
  final String name;
  const LeagueHead({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool ligue1 = image == "assets/images/ligue 1.png";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: grey, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(ligue1 ? 5 : 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: ligue1 ? 50 : 40,
                height: ligue1 ? 50 : 40,
                child: Image.asset(image),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    color: darkGrey, fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TeamsBuilder extends StatelessWidget {
  final Map<String, dynamic> league;
  const TeamsBuilder({
    Key? key,
    required this.league,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<Teams> teams = cubit.leagues[cubit.onBoardingIndex]['teams'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) => BuildTeamInGrid(
          leagueID: league['id'],
          team: league['teams'][index],
          index: index,
        ),
        itemCount: league['teams'].length,
      ),
    );
  }
}

class BuildTeamInGrid extends StatelessWidget {
  final Teams team;
  final int index;
  final int leagueID;
  const BuildTeamInGrid(
      {Key? key,
      required this.team,
      required this.index,
      required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    KickCubit cubit = KickCubit.get(context);
    bool favourite =
        cubit.favouriteTeams.any((element) => element.team!.id == team.id);
    FavouriteTeamModel favouriteTeamModel =
        FavouriteTeamModel(leagueID: leagueID, team: team);
    return InkWell(
      onTap: () {
        favourite =
            cubit.favouriteTeams.any((element) => element.team!.id == team.id);
        if (favourite) {
          cubit.favouriteTeams
              .removeWhere((element) => element.team!.id == team.id);
          cubit.removeFromFavourites(favouriteTeamModel: favouriteTeamModel);
        } else {
          cubit.favouriteTeams.add(favouriteTeamModel);
          cubit.addToFavourites(team: team, leagueID: leagueID);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: favourite ? havan : grey, width: favourite ? 2 : 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: FavouriteTeamPicAndName(
                teamName: team.shortName, teamImage: team.crestUrl)),
      ),
    );
  }
}

class FavouriteTeamPicAndName extends StatelessWidget {
  final String? teamName;
  final String? teamImage;
  const FavouriteTeamPicAndName(
      {Key? key, required this.teamName, required this.teamImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    KickCubit cubit = KickCubit.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultNetworkImage(url: teamImage, width: 60, height: 60),
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
