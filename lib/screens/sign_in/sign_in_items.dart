import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_states.dart';
import 'package:kick74/screens/sign_up/sign_up_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';


class SignInHead extends StatelessWidget {
  const SignInHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "signInHead".tr,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 27,
            color: havan,
          ),
        ),
        const SizedBox(height: 2,),
        Text(
          "signInCaption".tr,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class SignInEmailAndPassword extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignInEmailAndPassword({Key? key, required this.emailController, required this.passwordController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextFiled(
          controller: emailController,
          validate: SignInCubit.get(context).emailTextFieldValidate??true,
          hint: "email".tr,
          hintSize: 14,
          height: 14,
          suffix: const Text(""),
          focusBorder: darkGrey,
          border: darkGrey,
          rounded: 30,
          onChanged: (value){
            SignInCubit.get(context).emailValidation(email: emailController.text);
          },
        ),
        const SizedBox(height: 15),
        DefaultTextFiled(
          controller: passwordController,
          validate: SignInCubit.get(context).passwordTextFieldValidate??true,
          hint: "password".tr,
          hintSize: 14,
          height: 14,
          suffix: TextButton(
              onPressed: (){},
              child: Text("forget".tr,
                style:TextStyle(
                  color: darkGrey,
                ),)
          ),
          focusBorder: darkGrey,
          border: darkGrey,
          rounded: 30,
          onChanged: (value){
            SignInCubit.get(context).passwordValidation(password: passwordController.text);
          },
        ),
      ],
    );
  }
}

class SignInGoogleFacebook extends StatelessWidget {
  final SignInCubit cubit;
  const SignInGoogleFacebook({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            cubit.googleSignIn(context);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage('assets/images/google.png'),
            backgroundColor: offWhite,
          ),
        ),
        const SizedBox(width: 35,),
        InkWell(
          onTap: (){
            cubit.facebookSignIn(context);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage('assets/images/facebook.png'),
            backgroundColor: offWhite,
          ),
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  final SignInStates state;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignInButton({Key? key, required this.emailController,
    required this.state, required this.passwordController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultElevatedButton(
          child:state is! SignInUserLoginLoadingState?
          Text("signIn".tr,
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),)
        :const DefaultButtonLoader(size: 25, width: 4, color: Colors.white),
          color: havan,
          rounded: 25,
          height: 50,
          width: double.infinity,
          onPressed: (){
            SignInCubit.get(context).userLogin(
                context,
                email: emailController.text,
                password: passwordController.text
            );
          }
      ),
    );
  }
}

class SignInNoAccount extends StatelessWidget {
  const SignInNoAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "noAccount".tr,
          style: TextStyle(
              color: grey,
              fontSize: 16,
              fontWeight: FontWeight.normal
          ),
        ),
        TextButton(
          onPressed: (){Get.off(() =>const SignUpScreen());},
          child: Text(
            "signUp".tr,
            style: TextStyle(
                color: havan,
                fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}


