import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class LightTheme {
  LightTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.lightBackground,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,

        primary: AppColors.primary,
        onPrimary: Colors.white,

        secondary: AppColors.secondary,
        onSecondary: Colors.white,

        error: AppColors.error,
        onError: Colors.white,

        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
      ),

      cardColor: AppColors.lightSurface,

      dividerColor: AppColors.lightBorder,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
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