import 'package:flutter/material.dart';

class CoreTheme {
  CoreTheme._();

  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    backgroundColor: Colors.black,
    primaryColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
