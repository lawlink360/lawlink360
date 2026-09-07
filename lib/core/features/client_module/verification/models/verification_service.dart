import 'package:flutter/material.dart';

class VerificationService {
  /// Unique Service ID
  final String id;

  /// Parent Category
  final String categoryId;

  /// Parent SubCategory
  final String subCategoryId;

  /// Parent Institution
  final String institutionId;

  /// Service Information
  final String title;
  final String description;
  final String websiteUrl;
  final String authority;

  /// UI
  final IconData icon;
  final Color color;

  /// Status
  final bool isOfficial;
  final bool isPopular;

  const VerificationService({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.institutionId,
    required this.title,
    required this.description,
    required this.websiteUrl,
    required this.authority,
    required this.icon,
    required this.color,
    this.isOfficial = true,
    this.isPopular = false,
  });
}