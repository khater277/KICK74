import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/team/team_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class TeamScreen extends StatelessWidget {
  final int leagueID;
  const TeamScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   ValueNotifier<bool> isSquad = ValueNotifier<bool>(true);
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        Map<String,dynamic> league = cubit.leagues.firstWhere((element) =>
        element['id']==leagueID);
        if (state is! KickGetTeamDetailsLoadingState &&
            state is! KickGetLeagueTopScorersLoadingState &&
            state is! KickGetTeamAllMatchesLoadingState &&
            cubit.teamMatches.isNotEmpty&&
            cubit.teamModel!=null
        ) {
          return Scaffold(
            body: OfflineWidget(onlineWidget: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight: 220.0,
                  leading: const BuildBackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    //title: Text('SliverAppBar'),
                    background: Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: TeamHead(cubit: cubit),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          FoundedAndStadium(cubit: cubit,leagueID: leagueID,),
                          const SizedBox(
                            height: 30,
                          ),
                          TeamDetailsItem(
                              icon: "assets/images/location.png",
                              text: "${cubit.teamModel!.address}"),
                          const SizedBox(
                            height: 20,
                          ),
                          TeamDetailsItem(
                              icon: "assets/images/phone.png",
                              text: "${cubit.teamModel!.phone}"),
                          const SizedBox(
                            height: 20,
                          ),
                          TeamDetailsItem(
                              icon: "assets/images/email.png",
                              text: "${cubit.teamModel!.email}"),
                          const SizedBox(
                            height: 20,
                          ),
                          TeamDetailsItem(
                              isLink: true,
                              icon: "assets/images/website.png",
                              text: "${cubit.teamModel!.website}"),
                          const SizedBox(
                            height: 40,
                          ),
                          TeamMatchesHead(image: league['image'], name: league['name']),
                          //const SizedBox(height: 20,),
                          TeamMatches(cubit: cubit, leagueID: leagueID),
                          const SizedBox(height: 50,),
                          ValueListenableBuilder(
                            valueListenable: isSquad,
                            builder: (BuildContext context, bool value, Widget? child) {
                              return Row(
                                children: [
                                  Expanded(
                                      child: TextButton(
                                        onPressed: (){
                                          isSquad.value=true;
                                          print("${isSquad.value}");
                                        },
                                        child: SquadAndScorersHead(
                                          icon: "assets/images/player.png",
                                          text: "Squad",
                                          color: isSquad.value?havan:Colors.white,
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      child: TextButton(
                                        onPressed: (){
                                          isSquad.value=false;
                                          print("${isSquad.value}");
                                        },
                                        child:  SquadAndScorersHead(
                                          icon: "assets/images/matches.png",
                                          text: "Top scorers",
                                          color: !isSquad.value?havan:Colors.white,
                                        ),
                                      )
                                  ),
                                ],
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: isSquad,
                            builder: (BuildContext context, value, Widget? child) {
                              if(isSquad.value) {
                                return TeamSquad(
                                  cubit: cubit,
                                  leagueID: leagueID,
                                );
                              } else {
                                return TeamTopScorers(
                                    cubit: cubit,
                                    leagueID: leagueID,
                                    teamID: cubit.teamModel!.id!
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),),
          );
        } else {
          return const Scaffold(
            body: DefaultProgressIndicator(icon: IconBroken.Ticket,size: 35,),
          );
        }
      },
    );
  }
}