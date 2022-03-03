import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/favourites/favourites_items.dart';
import 'package:kick74/shared/default_widgets.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

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
                expandedHeight: 60.0,
                leading: const BuildBackButton(),
                flexibleSpace: FlexibleSpaceBar(
                  //title: Text('SliverAppBar'),
                  background: AppBar(
                    leading: IconButton(
                      onPressed: (){
                        //cubit.getFavourites();
                        Get.back();
                      },
                      icon: const BackIcon(size: 22),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        LeagueBuilder(league: cubit.leagues[1]),
                        const SizedBox(height: 80,),
                        LeagueBuilder(league: cubit.leagues[2]),
                        const SizedBox(height: 80,),
                        LeagueBuilder(league: cubit.leagues[3]),
                        const SizedBox(height: 80,),
                        LeagueBuilder(league: cubit.leagues[4]),
                        const SizedBox(height: 80,),
                        LeagueBuilder(league: cubit.leagues[5]),

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
