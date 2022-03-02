import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/league_details/league_details_items.dart';
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
          body: OfflineWidget(onlineWidget: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: false,
                snap: false,
                floating: false,
                expandedHeight: 250.0,
                leading: const BuildBackButton(),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: StandingHead(cubit: cubit, leagueID: leagueID),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const ScorersDetails(),
                        ScorersBody(cubit: cubit, leagueID: leagueID,length: cubit.scorers[leagueID]!.length,),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}


