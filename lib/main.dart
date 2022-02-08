import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/cubit/kick_states.dart';
import 'package:kick74/screens/select_language/select_language_screen.dart';
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

  /// get device language
  final String defaultLocale = Platform.localeName.substring(0,2);
  defaultLang = defaultLocale;

  uId = GetStorage().read('uId');
  lang = GetStorage().read('lang');
  print(lang);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>KickCubit(),
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
                child: const SelectLanguageScreen()
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
