import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// View mode for the multi-page workspace.
enum ScannerMultipageViewMode { grid, reorder }

/// Bottom bar for the multi-page screen.
///
/// Presentation only. All actions come from the parent.
class ScannerMultipageBottomBar extends StatelessWidget {
  const ScannerMultipageBottomBar({
    super.key,
    required this.mode,
    required this.onModeChanged,
    required this.onAddPage,
    required this.onDeletePage,
    required this.onDone,
    required this.pageCount,
  });

  final ScannerMultipageViewMode mode;
  final ValueChanged<ScannerMultipageViewMode> onModeChanged;
  final VoidCallback onAddPage;
  final VoidCallback onDeletePage;
  final VoidCallback onDone;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.lightSurface,
        border: Border(
          top: BorderSide(color: AppColors.lightBorder),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ModeChip(
                label: 'Grid',
                isSelected: mode == ScannerMultipageViewMode.grid,
                onTap: () =>
                    onModeChanged(ScannerMultipageViewMode.grid),
              ),
              const SizedBox(width: AppSpacing.sm),
              _ModeChip(
                label: 'Reorder',
                isSelected: mode == ScannerMultipageViewMode.reorder,
                onTap: () =>
                    onModeChanged(ScannerMultipageViewMode.reorder),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onAddPage,
                  icon: const Icon(Icons.add_a_photo_outlined),
                  label: const Text('Add Page'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    minimumSize: const Size(
                      double.infinity,
                      AppSpacing.buttonHeight,
                    ),
                    side: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: pageCount == 0 ? null : onDeletePage,
                icon: const Icon(Icons.delete_outline),
                color: AppColors.error,
                tooltip: 'Delete active page',
              ),
              const SizedBox(width: AppSpacing.sm),
              ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  minimumSize: const Size(
                    0,
                    AppSpacing.buttonHeight,
                  ),
                ),
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent
              : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: isSelected
                ? AppColors.accent
                : AppColors.lightBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isSelected
                ? AppColors.primary
                : AppColors.lightTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}