import 'package:flutter/material.dart';

/// Represents an item in the LawLink360 Admin navigation menu.
class AdminMenuItemModel {
  final String title;
  final String route;
  final IconData icon;
  final String? subtitle;
  final bool showInBottomNavigation;

  const AdminMenuItemModel({
    required this.title,
    required this.route,
    required this.icon,
    this.subtitle,
    this.showInBottomNavigation = false,
  });
}