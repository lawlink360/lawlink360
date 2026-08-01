import 'package:flutter/material.dart';

class VerificationSubCategory {
  final String id;

  /// Parent Category ID
  final String categoryId;

  final String title;
  final String description;

  final IconData icon;
  final Color color;

  /// Number of institutions inside this subcategory
  final int institutionCount;

  const VerificationSubCategory({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.institutionCount = 0,
  });
}