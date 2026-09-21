import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/ocr_block.dart';

/// Renders a single OCR block.
class ScannerOcrBlockTile extends StatelessWidget {
  const ScannerOcrBlockTile({
    super.key,
    required this.block,
  });

  final OcrBlock block;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Text(
        block.text,
        style: AppTextStyles.body,
      ),
    );
  }
}