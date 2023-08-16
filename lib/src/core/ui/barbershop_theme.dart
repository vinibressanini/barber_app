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
  );
}
