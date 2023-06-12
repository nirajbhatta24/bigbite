import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(255, 244, 87, 87);
const COLOR_SECONDARY = Color.fromARGB(255, 239, 226, 246);
const COLOR_DARK = Color.fromARGB(255, 60, 60, 60);
const COLOR_BLACK = Colors.black;
const COLOR_GREY = Color.fromRGBO(179, 178, 179, 1);
const COLOR_WHITE = Colors.white;

class TAppTheme {
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.light,
      primaryColor: COLOR_PRIMARY,
      primaryColorDark: COLOR_DARK,
      primaryColorLight: COLOR_SECONDARY,
      fontFamily: 'OpenSans Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans Bold'),
          backgroundColor: COLOR_PRIMARY,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: COLOR_SECONDARY,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: COLOR_WHITE,
          foregroundColor: COLOR_BLACK,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
      iconTheme: const IconThemeData(
        color: COLOR_PRIMARY,
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.red,
      primaryColor: COLOR_DARK,
      primaryColorDark: COLOR_GREY,
      primaryColorLight: COLOR_WHITE,
      fontFamily: 'OpenSans Regular',
      scaffoldBackgroundColor: Colors.transparent,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: COLOR_PRIMARY,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: COLOR_GREY,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 252, 249, 249)),
          centerTitle: true,
          color: Color.fromARGB(234, 166, 165, 165),
          foregroundColor: COLOR_BLACK,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 253, 251, 251),
              fontWeight: FontWeight.bold)),
      iconTheme: const IconThemeData(
        color: COLOR_WHITE,
      ));
}
