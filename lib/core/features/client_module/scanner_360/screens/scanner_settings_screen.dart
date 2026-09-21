import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import '../models/scan_filter.dart';
import '../models/scan_settings.dart';
import '../models/scanner_export_format.dart';
import '../models/scanner_language.dart';
import '../providers/scanner_settings_provider.dart';

/// Scanner-specific settings screen.
///
/// All setting widgets are inlined as private widgets in this file
/// per the Phase 6A decision to keep the folder tree unchanged.
class ScannerSettingsScreen extends ConsumerWidget {
  const ScannerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(scannerSettingsProvider);
    final notifier = ref.read(scannerSettingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Scanner Settings'),
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _SectionTitle(label: 'Capture'),
          _SwitchTile(
            title: 'Auto capture',
            subtitle:
                'Capture automatically when the document is stable.',
            value: settings.autoCapture,
            onChanged: notifier.setAutoCapture,
          ),
          _DropdownTile<ScannerFlashMode>(
            title: 'Default flash',
            value: settings.defaultFlash,
            items: ScannerFlashMode.values,
            labelBuilder: _flashLabel,
            onChanged: notifier.setDefaultFlash,
          ),
          _SectionTitle(label: 'Image'),
          _DropdownTile<ScanFilter>(
            title: 'Default filter',
            value: settings.defaultFilter,
            items: ScanFilter.values,
            labelBuilder: _filterLabel,
            onChanged: notifier.setDefaultFilter,
          ),
          _SwitchTile(
            title: 'Auto enhance',
            subtitle: 'Improve brightness and contrast after capture.',
            value: settings.autoEnhance,
            onChanged: notifier.setAutoEnhance,
          ),
          _DropdownTile<ScannerImageQuality>(
            title: 'Image quality',
            value: settings.imageQuality,
            items: ScannerImageQuality.values,
            labelBuilder: (v) => v.name,
            onChanged: notifier.setImageQuality,
          ),
          _SectionTitle(label: 'Output'),
          _DropdownTile<ScannerPdfQuality>(
            title: 'PDF quality',
            value: settings.pdfQuality,
            items: ScannerPdfQuality.values,
            labelBuilder: (v) => v.name,
            onChanged: notifier.setPdfQuality,
          ),
          _DropdownTile<ScannerExportFormat>(
            title: 'Save format',
            value: settings.saveFormat,
            items: ScannerExportFormat.values,
            labelBuilder: (v) => v.name.toUpperCase(),
            onChanged: notifier.setSaveFormat,
          ),
          _SectionTitle(label: 'Text recognition'),
          _DropdownTile<ScannerLanguage>(
            title: 'OCR language',
            value: settings.ocrLanguage,
            items: ScannerLanguage.values,
            labelBuilder: _languageLabel,
            onChanged: notifier.setOcrLanguage,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Labels
  // ------------------------------------------------------------

  static String _flashLabel(ScannerFlashMode mode) {
    switch (mode) {
      case ScannerFlashMode.off:
        return 'Off';
      case ScannerFlashMode.auto:
        return 'Auto';
      case ScannerFlashMode.on:
        return 'On';
    }
  }

  static String _filterLabel(ScanFilter filter) {
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

  static String _languageLabel(ScannerLanguage language) {
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

// ============================================================
// Inline private widgets
// ============================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: SwitchListTile(
        title: Text(title, style: AppTextStyles.body),
        subtitle: Text(subtitle, style: AppTextStyles.caption),
        value: value,
        activeThumbColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }
}

class _DropdownTile<T> extends StatelessWidget {
  const _DropdownTile({
    required this.title,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String title;
  final T value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: AppTextStyles.body),
          ),
          DropdownButton<T>(
            value: value,
            underline: const SizedBox.shrink(),
            borderRadius: BorderRadius.circular(AppRadius.md),
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(labelBuilder(e)),
                  ),
                )
                .toList(growable: false),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}