import 'package:flutter/material.dart';

class FormFieldModel {
  final String keyName;
  final String label;
  final TextInputType keyboardType;
  final int maxLines;

  const FormFieldModel({
    required this.keyName,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });
}