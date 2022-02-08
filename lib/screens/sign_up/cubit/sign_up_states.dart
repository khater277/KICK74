abstract class SignUpStates{}

class SignUpInitialState extends SignUpStates{}

class SignUpNameValidationState extends SignUpStates{}
class SignUpEmailValidationState extends SignUpStates{}
class SignUpPasswordValidationState extends SignUpStates{}

class SignUpCreateUserLoadingState extends SignUpStates{}
class SignUpCreateUserSuccessState extends SignUpStates{}
class SignUpCreateUserErrorState extends SignUpStates{}

class SignUpUserRegisterLoadingState extends SignUpStates{}
class SignUpUserRegisterSuccessState extends SignUpStates{}
class SignUpUserRegisterErrorState extends SignUpStates{}
