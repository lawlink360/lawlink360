import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_mode.dart';
import '../../providers/scanner_session_provider.dart';

/// Mode chips for Scanner 360.
class ScannerCameraModeToggle extends ConsumerWidget {
  const ScannerCameraModeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(scannerSessionProvider);
    final currentMode = session?.mode;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: ScannerMode.values.map((mode) {
        final isSelected = mode == currentMode;
        return _ModeChip(
          label: _labelFor(mode),
          isSelected: isSelected,
          onTap: session == null
              ? null
              : () => ref
                  .read(scannerSessionProvider.notifier)
                  .updateMode(mode),
        );
      }).toList(growable: false),
    );
  }

  static String _labelFor(ScannerMode mode) {
    switch (mode) {
      case ScannerMode.document:
        return 'Document';
      case ScannerMode.ocr:
        return 'OCR';
      case ScannerMode.batch:
        return 'Batch';
      case ScannerMode.idCard:
        return 'ID Card';
    }
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
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent
              : AppColors.glassWhite,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isSelected
                ? AppColors.primary
                : AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}