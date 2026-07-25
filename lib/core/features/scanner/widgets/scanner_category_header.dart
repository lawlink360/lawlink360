import 'package:flutter/material.dart';

class ScannerCategoryHeader extends StatelessWidget {
  final String title;

  const ScannerCategoryHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 26,
        bottom: 14,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xff0D1B2A),
        ),
      ),
    );
  }
}