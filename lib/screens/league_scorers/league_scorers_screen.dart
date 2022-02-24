import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/screens/league_scorers/league_scorers_items.dart';


class LeagueScorersScreen extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const LeagueScorersScreen({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const ScorersDetails(),
            const SizedBox(height: 20,),
            ScorersBody(cubit: cubit, leagueID: leagueID),
          ],
        ));
  }
}
