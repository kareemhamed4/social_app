/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/layout/cubit/states/states.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/shared/constants/constants.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(GetUserInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value){
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetUserErrorState(error.toString()));
    });
  }

  double padding = 0;

  void changePadding({required double value}){
    padding = value;
    emit(ChangePadding());
  }
}*/
