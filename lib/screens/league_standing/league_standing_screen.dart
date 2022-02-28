import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/screens/league_standing/league_standing_items.dart';


class LeagueStandingScreen extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const LeagueStandingScreen({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const StandingDetails(),
            //const SizedBox(height: 20,),
            StandingBody(cubit: cubit, leagueID: leagueID),
          ],
        )
    );
  }
}
