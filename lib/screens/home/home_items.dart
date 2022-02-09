import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/styles/icons_broken.dart';

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
