import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialjetx/shared/styles/colors.dart';


ThemeData lightTheme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: myFavColor5,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontFamily: "KareemR", color: Colors.black),
    bodyText2: TextStyle(fontFamily: "KareemR", color: Colors.black),
    subtitle1: TextStyle(fontFamily: "KareemB", color: Colors.black),
    subtitle2: TextStyle(fontFamily: "KareemB", color: Colors.black),
    headline5: TextStyle(fontFamily: "KareemB", color: Colors.black),
    headline6: TextStyle(fontFamily: "KareemB", color: Colors.black),
    button: TextStyle(fontFamily: "KareemB", color: Colors.white),
    caption: TextStyle(color: Colors.grey),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    selectedIconTheme: const IconThemeData(color: Colors.redAccent),
    selectedItemColor: myFavColor5,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(fontFamily: "KareemB"),
    unselectedLabelStyle: const TextStyle(fontFamily: "KareemR"),
    showUnselectedLabels: true,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
  ),
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: myFavColor5,
  ),
  cardColor: myFavColor4,
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  scaffoldBackgroundColor: myFavColor4,
  appBarTheme:  AppBarTheme(
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    color: myFavColor4,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontFamily: "KareemR", color: Colors.white),
    bodyText2: TextStyle(fontFamily: "KareemR", color: Colors.white),
    subtitle1: TextStyle(fontFamily: "KareemB", color: Colors.white),
    subtitle2: TextStyle(fontFamily: "KareemB", color: Colors.white),
    headline5: TextStyle(fontFamily: "KareemB", color: Colors.white),
    headline6: TextStyle(fontFamily: "KareemB", color: Colors.white),
    button: TextStyle(fontFamily: "KareemB", color: Colors.black),
    caption: TextStyle(color: Colors.grey),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: myFavColor4,
    elevation: 0,
    selectedIconTheme: const IconThemeData(color: Colors.redAccent),
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(fontFamily: "KareemB"),
    unselectedLabelStyle: const TextStyle(fontFamily: "KareemR"),
    showUnselectedLabels: true,
    unselectedItemColor: Colors.white
  ),
);

