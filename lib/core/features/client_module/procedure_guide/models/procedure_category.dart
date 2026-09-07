import 'package:flutter/material.dart';

class ProcedureCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const ProcedureCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}