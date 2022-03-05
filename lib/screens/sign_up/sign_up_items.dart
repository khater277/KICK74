import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_states.dart';
import 'package:kick74/screens/sign_in/sign_in_screen.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_states.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';


class SignUpHead extends StatelessWidget {
  const SignUpHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "signUpHead".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: havan,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          "signUpCaption".tr,
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

class SignUpEmailAndPassword extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  const SignUpEmailAndPassword({Key? key, required this.emailController,
    required this.passwordController, required this.nameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextFiled(
          controller: nameController,
          validate: SignUpCubit.get(context).nameTextFieldValidate??true,
          hint: "name".tr,
          hintSize: 16,
          height: 18,
          suffix: const Text(""),
          focusBorder: darkGrey,
          border: darkGrey,
          rounded: 30,
          onChanged: (value){
            SignUpCubit.get(context).nameValidation(name: nameController.text);
          },
        ),
        const SizedBox(height: 10),
        DefaultTextFiled(
          controller: emailController,
          validate: SignUpCubit.get(context).emailTextFieldValidate??true,
          hint: "email".tr,
          hintSize: 16,
          height: 18,
          suffix: const Text(""),
          focusBorder: darkGrey,
          border: darkGrey,
          rounded: 30,
          onChanged: (value){
            SignUpCubit.get(context).emailValidation(email: emailController.text);
          },
        ),
        const SizedBox(height: 10),
        DefaultTextFiled(
          controller: passwordController,
          obscure: true,
          validate: SignUpCubit.get(context).passwordTextFieldValidate??true,
          hint: "password".tr,
          hintSize: 16,
          height: 18,
          suffix: const Text(""),
          focusBorder: darkGrey,
          border: darkGrey,
          rounded: 30,
          onChanged: (value){
            SignUpCubit.get(context).passwordValidation(password: passwordController.text);
          },
        ),
      ],
    );
  }
}

class SignUpGoogleFacebook extends StatelessWidget {
  final SignUpStates state;
  const SignUpGoogleFacebook({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (){
            SignUpCubit.get(context).googleSignIn(context);
          },
          child: state is! GoogleSignInLoadingState?
          CircleAvatar(
            radius: 23,
            backgroundImage: const AssetImage('assets/images/google.png'),
            backgroundColor: offWhite,
          ):DefaultButtonLoader(size: 25, width: 4, color: havan),
        ),
        const SizedBox(width: 35,),
        InkWell(
          onTap: (){
            SignUpCubit.get(context).facebookSignIn(context);
          },
          child: state is! FacebookSignInLoadingState?
          CircleAvatar(
            radius: 23,
            backgroundImage: const AssetImage('assets/images/facebook.png'),
            backgroundColor: offWhite,
          ):DefaultButtonLoader(size: 25, width: 4, color: havan),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  final SignUpStates state;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const SignUpButton({Key? key, required this.emailController,
    required this.nameController, required this.passwordController, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultElevatedButton(
          child: state is! SignUpCreateUserLoadingState&&
              state is! SignUpUserRegisterLoadingState?
          Text("signUp".tr,
            style: TextStyle(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),)
        :const DefaultButtonLoader(size: 25, width: 4, color: Colors.white),
          color: havan,
          rounded: 25,
          height: 50,
          width: double.infinity,
          onPressed: (){
            if(SignUpCubit.get(context).nameTextFieldValidate==true
            &&SignUpCubit.get(context).emailTextFieldValidate==true
            &&SignUpCubit.get(context).passwordTextFieldValidate==true){
              nameAndEmailValidation(context,
                  emailController: emailController,
                  nameController: nameController,
              );
            }else{
              SignUpCubit.get(context).nameValidation(name: nameController.text);
              SignUpCubit.get(context).emailValidation(email: emailController.text);
              SignUpCubit.get(context).passwordValidation(password: passwordController.text);
            }
          }
      ),
    );
  }

  void nameAndEmailValidation(context,{
    @required TextEditingController? emailController,
    @required TextEditingController? nameController,
  }){
    List<String> mails=[
      "@gmail.com", "@yahoo.com", "@outlook.com","@hotmail.com"];
    int index=emailController!.text.indexOf('@');
    if(EmailValidator.validate(emailController.text)&&
        mails.contains(emailController.text.substring(index,emailController.text.length))){
      if(nameController!.text.length>1){
        SignUpCubit.get(context).userRegister(
            context,
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text
        );
      }
      else{
        toastBuilder(msg: "moreOne".tr,
            color: Colors.grey[700]);
      }
    } else{
      toastBuilder(msg: "invalidEmail".tr, color: Colors.grey[700]);
    }
  }
}

class SignUpNoAccount extends StatelessWidget {
  const SignUpNoAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "haveAccount".tr,
          style: TextStyle(
              color: grey,
              fontSize: 18,
              fontWeight: FontWeight.normal
          ),
        ),
        TextButton(
          onPressed: (){Get.off(() =>const SignInScreen());},
          child: Text(
            "signIn".tr,
            style: TextStyle(
                color: havan,
               fontSize: 18,
                fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}



