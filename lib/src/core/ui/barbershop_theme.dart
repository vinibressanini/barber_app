import 'package:barber_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class BarbershopTheme {
  static const OutlineInputBorder _defaultBorderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: ColorsConstants.grey),
  );

  static ThemeData themeDate = ThemeData(
    useMaterial3: true,
    fontFamily: FontConstants.fontFamily,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: ColorsConstants.brown),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: FontConstants.fontFamily,
        fontSize: 18,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaultBorderDecoration,
      enabledBorder: _defaultBorderDecoration,
      focusedBorder: _defaultBorderDecoration,
      errorBorder: _defaultBorderDecoration.copyWith(
        borderSide: const BorderSide(color: ColorsConstants.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.brown,
        foregroundColor: ColorsConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsConstants.brown,
        backgroundColor: ColorsConstants.white,
        side: const BorderSide(color: ColorsConstants.brown),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
