import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_type.dart';

class DocumentTypeBadge extends StatelessWidget {
  final DocumentType type;

  const DocumentTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final (Color color, String label) = switch (type) {
      DocumentType.legal => (
          AppColors.info,
          'Legal',
        ),
      DocumentType.application => (
          AppColors.warning,
          'Application',
        ),
      DocumentType.scanned => (
          AppColors.secondary,
          'Scanned',
        ),
      DocumentType.translated => (
          AppColors.accent,
          'Translated',
        ),
      DocumentType.verification => (
          AppColors.success,
          'Verified',
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}