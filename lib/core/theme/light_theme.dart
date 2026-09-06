import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class LightTheme {
  LightTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ============================================================
      // Global
      // ============================================================

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

      // ============================================================
      // App Bar
      // ============================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: AppSpacing.appBarHeight,
        titleTextStyle: AppTextStyles.title,
      ),

      // ============================================================
      // Cards
      // ============================================================

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
      ),

      // ============================================================
      // Dividers
      // ============================================================

      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),

      // ============================================================
      // Elevated Buttons
      // ============================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // ============================================================
      // Outlined Buttons
      // ============================================================

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          side: const BorderSide(
            color: AppColors.lightBorder,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTextStyles.button.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),

      // ============================================================
      // Text Buttons
      // ============================================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          textStyle: AppTextStyles.button.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),

      // ============================================================
      // Input Fields
      // ============================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColors.lightTextSecondary,
        ),
        labelStyle: const TextStyle(
          color: AppColors.lightTextSecondary,
        ),
      ),

      // ============================================================
      // Typography
      // ============================================================

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        headlineMedium: AppTextStyles.headline,
        titleLarge: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySmall,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.button,
      ),

      // ============================================================
      // Bottom Navigation
      // ============================================================

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        height: 80,

        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysShow,

        indicatorColor: AppColors.lightBackground,

        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: AppColors.accent,
                size: 24,
              );
            }

            return const IconThemeData(
              color: AppColors.lightTextSecondary,
              size: 24,
            );
          },
        ),

        labelTextStyle:
            WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              );
            }

            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.lightTextSecondary,
            );
          },
        ),
      ),

      // ============================================================
      // Dialogs
      // ============================================================

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),

      // ============================================================
      // Snackbar
      // ============================================================

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}