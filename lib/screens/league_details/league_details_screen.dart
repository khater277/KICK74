import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/league_details/league_details_items.dart';
import 'package:kick74/screens/league_scorers/league_scorers_screen.dart';
import 'package:kick74/screens/league_standing/league_standing_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';


class LeagueDetailsScreen extends StatelessWidget {
  final int leagueID;
  const LeagueDetailsScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetLeagueStandingsLoadingState&&cubit.leaguesStandings[leagueID]!.isNotEmpty) {
          return Scaffold(
            body: OfflineWidget(onlineWidget: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight: 250.0,
                  leading: const BuildBackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    //title: Text('SliverAppBar'),
                    background: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: StandingHead(cubit: cubit, leagueID: leagueID),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          const SizedBox(height: 20,),
                          ValueListenableBuilder(
                            valueListenable: valueNotifier,
                            builder: (BuildContext context, value, Widget? child) {
                              return Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                        onTap:(){
                                          valueNotifier.value=true;
                                          //cubit.standingAndScorersToggle(standing: true, scorers: false);
                                        },
                                        child: Column(
                                          children: [
                                            const StandingAndScorers(text: "Standing"),
                                            const SizedBox(height: 5,),
                                            Divider(
                                              thickness: 2,
                                              color:valueNotifier.value?havan:Colors.white,
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      child: InkWell(
                                        onTap:(){
                                          valueNotifier.value=false;
                                          //cubit.standingAndScorersToggle(standing: false, scorers: true);
                                        },
                                        child: Column(
                                          children: [
                                            const StandingAndScorers(text: "Scorers"),
                                            const SizedBox(height: 5,),
                                            Divider(
                                              thickness: 2,
                                              color:valueNotifier.value?Colors.white:havan,
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20,),
                          ValueListenableBuilder(
                            valueListenable: valueNotifier,
                            builder: (BuildContext context, value, Widget? child) {
                              return Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  if(valueNotifier.value)
                                    LeagueStandingScreen(cubit: cubit, leagueID: leagueID)
                                  else
                                    LeagueScorersScreen(cubit: cubit, leagueID: leagueID),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            )),
          );
        } else {
          return const Scaffold(
            body: DefaultProgressIndicator(icon: IconBroken.Document, size: 35),
          );
        }
      },
    );
  }
}
