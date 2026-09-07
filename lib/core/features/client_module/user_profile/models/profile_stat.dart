import 'package:flutter/material.dart';

class ProfileStat {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String title;

  const ProfileStat({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.title,
  });
}