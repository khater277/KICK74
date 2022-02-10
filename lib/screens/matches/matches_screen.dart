import 'package:flutter/material.dart';
import 'package:kick74/screens/matches/matches_items.dart';
import 'package:kick74/shared/default_widgets.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=> LeagueButton(index: index,),
                  separatorBuilder: (context,index)=>const SizedBox(width: 15,),
                  itemCount: 5
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context,index)=>const MatchItem(),
                separatorBuilder: (context,index)=>const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: DefaultSeparator(),
                ),
                itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
