import 'dart:async';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetUserDataLoadingState &&
                state is! KickGetAllMatchesLoadingState &&
                state is! KickGetFavouritesLoadingState &&
                state is! KickGetLeagueTeamsSuccessState &&

                cubit.leagues[0]['teams'].length == cubit.leaguesIDs.length) {
          return Scaffold(
                body: OfflineWidget(onlineWidget: Builder(
                  builder: (context) {
                    getMatchesRealTime.onData((data) {
                      cubit.getAllMatches(realTime: true);
                    });
                    zeroRequests.onData((data) {
                      cubit.zeroRequests();
                    });
                    return SafeArea(
                        top: true,
                        bottom: false,
                        child: cubit.screens[cubit.currentIndex]);
                  }
                )),
                extendBody: true,
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DotNavigationBar(
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeNavBar(index);
                    },
                    marginR: const EdgeInsets.symmetric(horizontal: 40),
                    dotIndicatorColor: Colors.transparent,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey.shade800,
                    backgroundColor: havan,
                    itemPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    borderRadius: 50,
                    items: [
                      DotNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage('assets/images/user.png'),
                          size: 25,
                        ),
                      ),
                      DotNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage('assets/images/matches.png'),
                          size: 40,
                        ),
                      ),
                      DotNavigationBarItem(
                        icon: const ImageIcon(
                          AssetImage('assets/images/settings.png'),
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              );
        } else {
          return const Scaffold(
                body: DefaultProgressIndicator(icon: IconBroken.Home,size: 35,),
              );
        }
      },
    );
  }
}
