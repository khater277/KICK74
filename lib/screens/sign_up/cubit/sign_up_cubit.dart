import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kick74/cubit/kick_cubit.dart';
import 'package:kick74/models/UserModel.dart';
import 'package:kick74/screens/home/home_screen.dart';
import 'package:kick74/screens/onBoarding/onBoarding_screen.dart';
import 'package:kick74/screens/sign_up/cubit/sign_up_states.dart';
import 'package:kick74/shared/constants.dart';
import 'package:kick74/shared/default_widgets.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(SignUpInitialState());
  static SignUpCubit get(context)=>BlocProvider.of(context);


  bool? nameTextFieldValidate;
  bool? emailTextFieldValidate;
  bool? passwordTextFieldValidate;
  void nameValidation({
  @required String? name,
}){
    if(name!.isNotEmpty){
      nameTextFieldValidate=true;
    }else{
      nameTextFieldValidate=false;
    }
    print(nameTextFieldValidate);
    emit(SignUpNameValidationState());
  }

  void emailValidation({
    @required String? email,
  }){
    if(email!.isNotEmpty){
      emailTextFieldValidate=true;
    }else{
      emailTextFieldValidate=false;
    }
    emit(SignUpEmailValidationState());
  }

  void passwordValidation({
    @required String? password,
  }){
    if(password!.isNotEmpty){
      passwordTextFieldValidate=true;
    }else{
      passwordTextFieldValidate=false;
    }
    emit(SignUpPasswordValidationState());
  }



  void userRegister(context, {
    @required String? email,
    @required String? password,
    @required String? name,
  }){
    emit(SignUpUserRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!
    ).then((value)async{
      String? userToken = await FirebaseMessaging.instance.getToken();
      createUser(context,
          userToken: userToken,
          name: name,
          email: email,
          uId: value.user!.uid
      );
      uID=value.user!.uid;
      GetStorage().write('uId', value.user!.uid);
      KickCubit.get(context).getFavourites();
      emit(SignUpUserRegisterSuccessState());
    }).catchError((error){
      String message = error.toString().substring(
          error.toString().indexOf(']')+2,
          error.toString().length
      );
      bool passwordMessage = message.startsWith('Password');
      toastBuilder(
          msg:passwordMessage?"shortPassword".tr:"emailUsed".tr,
          color: Colors.grey);
      printError("userRegister",error.toString());
      emit(SignUpUserRegisterErrorState());
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
    emit(GoogleSignUpLoadingState());
    await signInWithGoogle().then((value)async{
      User user = value.user!;
      uID=value.user!.uid;
      String name = formatName(user.displayName!);
      String? userToken = await FirebaseMessaging.instance.getToken();
      //print(uID);
      FirebaseFirestore.instance.collection('users')
          .doc(user.uid)
          .get()
          .then((v){
        print(v.data()!['uId']);
        print("trueeeeeeeeeeeeeeee");
        KickCubit.get(context).getUserData();
        KickCubit.get(context).getFavourites();
        GetStorage().write('uId',value.user!.uid)
            .then((value){
          GetStorage().write('onBoarding', true).then((value){
            onBoarding = true;
            Get.offAll(()=>const HomeScreen());
          });
        });
        emit(GoogleSignUpSuccessState());
      }).catchError((error){
        print("falseeeeeeeeeeee");
        GetStorage().write('facebook', true);
        createUser(context,
          uId: user.uid,
          name: name,
          profileImage: user.photoURL,
          email: user.email,
          userToken:userToken,
        );
      });
    }).catchError((error){
      emit(GoogleSignUpErrorState());
      printError("googleSignIn", error.toString());
    });
  }

  ///complete sign in with facebook
  void facebookSignIn(BuildContext context)async{
    emit(FacebookSignUpLoadingState());
    await signInWithFacebook().then((value)async{
      User user = value.user!;
      uID=value.user!.uid;
      String name = formatName(user.displayName!);
      String? userToken = await FirebaseMessaging.instance.getToken();
      //print(uID);
      FirebaseFirestore.instance.collection('users')
          .doc(user.uid)
          .get()
          .then((v){
        print(v.data()!['uId']);
        print("trueeeeeeeeeeeeeeee");
        KickCubit.get(context).getUserData();
        KickCubit.get(context).getFavourites();
        GetStorage().write('uId',value.user!.uid)
            .then((value){
          GetStorage().write('onBoarding', true).then((value){
            onBoarding = true;
            Get.offAll(()=>const HomeScreen());
          });
        });
        emit(FacebookSignUpSuccessState());
      }).catchError((error){
        print("falseeeeeeeeeeee");
        GetStorage().write('facebook', true);
        createUser(context,
          uId: user.uid,
          name: name,
          profileImage: user.photoURL,
          email: user.email,
          userToken:userToken,
        );
      });
    }).catchError((error){
      emit(FacebookSignUpErrorState());
      printError("facebookSignIn", error.toString());
    });
  }


  void createUser(context,{
    @required String? userToken,
    @required String? name,
    @required String? email,
    @required String? uId,
    String? profileImage,
  }) {
    UserModel userModel = UserModel(
        userToken: userToken,
        uId: uId,
        name: name,
        email: email,
        profileImage:profileImage??"https://i.pinimg.com/564x/d9/c3/cf/d9c3cf6c263d181be4b5cbd15038b3a6.jpg",
    );
    emit(SignUpCreateUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(userModel.toJson()).then((value){
      GetStorage().write('uId', uId);
      KickCubit.get(context).getUserData();
      Get.offAll(()=>const OnBoardingScreen());
      emit(SignUpCreateUserSuccessState());
    }).catchError((error){
      printError("create user", error.toString());
      emit(SignUpCreateUserErrorState());
    });
  }
}