import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/shared/constants.dart';

class KickCubit extends Cubit<KickStates>{
  KickCubit() : super(KickInitState());
  static KickCubit get(context)=>BlocProvider.of(context);

  String? selectedValue=lang ?? (defaultLang=='ar'?'ar':'en');
  void changeAppLanguage(String value){
    selectedValue=value;
    GetStorage d = GetStorage();
    d.write('lang', value).then((v){
      lang=value;
      Get.updateLocale(Locale(value));
      print(lang);
    });
    emit(KickChangeLanguageState());
  }


  bool isLanguageSelected=false;
  bool ar = false;
  bool en = false;
  Color arColor=Colors.white;
  Color enColor=Colors.white;
  Color arTextColor=Colors.grey.shade500;
  Color enTextColor=Colors.grey.shade500;
  Color nextButtonColor=Colors.grey.shade200;
  Color nextIconColor=havan.withOpacity(0.4);
  void selectLanguage({@required bool? arabic,@required bool? english}){
    if(arabic==true){
      ar=true;
      en=false;
      arColor=Colors.grey.withOpacity(0.02);
      enColor=enColor=Colors.white;
      arTextColor=havan;
      enTextColor=Colors.grey.shade500;
      changeAppLanguage('ar');
    }else{
      en=true;
      ar=false;
      enColor=Colors.grey.withOpacity(0.02);
      arColor=Colors.white;
      enTextColor=havan;
      arTextColor=Colors.grey.shade500;
      changeAppLanguage('en');
    }
    isLanguageSelected=true;
    nextButtonColor=havan;
    nextIconColor=white;
    emit(KickSelectLanguageState());
  }
}