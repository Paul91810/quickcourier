import 'package:flutter/material.dart';
import 'package:quickcourier/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;

    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.lightSecondary,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightPrimary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSecondary,
        foregroundColor: AppColors.lightPrimary,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20 * scale,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimary,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.lightPrimary,
        elevation: 4,
        margin: EdgeInsets.all(8),
        shadowColor: Colors.black26,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.lightSecondary),
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightPrimary),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightSecondary),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14 * scale)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightSecondary),
          side: const WidgetStatePropertyAll(BorderSide(color: AppColors.lightSecondary)),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14 * scale)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32 * scale,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 28 * scale,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 24 * scale,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(fontSize: 16 * scale, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14 * scale, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 12 * scale, color: Colors.black54),
        labelLarge: TextStyle(
          fontSize: 14 * scale,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelMedium: TextStyle(fontSize: 12 * scale, color: Colors.black87),
        labelSmall: TextStyle(fontSize: 11 * scale, color: Colors.black54),
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 375;

    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.lightSecondary,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSecondary,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20 * scale,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimary,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.lightPrimary,
        elevation: 4,
        margin: EdgeInsets.all(8),
        shadowColor: Colors.black26,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.lightPrimary),
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightPrimary),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightSecondary),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14 * scale)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(AppColors.lightSecondary),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.lightSecondary),
          ),
          textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14 * scale)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32 * scale,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28 * scale,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24 * scale,
          fontWeight: FontWeight.bold,
          color: AppColors.lightPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 16 * scale, color: AppColors.lightPrimary),
        bodyMedium: TextStyle(fontSize: 14 * scale, color: AppColors.lightPrimary),
        bodySmall: TextStyle(fontSize: 12 * scale, color: AppColors.lightPrimary),
        labelLarge: TextStyle(
          fontSize: 14 * scale,
          fontWeight: FontWeight.w600,
          color: AppColors.lightPrimary,
        ),
        labelMedium: TextStyle(fontSize: 12 * scale, color: AppColors.lightPrimary),
        labelSmall: TextStyle(fontSize: 11 * scale, color: AppColors.lightPrimary),
      ),
    );
  }
}
