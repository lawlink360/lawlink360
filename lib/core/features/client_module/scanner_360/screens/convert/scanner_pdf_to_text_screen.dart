import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../services/scanner_pdf_to_text_service.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// PDF → Text extraction screen.
///
/// Phase 10D.3. Standalone conversion tool. Does not create
/// ScannerDocuments and does not touch scanner sessions, storage,
/// or the scanner library.
class ScannerPdfToTextScreen extends ConsumerStatefulWidget {
  const ScannerPdfToTextScreen({super.key});

  @override
  ConsumerState<ScannerPdfToTextScreen> createState() =>
      _ScannerPdfToTextScreenState();
}

class _ScannerPdfToTextScreenState
    extends ConsumerState<ScannerPdfToTextScreen> {
  final ScannerPdfToTextService _service =
      const ScannerPdfToTextService();
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  String? _pdfPath;
  bool _isExtracting = false;
  String? _errorMessage;
  ScannerPdfToTextResult? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('PDF to Text'),
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
                    _buildExtractButton(),
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
            if (_isExtracting)
              const ScannerLoadingOverlay(
                label: 'Extracting text…',
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
            onPressed: _isExtracting ? null : _pickPdf,
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
  // Extract
  // ------------------------------------------------------------

  Widget _buildExtractButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton(
        onPressed: _isExtracting ? null : _extract,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: const Text('Extract Text'),
      ),
    );
  }

  // ------------------------------------------------------------
  // Result
  // ------------------------------------------------------------

  Widget _buildResult() {
    final result = _result!;

    if (!result.hasText) {
      return _buildEmptyText(result);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                'Extracted text',
                style: AppTextStyles.title,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${result.pageCount} page'
                '${result.pageCount == 1 ? '' : 's'}',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                constraints: const BoxConstraints(maxHeight: 320),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.lightBorder),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result.text,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isExtracting ? null : _copyText,
                icon: const Icon(Icons.copy_outlined),
                label: const Text('Copy Text'),
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
                onPressed: _isExtracting ? null : _shareText,
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share Text'),
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
    );
  }

  Widget _buildEmptyText(ScannerPdfToTextResult result) {
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
            'No extractable text',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'The PDF contains ${result.pageCount} page'
            '${result.pageCount == 1 ? '' : 's'} but no embedded '
            'text layer. Scanned or image-only PDFs require OCR '
            'to extract their content.',
            style: AppTextStyles.bodySmall,
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

  Future<void> _extract() async {
    if (_isExtracting) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }

    setState(() {
      _isExtracting = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final result = await _service.extract(pdfPath: pdfPath);

      if (!mounted) return;
      setState(() {
        _isExtracting = false;
        _result = result;
      });
    } on ScannerPdfToTextException catch (e) {
      if (!mounted) return;
      setState(() {
        _isExtracting = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isExtracting = false;
        _errorMessage = 'Extraction failed: $e';
      });
    }
  }

  Future<void> _copyText() async {
    final result = _result;
    if (result == null || !result.hasText) return;

    try {
      await Clipboard.setData(ClipboardData(text: result.text));
      if (!mounted) return;
      _showSnackBar('Copied');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to copy text: $e';
      });
    }
  }

  Future<void> _shareText() async {
    final result = _result;
    if (result == null || !result.hasText) return;

    try {
      await Share.share(
        result.text,
        subject: 'PDF text',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to share text: $e';
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}