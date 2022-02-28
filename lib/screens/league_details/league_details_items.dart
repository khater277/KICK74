import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/shared/constants.dart';

class StandingHead extends StatelessWidget {
  final KickCubit cubit;
  final int leagueID;
  const StandingHead({Key? key, required this.cubit, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> league = cubit.leagues.firstWhere((element) => element['id']==leagueID);
    return Center(
      child: SizedBox(
        width: 200,height: 200,
          child: Image.asset("${league['image']}")
      ),
    );
  }
}

class StandingAndScorers extends StatelessWidget {
  final String text;
  const StandingAndScorers({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: darkGrey,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }
}

