abstract class SignInStates{}

class SignInInitialState extends SignInStates{}

class SignInEmailValidationState extends SignInStates{}
class SignInPasswordValidationState extends SignInStates{}

class SignInUserLoginLoadingState extends SignInStates{}
class SignInUserLoginSuccessState extends SignInStates{}
class SignInUserLoginErrorState extends SignInStates{}

class SignInCreateUserLoadingState extends SignInStates{}
class SignInCreateUserSuccessState extends SignInStates{}
class SignInCreateUserErrorState extends SignInStates{}

class GoogleSignInLoadingState extends SignInStates{}
class GoogleSignInSuccessState extends SignInStates{}
class GoogleSignInErrorState extends SignInStates{}

class FacebookSignInLoadingState extends SignInStates{}
class FacebookSignInSuccessState extends SignInStates{}
class FacebookSignInErrorState extends SignInStates{}