import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/league_standing/league_standing_items.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class LeagueStandingScreen extends StatelessWidget {
  final int leagueID;
  const LeagueStandingScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetLeagueStandingsLoadingState) {
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    StandingHead(cubit: cubit, leagueID: leagueID),
                    const SizedBox(height: 40,),
                    const StandingDetails(),
                    const SizedBox(height: 20,),
                    StandingBody(cubit: cubit, leagueID: leagueID),
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
