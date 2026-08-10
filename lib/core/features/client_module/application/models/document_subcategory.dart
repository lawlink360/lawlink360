import 'package:flutter/material.dart';

class DocumentSubCategory {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int templateCount;

  const DocumentSubCategory({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.templateCount,
  });
}