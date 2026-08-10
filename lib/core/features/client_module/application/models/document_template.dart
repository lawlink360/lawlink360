import 'package:flutter/material.dart';


class DocumentTemplate {
  final String id;
  final String subCategoryId;
  final String title;
  final String description;
  final String body; // NEW
  final IconData icon;
  final Color color;
  final bool isPopular;

  const DocumentTemplate({
    required this.id,
    required this.subCategoryId,
    required this.title,
    required this.description,
    required this.body, // NEW
    required this.icon,
    required this.color,
    this.isPopular = false,
  });
}
