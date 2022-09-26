abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}
class SignUpSuccessState extends SignUpStates {}
class SignUpErrorState extends SignUpStates {}

class ChangeSignUpSuffixState extends SignUpStates {}
class SignUpCheckBoxState extends SignUpStates {}

class UserCreateSuccessState extends SignUpStates {}
class UserCreateErrorState extends SignUpStates {
  final String error;

  UserCreateErrorState(this.error);
}