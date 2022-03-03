import 'package:flutter/material.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';

class ProfileImage extends StatelessWidget {
  final KickCubit kickCubit;
  const ProfileImage({Key? key, required this.kickCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      backgroundImage: NetworkImage(
        kickCubit.userModel!.profileImage!
      ),
      backgroundColor: havan,
    );
  }
}

class LogOut extends StatelessWidget {
  final KickCubit cubit;
  const LogOut({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: DefaultOutLinedButton(
        borderColor: havan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(IconBroken.Logout,size: 30,color: darkGrey,),
              const SizedBox(width: 10,),
              Text("Logout",style: TextStyle(
                color: darkGrey,
                fontSize: 18,
                fontWeight: FontWeight.normal
              ),)
            ],
          ),
          rounded: 40,
          height: 50,
          width: double.infinity,
          onPressed: () {
            showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: MaterialLocalizations.of(context)
                    .modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext,
                    Animation animation,
                    Animation secondaryAnimation) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: MediaQuery.of(context).size.height / 4.4,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Logout",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Are you sure you want to logout ?",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 20,fontWeight: FontWeight.normal,color: Colors.grey.shade600),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        cubit.signOut();
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: havan,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: havan,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
      ),
    );
  }
}


