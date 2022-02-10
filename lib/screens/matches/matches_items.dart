import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class LeagueButton extends StatelessWidget {
  final int index;
  const LeagueButton({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> leagues = [
      {
        "name":"Champions League",
        "image":"assets/images/cl.png",
      },
      {
        "name":"Premier League",
        "image":"assets/images/pl.png",
      },
      {
        "name":"La Liga Santander",
        "image":"assets/images/laliga.png",
      },
      {
        "name":"Lega Calcio",
        "image":"assets/images/calcio.png",
      },
      {
        "name":"Bundesliga",
        "image":"assets/images/bundesliga.png",
      },
    ];
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: havan,width: 2),
              borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Row(
              children: [
                SizedBox(
                    width: 50,height: 50,
                    child: Image.asset("${leagues[index]['image']}")
                ),
                const SizedBox(width: 5),
                Text("${leagues[index]['name']}",
                  style: TextStyle(
                      color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MatchItem extends StatelessWidget {
  const MatchItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        TeamPicAndName(),
        MatchInfoItem(),
        TeamPicAndName(),
      ],
    );
  }
}

class TeamPicAndName extends StatelessWidget {
  const TeamPicAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DefaultSvgNetworkImage(
            url: 'https://crests.football-data.org/18.svg',
            width: 85, height: 85
        ),
        const SizedBox(height: 5,),
        Text("M'gladbach",
          style: TextStyle(
            color: darkGrey,fontSize: 16,fontWeight: FontWeight.normal
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class MatchInfoItem extends StatelessWidget {
  const MatchInfoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("9:00 PM",
          style: TextStyle(
              color: havan,fontSize: 25,fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: havan),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15.0),
            child: Row(
              children: [
                SizedBox(
                    width: 20,height: 20,
                    child: Image.asset('assets/images/stade.png')
                ),
                const SizedBox(width: 8),
                Text("Anfield",
                  style: TextStyle(
                      color: grey,fontSize: 16,fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Icon(Icons.calendar_today_outlined,color: darkGrey,size: 17,),
            const SizedBox(width: 5,),
            Text("Fixture 24",
              style: TextStyle(
                  color: grey,fontSize: 16,fontWeight: FontWeight.normal
              ),
            ),
          ],
        ),
      ],
    );
  }
}


