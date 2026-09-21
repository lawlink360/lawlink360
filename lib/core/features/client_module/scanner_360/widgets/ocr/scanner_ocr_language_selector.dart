import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../models/scanner_language.dart';

/// Dropdown selector for the OCR language.
class ScannerOcrLanguageSelector extends StatelessWidget {
  const ScannerOcrLanguageSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final ScannerLanguage value;
  final ValueChanged<ScannerLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: DropdownButton<ScannerLanguage>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        borderRadius: BorderRadius.circular(AppRadius.md),
        items: ScannerLanguage.values
            .map(
              (l) => DropdownMenuItem(
                value: l,
                child: Text(_labelFor(l)),
              ),
            )
            .toList(growable: false),
        onChanged: (v) {
          if (v == null) return;
          onChanged(v);
        },
      ),
    );
  }

  static String _labelFor(ScannerLanguage language) {
    switch (language) {
      case ScannerLanguage.latin:
        return 'Latin';
      case ScannerLanguage.chinese:
        return 'Chinese';
      case ScannerLanguage.devanagari:
        return 'Devanagari';
      case ScannerLanguage.japanese:
        return 'Japanese';
      case ScannerLanguage.korean:
        return 'Korean';
    }
  }
}