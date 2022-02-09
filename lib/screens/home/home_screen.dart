import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/home/home_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        return state is! KickGetUserDataLoadingState?
          Scaffold(
          appBar: AppBar(
            actions: [
              LogOutButton(cubit:cubit),
            ],
          ),
          body: Center(
            child: Text(
              "${cubit.userModel!.name}",
              style: const TextStyle(fontSize: 30),),
          ),
        ):
        const Scaffold(
          body: DefaultProgressIndicator(icon: IconBroken.Home),
        );
      },
    );
  }
}
