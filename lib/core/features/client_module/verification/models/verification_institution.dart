import 'package:flutter/material.dart';

class VerificationInstitution {
  final String id;

  /// Parent Category ID
  final String categoryId;

  /// Parent SubCategory ID
  final String subCategoryId;

  final String title;
  final String description;

  final IconData icon;
  final Color color;

  /// Number of services inside this institution
  final int serviceCount;

  const VerificationInstitution({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.serviceCount = 0,
  });
}