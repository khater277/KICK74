import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/player_details/player_details_items.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final int leagueID;
  final int teamID;
  final String teamName;
  final String teamImage;
  const PlayerDetailsScreen(
      {Key? key,
      required this.teamName,
      required this.teamImage,
      required this.teamID,
      required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetPlayerAllDetailsLoadingState) {
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    PlayerHead(
                      teamName: teamName,
                      teamImage: teamImage,
                      cubit: cubit,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    PlayerDetails(
                      teamID: teamID,
                      cubit: cubit,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MatchesPlayedHead(cubit: cubit, leagueID: leagueID),
                    const SizedBox(
                      height: 30,
                    ),
                    MatchesPlayed(
                      cubit: cubit,
                      leagueID: leagueID,
                      teamID: teamID,
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: DefaultProgressIndicator(icon: IconBroken.Activity,size: 35,),
          );
        }
      },
    );
  }
}
