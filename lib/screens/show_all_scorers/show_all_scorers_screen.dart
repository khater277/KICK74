import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/league_details/league_details_items.dart';
import 'package:kick74/screens/league_scorers/league_scorers_items.dart';
import 'package:kick74/shared/default_widgets.dart';

class ShowAllScorersScreen extends StatelessWidget {
  final int leagueID;
  const ShowAllScorersScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
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
                  StandingHead(cubit: cubit, leagueID: leagueID),
                  const SizedBox(height: 20,),
                  const ScorersDetails(),
                  const SizedBox(height: 20,),
                  ScorersBody(cubit: cubit, leagueID: leagueID,length: cubit.scorers[leagueID]!.length,),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


