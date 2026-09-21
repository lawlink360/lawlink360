import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../services/scanner_searchable_pdf_service.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Searchable PDF conversion screen.
///
/// Phase 10D.5. Standalone conversion tool. Does not create
/// ScannerDocuments and does not touch scanner sessions, storage,
/// or the scanner library.
class ScannerSearchablePdfScreen extends ConsumerStatefulWidget {
  const ScannerSearchablePdfScreen({super.key});

  @override
  ConsumerState<ScannerSearchablePdfScreen> createState() =>
      _ScannerSearchablePdfScreenState();
}

class _ScannerSearchablePdfScreenState
    extends ConsumerState<ScannerSearchablePdfScreen> {
  final ScannerSearchablePdfService _service =
      const ScannerSearchablePdfService();
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  String? _pdfPath;
  bool _isConverting = false;
  String? _errorMessage;
  ScannerSearchablePdfResult? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Searchable PDF'),
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
            if (_isConverting)
              const ScannerLoadingOverlay(
                label: 'Generating searchable PDF…',
              ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PDF selection
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
            onPressed: _isConverting ? null : _pickPdf,
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
  // Generate
  // ------------------------------------------------------------

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton(
        onPressed: _isConverting ? null : _generate,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: const Text('Generate Searchable PDF'),
      ),
    );
  }

  // ------------------------------------------------------------
  // Result
  // ------------------------------------------------------------

  Widget _buildResult() {
    final result = _result!;
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
            'Searchable PDF ready',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${result.pageCount} page'
            '${result.pageCount == 1 ? '' : 's'}',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _isConverting ? null : _sharePdf,
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share Searchable PDF'),
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
    if (_isConverting) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }

    setState(() {
      _isConverting = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final result = await _service.convert(sourcePdfPath: pdfPath);

      if (!mounted) return;
      setState(() {
        _isConverting = false;
        _result = result;
      });
    } on ScannerSearchablePdfException catch (e) {
      if (!mounted) return;
      setState(() {
        _isConverting = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isConverting = false;
        _errorMessage = 'Conversion failed: $e';
      });
    }
  }

  Future<void> _sharePdf() async {
    final result = _result;
    if (result == null) return;

    try {
      await Share.shareXFiles(
        [XFile(result.outputPath)],
        subject: 'Searchable PDF',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to share PDF: $e';
      });
    }
  }
}