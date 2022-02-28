import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/screens/league_scorers/league_scorers_items.dart';
import 'package:kick74/screens/show_all_scorers/show_all_scorers_screen.dart';
import 'package:kick74/shared/constants.dart';


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
            ScorersBody(cubit: cubit, leagueID: leagueID,length: 20,),
            const SizedBox(height: 10,),
            TextButton(
                onPressed:(){
                  Get.to(()=>ShowAllScorersScreen(leagueID: leagueID));
                },
                child: Text(
                  "view all",
                  style: TextStyle(
                    color: havan,
                    fontSize: 20
                  ),
                )
            )
          ],
        ));
  }
}
