import 'package:flutter/material.dart';

class SettingsItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;

  /// If true, this item displays a switch instead of a navigation arrow.
  final bool isSwitch;

  /// Current value of the switch.
  final bool switchValue;

  /// Future navigation callback.
  final VoidCallback? onTap;

  const SettingsItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isSwitch = false,
    this.switchValue = false,
    this.onTap,
  });
}