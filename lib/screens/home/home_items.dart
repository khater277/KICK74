import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/styles/icons_broken.dart';

class MatchesAppBar extends StatelessWidget {
  const MatchesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/matches.png',
          width: 50,height: 50,
        ),
        const SizedBox(width: 15,),
        Text("Matches",style: TextStyle(
            fontSize: 25,
            color: havan.withOpacity(0.8),
            fontWeight: FontWeight.w600
        ),)
      ],
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final KickCubit cubit;
  const BottomNavBar({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: cubit.currentIndex,
      onTap: (index){
        cubit.changeNavBar(index);
      },
      backgroundColor: havan,
      itemPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 40),
      dotIndicatorColor: havan,
      enableFloatingNavBar: true,
      //margin: const EdgeInsets.symmetric(horizontal: 40),
      borderRadius: 50,
      items: [
        DotNavigationBarItem(
          icon: const ImageIcon(
            AssetImage('assets/images/user.png'),
            size: 25,
          ),
          selectedColor: Colors.white,
          unselectedColor: Colors.grey.shade800,
        ),
        DotNavigationBarItem(
          icon: const ImageIcon(
            AssetImage('assets/images/matches.png'),
            size: 40,
          ),
          selectedColor: Colors.white,
          unselectedColor: Colors.grey.shade800,
        ),
        DotNavigationBarItem(
          icon: const ImageIcon(
            AssetImage('assets/images/settings.png'),
            size: 25,
          ),
          selectedColor: Colors.white,
          unselectedColor: Colors.grey.shade800,
        ),
      ],
    );
  }
}

class LogOutButton extends StatelessWidget {
  final KickCubit cubit;
  const LogOutButton({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("logOut".tr,style: const TextStyle(
                    fontSize: 20
                ),),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    return SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text("logOutContent".tr,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: (){
                                        cubit.signOut();
                                      },
                                      child:Text(
                                        "yes".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: havan,
                                        ),
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child:Text(
                                      "cancel".tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: havan,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
          );
        },
        icon: const Icon(IconBroken.Logout,size: 22)
    );
  }
}
