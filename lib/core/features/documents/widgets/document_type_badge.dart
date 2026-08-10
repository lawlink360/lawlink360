import 'package:flutter/material.dart';

import '../models/document_type.dart';

class DocumentTypeBadge extends StatelessWidget {
  final DocumentType type;

  const DocumentTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (type) {
      case DocumentType.legal:
        color = Colors.indigo;
        label = "Legal";
        break;

      case DocumentType.application:
        color = Colors.orange;
        label = "Application";
        break;

      case DocumentType.scanned:
        color = Colors.teal;
        label = "Scanned";
        break;

      case DocumentType.translated:
        color = Colors.purple;
        label = "Translated";
        break;

      case DocumentType.verification:
        color = Colors.green;
        label = "Verified";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}