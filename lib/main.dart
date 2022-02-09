import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/opening/opening_screen.dart';
import 'package:kick74/screens/select_language/select_language_screen.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:kick74/screens/sign_in/sign_in_screen.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/styles/themes.dart';
import 'package:kick74/translation/translations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'cubit/bloc_observer.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget? homeWidget;
  /// get device language
  final String defaultLocale = Platform.localeName.substring(0,2);
  defaultLang = defaultLocale;
  uID = GetStorage().read('uId');
  lang = GetStorage().read('lang');
  facebook = GetStorage().read('facebook');
  google = GetStorage().read('google');
  print(google);
  print(uID);

  if(lang==null){
    homeWidget=const SelectLanguageScreen();
  }else{
    if(uID==null||uID!.isEmpty){
      homeWidget=const OpeningScreen();
    }else{
      homeWidget=const HomeScreen();
    }
  }
  print(lang);
  runApp(MyApp(homeWidget: homeWidget,));
}

class MyApp extends StatelessWidget {
  final Widget homeWidget;
  const MyApp({Key? key, required this.homeWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>KickCubit()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context)=>SignUpCubit(),
        ),
      ],
      child: BlocConsumer<KickCubit,KickStates>(
        listener: (context,state){},
        builder: (context,state){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection:languageFun(
                    ar: TextDirection.rtl,
                    en: TextDirection.ltr
                ),
                child: homeWidget
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            translations: Translation(),
            locale: Locale(
                languageFun(ar: 'ar', en: 'en')
            ),
            fallbackLocale: const Locale('en'),
            builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.resize(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
            ),
          );
        },
      ),
    );
  }
}
