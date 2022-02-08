import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kick74/models/UserModel.dart';
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
      createUser(
          userToken: userToken,
          name: name,
          email: email,
          uId: value.user!.uid
      );
      uId=value.user!.uid;
      GetStorage().write('uId', value.user!.uid);
      emit(SignUpUserRegisterSuccessState());
    }).catchError((error){
      String message = error.toString().substring(
          error.toString().indexOf(']')+2,
          error.toString().length
      );
      bool passwordMessage = message.startsWith('Password');
      toastBuilder(
          msg:passwordMessage?"invalidPassword".tr:"emailUsed".tr,
          color: Colors.grey);
      printError("userRegister",error.toString());
      emit(SignUpUserRegisterErrorState());
    });
  }


  void createUser({
    @required String? userToken,
    @required String? name,
    @required String? email,
    @required String? uId,
  }) {
    UserModel userModel = UserModel(
        userToken: userToken,
        uId: uId,
        name: name,
        email: email,
        profileImage:"https://i.pinimg.com/564x/d9/c3/cf/d9c3cf6c263d181be4b5cbd15038b3a6.jpg",
    );
    emit(SignUpCreateUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(userModel.toJson()).then((value){
          debugPrint("USER CREATED");
      emit(SignUpCreateUserSuccessState());
    }).catchError((error){
      printError("create user", error.toString());
      emit(SignUpCreateUserErrorState());
    });
  }
}