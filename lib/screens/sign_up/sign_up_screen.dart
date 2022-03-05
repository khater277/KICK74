import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kick74/screens/onBoarding/onBoarding_screen.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_states.dart';
import 'package:kick74/screens/sign_up/sign_up_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit,SignUpStates>(
      listener: (context,state){
        if(state is SignUpCreateUserSuccessState){
          Get.offAll(()=>const OnBoardingScreen());
        }
      },
      builder: (context,state){
        SignUpCubit cubit = SignUpCubit.get(context);
        return Scaffold(
          backgroundColor: offWhite,
          body: OfflineWidget(onlineWidget: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      const SignUpHead(),
                      const SizedBox(height: 20,),
                      Image.asset('assets/images/outlined_logo.png',
                        width: 200,height: 200,),
                      const SizedBox(height: 20,),
                      SignUpEmailAndPassword(
                          nameController: _nameController,
                          emailController: _emailController,
                          passwordController: _passwordController
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          SignUpGoogleFacebook(state: state,),
                          const SizedBox(width: 45,),
                          SignUpButton(
                            state: state,
                            nameController: _nameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          const SizedBox(width: 20,),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const SignUpNoAccount(),
                    ],
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
