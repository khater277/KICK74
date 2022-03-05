import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_states.dart';
import 'package:kick74/screens/sign_in/sign_in_items.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SignInCubit(),
      child: BlocConsumer<SignInCubit,SignInStates>(
      listener: (context,state){},
      builder: (context,state){
        SignInCubit cubit = SignInCubit.get(context);
        return Scaffold(
          backgroundColor: offWhite,
          body:OfflineWidget(onlineWidget: Padding(
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
                      const SignInHead(),
                      const SizedBox(height: 20,),
                      Image.asset('assets/images/outlined_logo.png',
                        width: 200,height: 200,),
                      const SizedBox(height: 20,),
                      SignInEmailAndPassword(
                          emailController: _emailController,
                          passwordController: _passwordController
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          SignInGoogleFacebook(cubit: cubit,state: state,),
                          const SizedBox(width: 45,),
                          SignInButton(
                            state: state,
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          const SizedBox(width: 20,),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const SignInNoAccount(),
                    ],
                  ),
                ],
              ),
            ),
          ))
        );
      },
    ),
    );
  }
}
