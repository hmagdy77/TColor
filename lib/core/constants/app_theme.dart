import 'package:flutter/material.dart';

import 'app_color_manger.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: AppColorManger.primary,
    primaryColorLight: AppColorManger.lightFontColor,
    primaryColorDark: AppColorManger.darkFontColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 233, 230, 233),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(
        accentColor: AppColorManger.primary, brightness: Brightness.light),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'Cairo',
          color: AppColorManger.lightFontColor,
          fontSize: 32,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.lightFontColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final dark = ThemeData(
    primaryColor: AppColorManger.primary,
    primaryColorLight: AppColorManger.darkFontColor,
    primaryColorDark: AppColorManger.lightFontColor,
    scaffoldBackgroundColor: AppColorManger.darkScaffold,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColorManger.primary,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'Cairo',
          color: AppColorManger.darkFontColor,
          fontSize: 32,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        color: AppColorManger.darkFontColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
