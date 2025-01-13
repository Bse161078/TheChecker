import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
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
    bodySmall: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
  ).copyWith(surface: const Color(0xffFAFAFA)),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xff0BBBEF),
  secondaryHeaderColor: const Color(0xff0087AE),
  dividerColor: const Color(0xff666666),
  splashColor: const Color(0xff333333),
  highlightColor: Colors.white,
  hintColor: Colors.white70,
  disabledColor: const Color(0xff38616f),
  cardColor: Colors.black,
  unselectedWidgetColor: Colors.black,
  scaffoldBackgroundColor: const Color(0xff222222),
  cupertinoOverrideTheme: const CupertinoThemeData(
      barBackgroundColor: Color(0xff1d1d1d),
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'Poppins'),
      )),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Colors.white),
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return const Color(0xff0BBBEF);
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return const Color(0xff0BBBEF);
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return const Color(0xff0BBBEF);
      }
      return null;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return const Color(0xff0BBBEF);
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
  ).copyWith(surface: const Color(0xff222222)),
);
