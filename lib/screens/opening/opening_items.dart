import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/screens/sign_in/sign_in_screen.dart';
import 'package:kick74/screens/sign_up/sign_up_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';


class OpeningHeadText extends StatelessWidget {
  const OpeningHeadText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "openingHead".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: havan,
          ),
        ),
        Text(
          "openingCaption".tr,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class OpeningSignInButton extends StatelessWidget {
  const OpeningSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: DefaultOutLinedButton(
        child: Text("signIn".tr,
          style: TextStyle(
            color: havan,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
        rounded: 25,
        height: 50,
        width: double.infinity,
        onPressed: (){
          Get.off(() =>const SignInScreen());
        },
        borderColor: havan,
      ),
    );
  }
}

class OpeningSignUpButton extends StatelessWidget {
  const OpeningSignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child:DefaultElevatedButton(
          child: Text("signUp".tr,
            style: TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          color: havan,
          rounded: 25,
          height: 50,
          width: double.infinity,
          onPressed: (){Get.off(() =>const SignUpScreen());}
      ),
    );
  }
}




