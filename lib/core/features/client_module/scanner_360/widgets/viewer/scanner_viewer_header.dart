import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Reusable header for the Scanner 360 document viewer.
///
/// Pure presentation. All actions are callbacks supplied by the
/// parent.
class ScannerViewerHeader extends StatelessWidget {
  const ScannerViewerHeader({
    super.key,
    required this.title,
    required this.isFavorite,
    required this.onBack,
    required this.onToggleFavorite,
    required this.onOpenMore,
  });

  final String title;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onToggleFavorite;
  final VoidCallback onOpenMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.lightTextPrimary,
            size: AppSpacing.iconMd,
          ),
          tooltip: 'Back',
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title,
          ),
        ),
        IconButton(
          onPressed: onToggleFavorite,
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite
                ? AppColors.accent
                : AppColors.lightTextSecondary,
            size: AppSpacing.iconMd,
          ),
          tooltip: isFavorite
              ? 'Remove from favourites'
              : 'Add to favourites',
        ),
        IconButton(
          onPressed: onOpenMore,
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.lightTextPrimary,
            size: AppSpacing.iconMd,
          ),
          tooltip: 'More',
        ),
      ],
    );
  }
}