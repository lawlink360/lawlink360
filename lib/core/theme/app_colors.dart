import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==========================
  // Brand Colors
  // ==========================

  static const Color primary = Color(0xFF0B1F3A);
  static const Color secondary = Color(0xFF4A6FA5);
  static const Color accent = Color(0xFFD4AF37);

  // ==========================
  // LIGHT THEME
  // ==========================

  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightBorder = Color(0xFFE5E7EB);

  // ==========================
  // DARK THEME
  // ==========================

  static const Color darkBackground = Color(0xFF0F1115);
  static const Color darkSurface = Color(0xFF1B1F26);

  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB4BBC8);

  static const Color darkBorder = Color(0xFF353C48);

  // ==========================
  // Status
  // ==========================

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ==========================
  // Glass Effects
  // ==========================

  static const Color glassWhite = Color(0x33FFFFFF);
  static const Color glassDark = Color(0x22000000);

  static const Color overlayDark = Color(0x73000000);
  static const Color overlayLight = Color(0x11FFFFFF);

  // ==========================
// Backward Compatibility
// ==========================

static const Color background = lightBackground;
static const Color surface = lightSurface;

static const Color textPrimary = lightTextPrimary;
static const Color textSecondary = lightTextSecondary;
static const Color textLight = Colors.white;

static const Color border = lightBorder;
static const Color divider = lightBorder;
}