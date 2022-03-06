import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/UserModel.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/onBoarding/onBoarding_screen.dart';
import 'package:kick74/screens/sign_in/cubit/sign_in_states.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInCubit extends Cubit<SignInStates>{
  SignInCubit() : super(SignInInitialState());
  static SignInCubit get(context)=>BlocProvider.of(context);


  bool? emailTextFieldValidate;
  bool? passwordTextFieldValidate;

  void emailValidation({
    @required String? email,
  }){
    if(email!.isNotEmpty){
      emailTextFieldValidate=true;
    }else{
      emailTextFieldValidate=false;
    }
    emit(SignInEmailValidationState());
  }

  void passwordValidation({
    @required String? password,
  }){
    if(password!.isNotEmpty){
      passwordTextFieldValidate=true;
    }else{
      passwordTextFieldValidate=false;
    }
    emit(SignInPasswordValidationState());
  }

  ///login with email and password
  void userLogin(context,{
  @required String? email,
  @required String? password,
}){
    emit(SignInUserLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value){
      uID=value.user!.uid;
      GetStorage().write('uId',value.user!.uid)
      .then((value){
        KickCubit.get(context).getUserData();
        KickCubit.get(context).getFavourites();
        KickCubit.get(context).getFavouritesMatches();
        GetStorage().write('onBoarding', true).then((value){
          onBoarding = true;
          Get.offAll(()=>const HomeScreen());
        });
      });
      emit(SignInUserLoginSuccessState());
    }).catchError((error){
      String message = error.toString().substring(
          error.toString().indexOf(']')+2,
          error.toString().length
      );
      bool passwordMessage = message.startsWith('the password');
      toastBuilder(
          msg:passwordMessage?"invalidPassword".tr:"invalidEmail".tr,
          color: Colors.grey);
      printError("userLogin", error.toString());
      emit(SignInUserLoginErrorState());
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  ///complete sign in with google
  void googleSignIn(BuildContext context)async{
    emit(GoogleSignInLoadingState());
    await signInWithGoogle().then((value)async{
      User user = value.user!;
      uID=value.user!.uid;
      String name = formatName(user.displayName!);
      String? userToken = await FirebaseMessaging.instance.getToken();
      //KickCubit.get(context).getFavouritesMatches();
      //debugPrint(uID);
      FirebaseFirestore.instance.collection('users')
          .doc(user.uid)
          .get()
          .then((v){
        debugPrint(v.data()!['uId']);
        debugPrint("trueeeeeeeeeeeeeeee");
        KickCubit.get(context).getUserData();
        KickCubit.get(context).getFavourites();
        // KickCubit.get(context).getFavouritesMatches();
        GetStorage().write('uId',value.user!.uid)
            .then((value){
          GetStorage().write('onBoarding', true).then((value){
            onBoarding = true;
            Get.offAll(()=>const HomeScreen());
          });
        });
        emit(GoogleSignInSuccessState());
      }).catchError((error){
        debugPrint("falseeeeeeeeeeee");
        GetStorage().write('facebook', true);
        createUser(context,
          uid: user.uid,
          name: name,
          profileImage: user.photoURL,
          email: user.email,
          userToken:userToken,
        );
      });
    }).catchError((error){
      emit(GoogleSignInErrorState());
      printError("googleSignIn", error.toString());
    });
  }

  ///complete sign in with facebook
  void facebookSignIn(BuildContext context)async{
    emit(FacebookSignInLoadingState());
    await signInWithFacebook().then((value)async{
      User user = value.user!;
      uID=value.user!.uid;
      String name = formatName(user.displayName!);
      String? userToken = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance.collection('users')
          .doc(user.uid)
          .get()
          .then((v){
        debugPrint(v.data()!['uId']);
        debugPrint("trueeeeeeeeeeeeeeee");
        KickCubit.get(context).getUserData();
        KickCubit.get(context).getFavourites();
        KickCubit.get(context).getFavouritesMatches();
        GetStorage().write('uId',value.user!.uid)
            .then((value){
          GetStorage().write('onBoarding', true).then((value){
            onBoarding = true;
            Get.offAll(()=>const HomeScreen());
          });
        });
        emit(FacebookSignInSuccessState());
      }).catchError((error){
        debugPrint("falseeeeeeeeeeee");
        GetStorage().write('facebook', true);
        createUser(context,
          uid: user.uid,
          name: name,
          profileImage: user.photoURL,
          email: user.email,
          userToken:userToken,
        );
      });
    }).catchError((error){
      emit(FacebookSignInErrorState());
      printError("facebookSignIn", error.toString());
    });
  }

  ///create user from google and facebook
  void createUser(BuildContext context,{
    @required String? userToken,
    @required String? name,
    @required String? email,
    @required String? uid,
    String? profileImage,
  }) {
    UserModel userModel = UserModel(
        userToken: userToken,
        name: name,
        email: email,
        uId: uid,
        profileImage:profileImage??"https://i.pinimg.com/564x/d9/c3/cf/d9c3cf6c263d181be4b5cbd15038b3a6.jpg",
    );
    emit(SignInCreateUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .set(userModel.toJson()).then((value){
      GetStorage().write('uId', uid);
      //GetStorage().write('onBoarding', true);
      KickCubit.get(context).getUserData();
      Get.offAll(()=>const OnBoardingScreen());
      emit(SignInCreateUserSuccessState());
    }).catchError((error){
      printError("create user", error.toString());
      emit(SignInCreateUserErrorState());
    });
  }
}

