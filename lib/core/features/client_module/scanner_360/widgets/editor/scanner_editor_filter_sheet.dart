import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scan_filter.dart';

/// Bottom sheet listing the five filter presets.
///
/// Selecting a filter calls [onSelect]. The filter is not applied
/// to the file here; the editor screen holds it as a pending edit
/// until Save is tapped.
class ScannerEditorFilterSheet extends StatelessWidget {
  const ScannerEditorFilterSheet({
    super.key,
    required this.currentFilter,
    required this.onSelect,
  });

  final ScanFilter currentFilter;
  final ValueChanged<ScanFilter> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: ScanFilter.values.map((filter) {
                final selected = filter == currentFilter;
                return _FilterTile(
                  label: _labelFor(filter),
                  isSelected: selected,
                  onTap: () => onSelect(filter),
                );
              }).toList(growable: false),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  static String _labelFor(ScanFilter filter) {
    switch (filter) {
      case ScanFilter.original:
        return 'Original';
      case ScanFilter.grayscale:
        return 'Grayscale';
      case ScanFilter.blackAndWhite:
        return 'Black & White';
      case ScanFilter.enhanced:
        return 'Enhanced';
      case ScanFilter.magicColor:
        return 'Magic Color';
    }
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent
              : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected
                ? AppColors.accent
                : AppColors.lightBorder,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_vintage_outlined,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.lightTextSecondary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.lightTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}