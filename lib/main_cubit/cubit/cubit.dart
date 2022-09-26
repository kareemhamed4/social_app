import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/main_cubit/states/states.dart';
import 'package:socialjetx/network/local/shared_helper.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if(fromShared != null){
      isDark = fromShared;
    }else{
      isDark = !isDark;
    }
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
      emit(ChangeAppModeState());
    });
  }

  void signOut(){
    CacheHelper.removeData(key: "uId");
    emit(SignOutState());
  }
}