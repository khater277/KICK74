import 'package:flutter/material.dart';
import 'package:kick74/screens/opening/opening_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';


class OpeningScreen extends StatelessWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: OfflineWidget(onlineWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const SizedBox(height: 120,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OpeningHeadText(),
              const SizedBox(height: 20,),
              Image.asset("assets/images/outlined_logo.png",
                width: 200,height: 200,),
              const SizedBox(height: 35,),
              const OpeningSignInButton(),
              const SizedBox(height: 12,),
              const OpeningSignUpButton(),
            ],
          ),

        ],
      )),
    );
  }
}
