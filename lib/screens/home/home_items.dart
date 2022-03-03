import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/styles/icons_broken.dart';

class BottomNavBar extends StatelessWidget {
  final KickCubit cubit;
  const BottomNavBar({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeNavBar(index);
          },
          marginR: const EdgeInsets.symmetric(horizontal: 40),
          //margin: const EdgeInsets.symmetric(horizontal: 40),
          dotIndicatorColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade800,
          backgroundColor: havan,
          itemPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
          //margin: const EdgeInsets.symmetric(horizontal: 40),
          borderRadius: 50,
          items: [
            DotNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/user.png'),
                size: 25,
              ),
            ),
            DotNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/matches.png'),
                size: 40,
              ),
            ),
            DotNavigationBarItem(
              icon: const ImageIcon(
                AssetImage('assets/images/settings.png'),
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

