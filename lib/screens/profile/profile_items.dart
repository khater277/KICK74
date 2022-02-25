import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/FavouriteTeamModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/favourites/favourites_screen.dart';
import 'package:kick74/screens/team/team_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class MyPicAndName extends StatelessWidget {
  final KickCubit cubit;
  const MyPicAndName({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: offWhite,
                    backgroundImage: cubit.profileImage == null
                        ? NetworkImage("${cubit.userModel!.profileImage}")
                        : FileImage(File(cubit.profileImage!.path))
                            as ImageProvider,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        cubit.selectProfileImage();
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: offWhite,
                        child: Icon(
                          IconBroken.Camera,
                          color: Colors.grey.shade800,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${cubit.userModel!.name}",
              style: TextStyle(
                  color: grey, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class FavouritesTeamsHead extends StatelessWidget {
  final KickCubit cubit;
  const FavouritesTeamsHead({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Favourite Teams  (${cubit.favouriteTeams.length})",
            style: TextStyle(
                color: grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Get.to(() => const FavouritesScreen());
            },
            icon: Icon(
              IconBroken.Edit_Square,
              color: darkGrey,
            ))
      ],
    );
  }
}

class FavouriteTeams extends StatelessWidget {
  final KickCubit cubit;
  const FavouriteTeams({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: ListView.separated(
        shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => FavouriteTeam(
                cubit: cubit,
                index: index,
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 30,
              ),
          itemCount: cubit.favouriteTeams.length),
    );
  }
}

class FavouriteTeam extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  const FavouriteTeam({Key? key, required this.cubit, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavouriteTeamModel favouriteTeam = cubit.favouriteTeams[index];

    Map<String,dynamic> league = cubit.leagues.firstWhere((element) =>
    element['id']==favouriteTeam.leagueID!);

    return InkWell(
      onTap: () {
        print(favouriteTeam.leagueID!);
        cubit.getTeamDetails(teamID: favouriteTeam.team!.id,);
        cubit.getTeamAllMatches(teamID: favouriteTeam.team!.id, fromFav: true, league: league);
        //print(cubit.scorers[favouriteTeam.leagueID]![0].player!.name);
        if(cubit.scorers[favouriteTeam.leagueID]!=null) {
          Get.to(() => TeamScreen(leagueID: cubit.favouriteTeams[index].leagueID!,));
        }
      },
      child: Row(
        children: [
          DefaultNetworkImage(
            url: favouriteTeam.team!.crestUrl,
            width: 45,
            height: 45,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "${favouriteTeam.team!.name}",
            style: TextStyle(
                color: grey, fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                cubit.favouriteTeams.removeWhere(
                    (element) => element.team!.id == favouriteTeam.team!.id);
                cubit.removeFromFavourites(favouriteTeamModel: favouriteTeam);
              },
              icon: const Icon(
                IconBroken.Delete,
                color: Colors.red,
                size: 25,
              ))
        ],
      ),
    );
  }
}
