import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/models/LeagueScorersModel.dart';
import 'package:kick74/screens/team/team_items.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class TeamScreen extends StatelessWidget {
  final int leagueID;
  const TeamScreen({Key? key, required this.leagueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        if (state is! KickGetTeamDetailsLoadingState &&
            state is! KickGetLeagueTopScorersLoadingState &&
            state is! KickGetTeamAllMatchesLoadingState
        ) {
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      TeamHead(cubit: cubit),
                      const SizedBox(
                        height: 30,
                      ),
                      FoundedAndStadium(cubit: cubit,leagueID: leagueID,),
                      const SizedBox(
                        height: 30,
                      ),
                      TeamDetailsItem(
                          icon: "assets/images/location.png",
                          text: cubit.teamModel!.address!),
                      const SizedBox(
                        height: 20,
                      ),
                      TeamDetailsItem(
                          icon: "assets/images/phone.png",
                          text: cubit.teamModel!.phone!),
                      const SizedBox(
                        height: 20,
                      ),
                      TeamDetailsItem(
                          icon: "assets/images/email.png",
                          text: cubit.teamModel!.email!),
                      const SizedBox(
                        height: 20,
                      ),
                      TeamDetailsItem(
                          isLink: true,
                          icon: "assets/images/website.png",
                          text: cubit.teamModel!.website!),
                      const SizedBox(
                        height: 30,
                      ),
                      TeamTopScorers(
                          cubit: cubit,
                          leagueID: leagueID,
                      teamID: cubit.teamModel!.id!,),
                      const SizedBox(
                        height: 30,
                      ),
                      TeamSquad(
                        cubit: cubit,
                        leagueID: leagueID,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: DefaultProgressIndicator(icon: IconBroken.Ticket,size: 35,),
          );
        }
      },
    );
  }
}
