import 'package:flutter/material.dart';

class Themes {
  static ThemeData appTheme(bool use) {
    if (use) {
      return ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.lightBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.yellowAccent,
            minimumSize: const Size(64, 32),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    } else {
      return ThemeData(
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      );
    }
  }
}
