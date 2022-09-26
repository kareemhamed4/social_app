import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/modules/signup/cubit/states/states.dart';
import 'package:socialjetx/shared/styles/colors.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      if (kDebugMode) {
        print(value.user!.email);
        print(value.user!.uid);
      }
      createCreate(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
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
          fontSize: 16.0);
      emit(SignUpErrorState());
    });
  }

  void createCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      image: "https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg",
      cover: "https://img.freepik.com/free-photo/overjoyed-roommates-apartment-celebrates-victory-favourite-team-clink-bottles-with-beer_273609-27465.jpg",
      bio: "write ur bio",
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UserCreateErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffixIcon = FluentIcons.eye_off_16_regular;

  void changeSignUpSuffixIcon(){
    isPassword = !isPassword;
    suffixIcon = isPassword ? FluentIcons.eye_off_16_regular : FluentIcons.eye_16_regular;
    emit(ChangeSignUpSuffixState());
  }

  bool isCheckBox = false;

  void changeCheckBox() {
    isCheckBox = !isCheckBox;
    emit(SignUpCheckBoxState());
  }
}
