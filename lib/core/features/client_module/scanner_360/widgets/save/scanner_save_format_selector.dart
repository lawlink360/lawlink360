import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_export_format.dart';

/// Segmented control for the export format.
class ScannerSaveFormatSelector extends StatelessWidget {
  const ScannerSaveFormatSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final ScannerExportFormat value;
  final ValueChanged<ScannerExportFormat> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Save format',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: ScannerExportFormat.values.map((f) {
            final selected = f == value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: f == ScannerExportFormat.searchablePdf
                      ? 0
                      : AppSpacing.sm,
                ),
                child: GestureDetector(
                  onTap: () => onChanged(f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.accent
                          : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: selected
                            ? AppColors.accent
                            : AppColors.lightBorder,
                      ),
                    ),
                    child: Text(
                      _labelFor(f),
                      style: AppTextStyles.body.copyWith(
                        color: selected
                            ? AppColors.primary
                            : AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(growable: false),
        ),
      ],
    );
  }

  static String _labelFor(ScannerExportFormat f) {
    switch (f) {
      case ScannerExportFormat.pdf:
        return 'PDF';
      case ScannerExportFormat.image:
        return 'Image';
      case ScannerExportFormat.both:
        return 'Both';
      case ScannerExportFormat.searchablePdf:
        return 'Searchable PDF';
    }
  }
}