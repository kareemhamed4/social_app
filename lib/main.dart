import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/bloc_observer.dart';
import 'package:socialjetx/main_cubit/cubit/cubit.dart';
import 'package:socialjetx/main_cubit/states/states.dart';
import 'package:socialjetx/modules/login/login_screen.dart';
import 'package:socialjetx/network/local/shared_helper.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/new_layout.dart';
import 'package:socialjetx/shared/styles/themes.dart';
import 'shared/constants/constants.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uId');
  isVerified = CacheHelper.getData(key: 'isVerified');
  bool isDark = CacheHelper.getData(key: "isDark") ?? false ;
  Widget widget;

  if(uId != null){
    widget = const NewLayout();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(
    isDark:isDark,
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({Key? key,required this.startWidget,required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MainCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(create: (BuildContext context) => LayoutCubit()..getUserData()..getPosts()..getAllUsers()),
      ],
      child: BlocConsumer<MainCubit,MainStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}