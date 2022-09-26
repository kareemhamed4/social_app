import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialjetx/modules/login/cubit/states/states.dart';
import 'package:socialjetx/shared/styles/colors.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
          emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: myFavColor3,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(LoginErrorState());
    });
  }

  bool isPassword = true;
  IconData suffixIcon = FluentIcons.eye_off_16_regular;

  void changeLoginSuffixIcon(){
    isPassword = !isPassword;
    suffixIcon = isPassword ? FluentIcons.eye_off_16_regular : FluentIcons.eye_16_regular;
    emit(ChangeLoginSuffixState());
  }
}
