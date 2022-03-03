import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/profile/profile_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  MyPicAndName(cubit: cubit,),
                  const SizedBox(height: 10,),
                  if(cubit.profileImage!=null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: DefaultElevatedButton(
                                child: const Text(
                                    "Update Image",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                ),
                                color: havan,
                                rounded: 30,
                                height: 50,
                                width: double.infinity,
                                onPressed: (){
                                  cubit.setProfileImage();
                                }
                            ),
                          ),
                          if(state is KickSetProfileImageLoadingState
                              ||state is KickUpdateUserDataLoadingState
                              ||state is KickGetUserDataLoadingState)
                            const DefaultLinerIndicator()
                        ],
                      ),
                    ),
                  const SizedBox(height: 20,),
                  FavouritesTeamsHead(cubit: cubit,),
                  //const SizedBox(height: 10,),
                  FavouriteTeams(cubit: cubit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
