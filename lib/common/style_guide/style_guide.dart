// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'custom_color.dart';

/// Contains static props for TJB Mobile app style guide based on Material Design Guide.

class StyleGuide {
  static ThemeData themeData({
    Brightness brightness = Brightness.light,
  }) =>
      ThemeData(
        fontFamily: 'Poppins',
        colorScheme: _colorScheme(brightness),
      ).copyWith(
        primaryColorLight: const Color(0xffF8F7F0),
        shadowColor: Colors.black38,
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomColor.background,
          foregroundColor: CustomColor.text,
          centerTitle: true,
          elevation: 1,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CustomColor.primary,
          foregroundColor: CustomColor.background,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: CustomColor.secondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: CustomColor.primary,
            onPrimary: CustomColor.background,
          ),
        ),
        scaffoldBackgroundColor: CustomColor.background,
        checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.all<Color>(CustomColor.green)),
      );

  static ColorScheme _colorScheme(Brightness brightness) {
    return ColorScheme(
      primary: CustomColor.primary,
      onPrimary: CustomColor.background,
      secondary: CustomColor.secondary,
      onSecondary: CustomColor.background,
      surface: CustomColor.background,
      onSurface: CustomColor.text,
      error: CustomColor.error,
      onError: CustomColor.background,
      background: CustomColor.background,
      onBackground: CustomColor.text,
      brightness: brightness,
    );
  }
}
