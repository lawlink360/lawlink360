import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_radius.dart';
import '../../../../../../../core/theme/app_spacing.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import 'package:lawlink360/core/features/client_module/scanner_360/services/scanner_pdf_to_image_service.dart';
import 'package:lawlink360/core/features/client_module/scanner_360/widgets/pdf_tools/scanner_pdf_input_selector.dart';
import 'package:lawlink360/core/features/client_module/scanner_360/widgets/shared/scanner_loading_overlay.dart';

/// PDF → Images conversion screen.
///
/// Phase 10D.2. Standalone conversion tool. Does not create
/// ScannerDocuments and does not touch scanner sessions, storage,
/// or the scanner library.
class ScannerPdfToImagesScreen extends ConsumerStatefulWidget {
  const ScannerPdfToImagesScreen({super.key});

  @override
  ConsumerState<ScannerPdfToImagesScreen> createState() =>
      _ScannerPdfToImagesScreenState();
}

class _ScannerPdfToImagesScreenState
    extends ConsumerState<ScannerPdfToImagesScreen> {
  final ScannerPdfToImageService _service =
      const ScannerPdfToImageService();
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  final TextEditingController _rangeController =
      TextEditingController();

  String? _pdfPath;
  ScannerPdfToImageFormat _format = ScannerPdfToImageFormat.png;
  int _dpi = 150;

  bool _isGenerating = false;
  String? _errorMessage;
  ScannerPdfToImageResult? _result;

  @override
  void dispose() {
    _rangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('PDF to Images'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPdfSelection(),
                  const SizedBox(height: AppSpacing.lg),
                  if (_pdfPath != null) ...[
                    _buildConfiguration(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildGenerateButton(),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  if (_result != null) _buildResult(),
                ],
              ),
            ),
            if (_isGenerating)
              const ScannerLoadingOverlay(
                label: 'Generating images…',
              ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Selection
  // ------------------------------------------------------------

  Widget _buildPdfSelection() {
    final fileName = _pdfPath == null
        ? 'No PDF selected.'
        : _pdfPath!.split(Platform.pathSeparator).last;

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
          Text(
            'PDF file',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            fileName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: _isGenerating ? null : _pickPdf,
            icon: const Icon(Icons.picture_as_pdf_outlined),
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

  // ------------------------------------------------------------
  // Configuration
  // ------------------------------------------------------------

  Widget _buildConfiguration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuration',
          style: AppTextStyles.title,
        ),
        const SizedBox(height: AppSpacing.md),

        // Page range
        Text(
          'Page range',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _rangeController,
          enabled: !_isGenerating,
          decoration: InputDecoration(
            hintText: 'All pages (or 1-5, 1,3,7, 1-5,8,10-12)',
            filled: true,
            fillColor: AppColors.lightSurface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
          ),
          style: AppTextStyles.body,
        ),
        const SizedBox(height: AppSpacing.md),

        // Format
        Text(
          'Output format',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: _buildChoice(
                label: 'PNG',
                isSelected: _format == ScannerPdfToImageFormat.png,
                onTap: _isGenerating
                    ? null
                    : () => setState(
                          () => _format = ScannerPdfToImageFormat.png,
                        ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildChoice(
                label: 'JPEG',
                isSelected: _format == ScannerPdfToImageFormat.jpeg,
                onTap: _isGenerating
                    ? null
                    : () => setState(
                          () => _format = ScannerPdfToImageFormat.jpeg,
                        ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // DPI
        Text(
          'Resolution',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: _buildChoice(
                label: '72 DPI',
                isSelected: _dpi == 72,
                onTap: _isGenerating
                    ? null
                    : () => setState(() => _dpi = 72),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildChoice(
                label: '150 DPI',
                isSelected: _dpi == 150,
                onTap: _isGenerating
                    ? null
                    : () => setState(() => _dpi = 150),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildChoice(
                label: '300 DPI',
                isSelected: _dpi == 300,
                onTap: _isGenerating
                    ? null
                    : () => setState(() => _dpi = 300),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChoice({
    required String label,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.lightBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: isSelected
                ? AppColors.primary
                : AppColors.lightTextPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Generate
  // ------------------------------------------------------------

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton(
        onPressed: _isGenerating ? null : _generate,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: const Text('Generate Images'),
      ),
    );
  }

  // ------------------------------------------------------------
  // Result
  // ------------------------------------------------------------

  Widget _buildResult() {
    final result = _result!;
    final formatLabel =
        _format == ScannerPdfToImageFormat.png ? 'PNG' : 'JPEG';

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
          Text(
            'Result',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${result.imagePaths.length} image'
            '${result.imagePaths.length == 1 ? '' : 's'} generated '
            '• $formatLabel • $_dpi DPI',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: result.imagePaths.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final path = result.imagePaths[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.file(
                    File(path),
                    width: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 90,
                      color: AppColors.lightBackground,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isGenerating ? null : _shareImages,
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Share Images'),
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
                child: OutlinedButton.icon(
                  onPressed: _isGenerating ? null : _shareZip,
                  icon: const Icon(Icons.folder_zip_outlined),
                  label: const Text('Share ZIP'),
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
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  Future<void> _pickPdf() async {
    setState(() => _errorMessage = null);

    List<String>? paths;
    try {
      paths = await _inputSelector.pick(
        context: context,
        ref: ref,
        allowMultiple: false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to open picker: $e';
      });
      return;
    }

    if (paths == null || paths.isEmpty) return;

    if (!mounted) return;
    setState(() {
      _pdfPath = paths!.first;
      _result = null;
    });
  }

  Future<void> _generate() async {
    if (_isGenerating) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }

    final List<int> pages;
    try {
      pages = _parsePageRange(_rangeController.text);
    } on FormatException catch (e) {
      setState(() => _errorMessage = e.message);
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final result = await _service.convert(
        pdfPath: pdfPath,
        pages: pages,
        format: _format,
        dpi: _dpi,
      );

      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _result = result;
      });
    } on ScannerPdfToImageException catch (e) {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _errorMessage = 'Conversion failed: $e';
      });
    }
  }

  Future<void> _shareImages() async {
    final result = _result;
    if (result == null) return;

    try {
      await Share.shareXFiles(
        result.imagePaths.map((p) => XFile(p)).toList(growable: false),
        subject: 'PDF pages',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to share images: $e';
      });
    }
  }

  Future<void> _shareZip() async {
    final result = _result;
    if (result == null) return;

    try {
      await Share.shareXFiles(
        [XFile(result.zipPath)],
        subject: 'PDF pages (ZIP)',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to share ZIP: $e';
      });
    }
  }

  // ------------------------------------------------------------
  // Page range parsing
  // ------------------------------------------------------------

  /// Parses a page-range expression.
  ///
  /// Returns an empty list when the input is blank, which the
  /// service interprets as "all pages".
  ///
  /// Throws [FormatException] on malformed, zero, negative, or
  /// inverted input.
  List<int> _parsePageRange(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const <int>[];
    }

    final pages = <int>{};
    final parts = trimmed.split(',');
    for (final part in parts) {
      final element = part.trim();
      if (element.isEmpty) continue;

      if (element.contains('-')) {
        final pieces = element.split('-');
        if (pieces.length != 2) {
          throw FormatException(
            'Malformed range "$element". Use a form like 1-5.',
          );
        }
        final start = int.tryParse(pieces[0].trim());
        final end = int.tryParse(pieces[1].trim());
        if (start == null || end == null) {
          throw FormatException(
            'Range "$element" must contain integers.',
          );
        }
        if (start < 1 || end < 1) {
          throw const FormatException(
            'Page numbers must be 1 or greater.',
          );
        }
        if (end < start) {
          throw FormatException(
            'Range "$element" is inverted.',
          );
        }
        for (var i = start; i <= end; i++) {
          pages.add(i);
        }
      } else {
        final value = int.tryParse(element);
        if (value == null) {
          throw FormatException(
            '"$element" is not a valid page number.',
          );
        }
        if (value < 1) {
          throw const FormatException(
            'Page numbers must be 1 or greater.',
          );
        }
        pages.add(value);
      }
    }

    if (pages.isEmpty) {
      throw const FormatException(
        'No valid pages were specified.',
      );
    }

    final sorted = pages.toList()..sort();
    return sorted;
  }
}