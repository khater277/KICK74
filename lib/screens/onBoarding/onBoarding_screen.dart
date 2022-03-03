import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/onBoarding/onBoarding_Items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetUserDataLoadingState &&
                state is! KickGetAllMatchesLoadingState &&
                cubit.leagues[0]['teams'].length == cubit.leaguesIDs.length) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Select your favourite teams",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkGrey,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (cubit.onBoardingIndex < 5) {
                      cubit.changeOnBoardingIndex();
                      print("FAVOURITES DONE");
                    } else {
                      onBoarding = true;
                      GetStorage().write('onBoarding', true);
                      cubit.getFavourites();
                      Get.offAll(() => const HomeScreen());
                    }
                  },
                  icon: Icon(IconBroken.Arrow___Right_2,
                      color: havan, size: 25),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
                body: OfflineWidget(onlineWidget: Column(
                  children: [
                    TeamsBuilder(
                      cubit: cubit,
                      state: state,
                    ),
                    IndicatorBuilder(
                      cubit: cubit,
                    ),
                  ],
                )),
              );
        } else {
          return const Scaffold(
                body: DefaultProgressIndicator(icon: IconBroken.Heart,size: 35,),
              );
        }
      },
    );
  }
}
