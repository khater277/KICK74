import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/matches/matches_items.dart';
import 'package:kick74/shared/default_widgets.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit, KickStates>(
      listener: (context, state) {},
      builder: (context, state) {
        KickCubit cubit = KickCubit.get(context);
        return Scaffold(
          body: OfflineWidget(onlineWidget:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => index == 0
                          ? MyTeamsButton(cubit: cubit)
                          : LeagueButton(
                        index: index - 1,
                        cubit: cubit,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                      itemCount: 7),
                ),
              ),
              if (cubit.leagueIndex == 10)
                FavouriteMatches(cubit: cubit, matches: cubit.favMatches)
              else
                LeagueMatches(
                  cubit: cubit,
                  matches: cubit.leagueIndex == 0
                      ? cubit.shownMatches[0]!
                      : cubit.shownMatches[
                  cubit.leaguesIDs[cubit.leagueIndex - 1]]!,
                ),
            ],
          )),
        );
      },
    );
  }
}
