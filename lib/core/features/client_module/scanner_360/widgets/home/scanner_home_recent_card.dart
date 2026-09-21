import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document.dart';

/// Card representing a single recently saved document.
class ScannerHomeRecentCard extends StatelessWidget {
  const ScannerHomeRecentCard({
    super.key,
    required this.document,
    required this.onTap,
  });

  final ScannerDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = document.metadata;

    return Material(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: AppColors.primary,
                    size: AppSpacing.iconMd,
                  ),
                  const Spacer(),
                  if (meta.isFavorite)
                    const Icon(
                      Icons.star,
                      color: AppColors.accent,
                      size: AppSpacing.iconSm,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: Text(
                  meta.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _formatDate(meta.updatedAt),
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${meta.pageCount} page${meta.pageCount == 1 ? '' : 's'}',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }
}