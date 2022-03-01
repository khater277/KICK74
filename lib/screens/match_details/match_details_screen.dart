import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/screens/match_details/match_details_items.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class MatchDetailsScreen extends StatelessWidget {
  final int leagueID;
  final Teams homeTeam;
  final Teams awayTeam;

  const MatchDetailsScreen(
      {Key? key,
      required this.homeTeam,
      required this.awayTeam,
      required this.leagueID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const BuildBackButton(),
          ),
          body: state is! KickGetMatchDetailsLoadingState &&
                  state is! KickGetLeagueTopScorersLoadingState &&
                  cubit.matchDetailsModel != null
              ? OfflineWidget(
                  onlineWidget: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Head2Head(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TeamPicAndName(
                                    leagueID: leagueID,
                                    teamID: awayTeam.id!,
                                    teamName: awayTeam.shortName!,
                                    teamImage: awayTeam.crestUrl!),
                                Head2HeadDetails(cubit: cubit),
                                TeamPicAndName(
                                    leagueID: leagueID,
                                    teamID: homeTeam.id!,
                                    teamName: homeTeam.shortName!,
                                    teamImage: homeTeam.crestUrl!),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MatchInfo(cubit: cubit),
                            const SizedBox(
                              height: 30,
                            ),
                            TeamBestPlayer(
                                cubit: cubit,
                                leagueID: leagueID,
                                homeTeam: homeTeam,
                                awayTeam: awayTeam),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              : const DefaultProgressIndicator(
                  icon: IconBroken.Work,
                  size: 35,
                ),
        );
      },
    );
  }
}
