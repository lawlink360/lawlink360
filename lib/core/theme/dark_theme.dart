import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkBackground,

      colorScheme: const ColorScheme(
        brightness: Brightness.dark,

        primary: AppColors.accent,
        onPrimary: Colors.black,

        secondary: AppColors.secondary,
        onSecondary: Colors.white,

        error: AppColors.error,
        onError: Colors.white,

        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),

      cardColor: AppColors.darkSurface,

      dividerColor: AppColors.darkBorder,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        headlineMedium: AppTextStyles.headline,
        titleLarge: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySmall,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.button,
      ),
    );
  }
}