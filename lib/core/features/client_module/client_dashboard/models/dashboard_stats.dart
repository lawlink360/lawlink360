import 'package:flutter/material.dart';

class DashboardStat {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const DashboardStat({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });
}