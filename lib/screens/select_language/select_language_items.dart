import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/screens/opening/opening_screen.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:kick74/styles/icons_broken.dart';


class SelectLanguageHead extends StatelessWidget {
  const SelectLanguageHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "choose".tr,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 40,
            color: havan,
          ),
        ),
         Text(
          "toContinue".tr,
          style: const TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SizedBox(
              width: 130,
              child: DefaultElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      languageFun(
                          en: const SizedBox(width: 0,),
                          ar: Row(
                            children: [
                              Icon(
                                IconBroken.Arrow___Right,
                                size: 20,
                                color: KickCubit.get(context).nextIconColor,
                              ),
                              const SizedBox(width: 5,),
                            ],
                          )
                      ),
                      Text(
                          "next".tr,
                        style: TextStyle(
                          fontSize: 22,
                          color: KickCubit.get(context).nextIconColor
                        ),
                      ),
                      languageFun(
                          ar: const SizedBox(width: 0,),
                          en: Row(
                            children: [
                              const SizedBox(width: 5,),
                              Icon(
                                IconBroken.Arrow___Right,
                                size: 20,
                                color: KickCubit.get(context).nextIconColor,
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                  color: KickCubit.get(context).nextButtonColor,
                  rounded: 10,
                  height: 50,
                  width: double.infinity,
                  onPressed: (){
                    if(KickCubit.get(context).isLanguageSelected){
                      Get.off(() =>const OpeningScreen());
                    }else{
                      toastBuilder(
                          msg: "selectLang".tr,
                          color: Colors.grey.shade500
                      );
                    }
                  }
              ),
            ),
          )
        ],
      ),
    );
  }
}




