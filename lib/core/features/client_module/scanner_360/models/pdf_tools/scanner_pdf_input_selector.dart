import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../screens/pdf_tools/scanner_pdf_library_picker_screen.dart';

/// Presents a bottom sheet that lets the user choose where to pick
/// an input PDF from:
///
///  - Device / Files  (via file_picker)
///  - Scanner Library (via ScannerPdfLibraryPickerScreen)
///
/// Returns a list of absolute file paths, or null if cancelled.
class ScannerPdfInputSelector {
  const ScannerPdfInputSelector();

  Future<List<String>?> pick({
    required BuildContext context,
    required WidgetRef ref,
    required bool allowMultiple,
  }) async {
    final source = await showModalBottomSheet<_InputSource>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.folder_open_outlined,
                color: AppColors.primary,
              ),
              title: const Text('From Device / Files'),
              onTap: () =>
                  Navigator.of(context).pop(_InputSource.device),
            ),
            ListTile(
              leading: const Icon(
                Icons.collections_bookmark_outlined,
                color: AppColors.primary,
              ),
              title: const Text('From Scanner Library'),
              onTap: () =>
                  Navigator.of(context).pop(_InputSource.library),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );

    if (source == null || !context.mounted) return null;

    switch (source) {
      case _InputSource.device:
        return _pickFromDevice(allowMultiple: allowMultiple);
      case _InputSource.library:
        return _pickFromLibrary(
          context: context,
          allowMultiple: allowMultiple,
        );
    }
  }

  Future<List<String>?> _pickFromDevice({
    required bool allowMultiple,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      allowMultiple: allowMultiple,
      withData: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final paths = result.files
        .map((f) => f.path)
        .whereType<String>()
        .toList(growable: false);

    if (paths.isEmpty) return null;
    return paths;
  }

  Future<List<String>?> _pickFromLibrary({
    required BuildContext context,
    required bool allowMultiple,
  }) async {
    // The library picker returns a single pdf path. Multiple
    // selections are not supported through this source today; the
    // caller may pick the library source more than once for
    // merge-style tools if needed.
    final selected = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const ScannerPdfLibraryPickerScreen(),
      ),
    );

    if (selected == null) return null;
    return <String>[selected];
  }
}

enum _InputSource {
  device,
  library,
}

/// A small helper widget that displays the currently selected input
/// paths and a button to open the selector.
class ScannerPdfInputSummary extends StatelessWidget {
  const ScannerPdfInputSummary({
    super.key,
    required this.paths,
    required this.onPick,
  });

  final List<String> paths;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (paths.isEmpty)
            Text(
              'No input selected.',
              style: AppTextStyles.bodySmall,
            )
          else
            ...paths.map(
              (path) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  path,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.folder_open_outlined),
            label: const Text('Select PDF'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size(
                double.infinity,
                AppSpacing.buttonHeight,
              ),
              side: const BorderSide(color: AppColors.lightBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}