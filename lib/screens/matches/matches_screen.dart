import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/matches/matches_items.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=> LeagueButton(index: index,cubit: cubit,),
                      separatorBuilder: (context,index)=>const SizedBox(width: 15,),
                      itemCount: 6
                  ),
                ),
              ),
              LeagueMatches(
                cubit: cubit,
                matches: cubit.leagueIndex==0?cubit.shownMatches[0]!:
                cubit.shownMatches[cubit.leaguesIDs[cubit.leagueIndex-1]]!,
              ),
            ],
          ),
        );
      },
    );
  }
}
