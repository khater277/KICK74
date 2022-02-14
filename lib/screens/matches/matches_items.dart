import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/AllMatchesModel.dart';
import 'package:kick74/models/LeagueTeamsModel.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class LeagueButton extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  const LeagueButton({Key? key, required this.index, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            KickCubit.get(context).changeLeagueIndex(index);
          },
          child: Container(
            decoration: BoxDecoration(
                color: KickCubit.get(context).leagueIndex==index?
                Colors.grey.withOpacity(0.2):offWhite,
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: KickCubit.get(context).leagueIndex==index?havan:grey,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(
                children: [
                  if (index==0) Row(
                    children: [
                      ImageIcon(
                        AssetImage("${cubit.leagues[index]['image']}"),
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                    ],
                  ) else SizedBox(
                      width: 30,height: 30,
                      child: Image.asset("${cubit.leagues[index]['image']}")
                  ),
                  const SizedBox(width: 5),
                  Text("${cubit.leagues[index]['name']}",
                    style: TextStyle(
                        color: darkGrey,fontSize: 16,fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LeagueMatches extends StatelessWidget {
  final KickCubit cubit;
  final List<Matches> matches;
  const LeagueMatches({Key? key, required this.cubit, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAll = cubit.leagueIndex==0;
    return Expanded(
      child: matches.isNotEmpty?
      ListView.separated(
        itemBuilder: (context,index)=> MatchItem(cubit: cubit,index: index,
        matches: matches,),
        separatorBuilder: (context,index)=>const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: DefaultSeparator(),
        ),
        itemCount: matches.length,
      )
          :NoItemsFounded(
          text: "No ${isAll?"":"${cubit.leagues[cubit.leagueIndex]['name']}"}"
              " matches today",
          widget: SizedBox(
            width: 100,height: 100,
            child: ImageIcon(
              AssetImage("${cubit.leagues[cubit.leagueIndex]['image']}"),
              size: 150,
              color: Colors.grey[400],
            ),
          ),
      ),
    );
  }
}

class MatchItem extends StatelessWidget {
  final KickCubit cubit;
  final int index;
  final List<Matches> matches;
  const MatchItem({Key? key, required this.cubit, required this.index, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int leagueIndex = cubit.leagues.indexOf(
        cubit.leagues.firstWhere((element) => element['id']
            ==matches[index].competition!.id)
    );

    int homeTeamID=matches[index].homeTeam!.id!;
    int awayTeamID=matches[index].awayTeam!.id!;
    List<Teams> teams = cubit.leagues[leagueIndex]['teams'];
    Teams homeTeam = teams.firstWhere((element) => element.id==homeTeamID);
    Teams awayTeam = teams.firstWhere((element) => element.id==awayTeamID);

    return Column(
      children: [
        Row(
          children: [
            if(matches[index].status=="POSTPONED")
              Row(
                children: [
                  const SizedBox(width: 5,),
                  Container(
                    width: 100,height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                      child: Text("POSTPONED",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),),
                    ),
                  ),
                ],
              ),
            if(cubit.leagueIndex==0)
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 30, width: 30,
                  child: Image.asset("${cubit.leagues[leagueIndex]['image']}")
                ),
              ),
            )else
            const SizedBox(height: 5,),
            if(matches[index].status=="POSTPONED")
            const SizedBox(width: 105,),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/3,
              child: TeamPicAndName(
                teamName: awayTeam.shortName!,
                teamImage: awayTeam.crestUrl!,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: MatchInfoItem(
                  cubit: cubit,index: index,
                  matches: matches,
                  stadium: homeTeam.venue!,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/3,
              child: TeamPicAndName(
                teamName: homeTeam.shortName!,
                teamImage: homeTeam.crestUrl!,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TeamPicAndName extends StatelessWidget {
  final String teamName;
  final String teamImage;
  const TeamPicAndName({Key? key ,required this.teamName, required this.teamImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        teamImage.endsWith("svg")?DefaultSvgNetworkImage(
            url: teamImage,
            width: 60, height: 60
        ):DefaultFadedImage(
            imgUrl: teamImage,
            width: 60, height: 60
        ),
        const SizedBox(height: 10,),
        Text(
          teamName,
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
  final KickCubit cubit;
  final List<Matches> matches;
  final int index;
  final String stadium;
  const MatchInfoItem({Key? key, required this.cubit, required this.index,
    required this.stadium, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notAll = cubit.leagueIndex!=0;
    return Column(
      children: [
        Text(
          timeFormat(matches[index].utcDate!),
          style: TextStyle(
              color: havan,fontSize: 25,fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: notAll?15:10,),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: havan),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  const AssetImage('assets/images/stade.png'),
                  size: 20,
                  color: darkGrey,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    stadium,
                    style: TextStyle(
                        color: grey,fontSize: 11,fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: notAll?15:10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined,color: darkGrey,size: 17,),
            const SizedBox(width: 5,),
            Text("Fixture ${matches[index].matchday}",
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


