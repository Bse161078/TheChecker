import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  brightness: Brightness.light,
  backgroundColor: const Color(0xffFAFAFA),
  dividerColor: Colors.white12,
  primaryColor: Colors.blue,
  splashColor: Colors.white,
  highlightColor: Colors.white,
  cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(fontFamily: 'Poppins'),
  )),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);


final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: const Color(0xff0BBBEF),
  secondaryHeaderColor: Color(0xff0087AE),

  brightness: Brightness.dark,
  backgroundColor: const Color(0xff222222),
  dividerColor: const Color(0xff666666),
  splashColor: const Color(0xff333333),
  highlightColor: Colors.white,
  hintColor: Colors.white70,
  disabledColor: const Color(0xff38616f),
  cardColor: Colors.black,

  unselectedWidgetColor: Colors.black,
  toggleableActiveColor: const Color(0xff0BBBEF),


  scaffoldBackgroundColor: const Color(0xff222222),
  cupertinoOverrideTheme: const CupertinoThemeData(
    barBackgroundColor: Color(0xff1d1d1d),
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'Poppins'),
  )),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.white),
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);