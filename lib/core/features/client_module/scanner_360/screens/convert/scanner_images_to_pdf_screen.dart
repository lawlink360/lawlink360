import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../services/scanner_image_to_pdf_service.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Multi-image import → PDF conversion screen.
///
/// Phase 10D.1. Standalone feature. Does not create ScannerDocuments
/// and does not touch scanner sessions or storage index.
class ScannerImagesToPdfScreen extends StatefulWidget {
  const ScannerImagesToPdfScreen({super.key});

  @override
  State<ScannerImagesToPdfScreen> createState() =>
      _ScannerImagesToPdfScreenState();
}

class _ScannerImagesToPdfScreenState
    extends State<ScannerImagesToPdfScreen> {
  final ScannerImageToPdfService _service =
      const ScannerImageToPdfService();

  final List<String> _imagePaths = <String>[];

  bool _isGenerating = false;
  String? _errorMessage;

  static const List<String> _allowedExtensions = <String>[
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Images to PDF'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: _buildBody()),
                _buildBottomBar(),
              ],
            ),
            if (_isGenerating)
              const ScannerLoadingOverlay(
                label: 'Generating PDF…',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_imagePaths.isEmpty) {
      return _buildEmptyState();
    }
    return _buildImageList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_outlined,
              size: AppSpacing.iconLg,
              color: AppColors.lightTextSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No images selected',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Choose one or more images to combine into a PDF. '
              'Supported formats: JPG, JPEG, PNG, WebP.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: _isGenerating ? null : _pickImages,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Add Images'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Text(
            'Selected images (drag to reorder)',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Text(
              _errorMessage!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            itemCount: _imagePaths.length,
            onReorderItem: _onReorder,
            itemBuilder: (context, index) {
              final path = _imagePaths[index];
              return _ImageTile(
                key: ValueKey('$path-$index'),
                index: index,
                path: path,
                onRemove: _isGenerating
                    ? null
                    : () => _removeImage(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
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
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _isGenerating ? null : _pickImages,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Add Images'),
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
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: ElevatedButton(
              onPressed:
                  (_imagePaths.isEmpty || _isGenerating)
                      ? null
                      : _generatePdf,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.primary,
                minimumSize: const Size(
                  double.infinity,
                  AppSpacing.buttonHeight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: const Text('Generate PDF'),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Picker
  // ------------------------------------------------------------

  Future<void> _pickImages() async {
    setState(() => _errorMessage = null);

    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: true,
        withData: false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to open picker: $e';
      });
      return;
    }

    if (result == null || result.files.isEmpty) {
      // User cancelled or selected nothing.
      return;
    }

    final paths = result.files
        .map((f) => f.path)
        .whereType<String>()
        .toList(growable: false);

    if (paths.isEmpty) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'No valid image paths were returned.';
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _imagePaths.addAll(paths);
    });
  }

  // ------------------------------------------------------------
  // Reorder / remove
  // ------------------------------------------------------------

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _imagePaths.length) return;
    if (oldIndex == newIndex) return;

    setState(() {
      final path = _imagePaths.removeAt(oldIndex);
      final target = newIndex.clamp(0, _imagePaths.length);
      _imagePaths.insert(target, path);
    });
  }

  void _removeImage(int index) {
    if (index < 0 || index >= _imagePaths.length) return;
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  // ------------------------------------------------------------
  // Generate
  // ------------------------------------------------------------

  Future<void> _generatePdf() async {
    if (_imagePaths.isEmpty) return;
    if (_isGenerating) return;

    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });

    String? outputPath;
    try {
      outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save PDF',
        fileName: 'images_to_pdf.pdf',
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _errorMessage = 'Failed to open save dialog: $e';
      });
      return;
    }

    if (outputPath == null || outputPath.isEmpty) {
      // User cancelled. No error.
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
      });
      return;
    }

    final resolved = outputPath.toLowerCase().endsWith('.pdf')
        ? outputPath
        : '$outputPath.pdf';

    try {
      final saved = await _service.convert(
        imagePaths: List<String>.from(_imagePaths),
        outputPath: resolved,
      );

      if (!mounted) return;
      setState(() {
        _isGenerating = false;
      });

      await _showSuccessDialog(saved);
    } on ScannerImageToPdfException catch (e) {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _errorMessage = 'PDF generation failed: $e';
      });
    }
  }

  Future<void> _showSuccessDialog(String outputPath) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('PDF created'),
          content: Text(
            'Saved to:\n$outputPath',
            style: AppTextStyles.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// Image tile
// ============================================================

class _ImageTile extends StatelessWidget {
  const _ImageTile({
    super.key,
    required this.index,
    required this.path,
    required this.onRemove,
  });

  final int index;
  final String path;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final fileName = path.split(Platform.pathSeparator).last;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.lightBackground,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. $fileName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline),
            color: AppColors.error,
            tooltip: 'Remove',
          ),
          const Icon(
            Icons.drag_handle,
            color: AppColors.lightTextSecondary,
          ),
        ],
      ),
    );
  }
}