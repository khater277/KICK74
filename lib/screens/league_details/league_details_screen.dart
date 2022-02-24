import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/league_details/league_details_items.dart';
import 'package:kick74/screens/league_scorers/league_scorers_screen.dart';
import 'package:kick74/screens/league_standing/league_standing_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';
import 'package:kick74/models/LeagueStandingModel.dart' as standing;

class LeagueDetailsScreen extends StatelessWidget {
  final int leagueID;
  const LeagueDetailsScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        final visableNotifier = ValueNotifier<bool>(true);
        if (state is! KickGetLeagueStandingsLoadingState) {
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    StandingHead(cubit: cubit, leagueID: leagueID),
                    const SizedBox(height: 20,),
                     Row(
                       children: [
                         Expanded(
                             child: InkWell(
                               onTap:(){
                                 visableNotifier.value = true;
                                 //cubit.standingAndScorersToggle(standing: true, scorers: false);
                               },
                               child: Column(
                                 children: [
                                   const StandingAndScorers(text: "Standing"),
                                   const SizedBox(height: 5,),
                                   ValueListenableBuilder(
                                     valueListenable: visableNotifier,
                                     builder: (BuildContext context, bool value, Widget? child) {
                                       return Divider(
                                         thickness: 2,
                                         color:value?havan:Colors.white,
                                       );
                                     },
                                   )
                                 ],
                               ),
                             )),
                         Expanded(
                             child: InkWell(
                               onTap:(){
                                 visableNotifier.value = false;
                                 //cubit.standingAndScorersToggle(standing: false, scorers: true);
                               },
                               child: Column(
                                 children: [
                                   const StandingAndScorers(text: "Scorers"),
                                   const SizedBox(height: 5,),
                                   ValueListenableBuilder(
                                     valueListenable: visableNotifier,
                                     builder: (BuildContext context, bool value, Widget? child) {
                                       return Divider(
                                         thickness: 2,
                                         color:value?Colors.white:havan,
                                       );
                                     },
                                   )
                                 ],
                               ),
                             )),
                       ],
                     ),
                    const SizedBox(height: 20,),
                    ValueListenableBuilder(
                      valueListenable: visableNotifier,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Column(
                          children: [
                            const SizedBox(height: 10,),
                            if(value)
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
