import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/select_language/select_language_items.dart';
import 'package:kick74/shared/constants.dart';


class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KickCubit,KickStates>(
      listener: (context,state){},
      builder: (context,state){
        KickCubit cubit = KickCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SelectLanguageHead(),
                    const SizedBox(height: 30,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          cubit.selectLanguage(arabic: false,english: true);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Directionality(
                                textDirection: languageFun(
                                    ar: TextDirection.ltr,
                                    en: TextDirection.ltr
                                ),
                                child: Card(
                                  color: cubit.enColor,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Hi!",
                                                    style: TextStyle(
                                                        color: cubit.enTextColor,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 25
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Text(
                                                    "I'm new user!",
                                                    style: TextStyle(
                                                        color: cubit.enTextColor,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Image.asset(
                                                'assets/images/en.png',
                                                width:80,height: 100,
                                              )
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional.bottomEnd,
                                          child: Text(
                                            "English",
                                            style: TextStyle(
                                                color: cubit.enTextColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 25
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          cubit.selectLanguage(arabic: true,english: false);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Directionality(
                                textDirection: languageFun(
                                    ar: TextDirection.rtl,
                                    en: TextDirection.rtl
                                ),
                                child: Card(
                                  color: cubit.arColor,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "أهلا!",
                                                    style: TextStyle(
                                                        color: cubit.arTextColor,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 25
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Text(
                                                    "أنا مستخدم جديد!",
                                                    style: TextStyle(
                                                        color: cubit.arTextColor,
                                                        fontWeight: FontWeight.normal,
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Image.asset(
                                                'assets/images/ar.png',
                                                width:80,height: 100,
                                              )
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional.bottomEnd,
                                          child: Text(
                                            "العربية",
                                            style: TextStyle(
                                                color: cubit.arTextColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 25
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const NextButton(),
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}
