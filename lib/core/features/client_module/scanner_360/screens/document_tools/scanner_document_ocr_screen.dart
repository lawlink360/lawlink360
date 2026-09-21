import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_language.dart';
import '../../services/scanner_ocr_service.dart';
import '../../services/scanner_pdf_to_image_service.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Document Tools → OCR.
///
/// Phase 10D.6.1. Standalone conversion tool. Accepts an arbitrary
/// PDF, renders its pages to temporary images, runs OCR on each
/// page sequentially, and presents the combined text.
///
/// This is NOT the same feature as 10D.4's Image → Text. The input
/// here is a PDF, and its pages are rendered before OCR.
///
/// The feature is not connected to the scanner capture pipeline.
/// It does not create ScannerDocuments, ScannerPages, or touch
/// scanner storage, sessions, or repositories.
class ScannerDocumentOcrScreen extends ConsumerStatefulWidget {
  const ScannerDocumentOcrScreen({super.key});

  @override
  ConsumerState<ScannerDocumentOcrScreen> createState() =>
      _ScannerDocumentOcrScreenState();
}

class _ScannerDocumentOcrScreenState
    extends ConsumerState<ScannerDocumentOcrScreen> {
  final ScannerOcrService _ocrService = const ScannerOcrService();
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  static const int _dpi = 150;

  String? _pdfPath;
  bool _isProcessing = false;
  String? _errorMessage;
  String? _extractedText;
  int _pageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('OCR'),
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
                  if (_extractedText != null) _buildResult(),
                ],
              ),
            ),
            if (_isProcessing)
              const ScannerLoadingOverlay(
                label: 'Extracting text…',
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
            onPressed: _isProcessing ? null : _pickPdf,
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
  // Extract action
  // ------------------------------------------------------------

  Widget _buildExtractButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _extract,
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
    final text = _extractedText ?? '';

    if (text.trim().isEmpty) {
      return _buildEmptyText();
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
                '$_pageCount page'
                '${_pageCount == 1 ? '' : 's'} processed',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                constraints: const BoxConstraints(maxHeight: 360),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.lightBorder),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    text,
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
                onPressed: _isProcessing ? null : _copyText,
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
                onPressed: _isProcessing ? null : _shareText,
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

  Widget _buildEmptyText() {
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
            'No text detected',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$_pageCount page'
            '${_pageCount == 1 ? '' : 's'} were processed but no '
            'recognizable text was found. Try a clearer scan.',
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
      _extractedText = null;
      _pageCount = 0;
    });
  }

  Future<void> _extract() async {
    if (_isProcessing) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
      _extractedText = null;
      _pageCount = 0;
    });

    try {
      // 1. Render all pages to temporary images.
      final ScannerPdfToImageResult renderResult;
      try {
        renderResult = await const ScannerPdfToImageService().convert(
          pdfPath: pdfPath,
          pages: const <int>[],
          format: ScannerPdfToImageFormat.png,
          dpi: _dpi,
        );
      } on ScannerPdfToImageException catch (e) {
        throw _OcrPipelineException(
          'Failed to render PDF pages: ${e.message}',
        );
      } catch (e) {
        throw _OcrPipelineException(
          'Failed to render PDF pages: $e',
        );
      }

      final imagePaths = renderResult.imagePaths;
      if (imagePaths.isEmpty) {
        throw const _OcrPipelineException(
          'The PDF contains no pages.',
        );
      }

      // 2. OCR each page sequentially.
      final buffer = StringBuffer();
      for (var i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];

        if (buffer.isNotEmpty) {
          buffer.writeln();
          buffer.writeln();
        }
        buffer.writeln('--- Page ${i + 1} ---');
        buffer.writeln();

        try {
          final result = await _ocrService.extractText(
            imagePath: imagePath,
            language: ScannerLanguage.latin,
          );
          final pageText = result.text.trim();
          if (pageText.isNotEmpty) {
            buffer.writeln(pageText);
          }
        } on ScannerOcrException catch (e) {
          throw _OcrPipelineException(
            'OCR failed on page ${i + 1}: ${e.message}',
          );
        } catch (e) {
          throw _OcrPipelineException(
            'OCR failed on page ${i + 1}: $e',
          );
        }
      }

      final combined = buffer.toString().trim();

      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _extractedText = combined;
        _pageCount = imagePaths.length;
      });
    } on _OcrPipelineException catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _errorMessage = 'OCR failed: $e';
      });
    }
  }

  Future<void> _copyText() async {
    final text = _extractedText;
    if (text == null || text.trim().isEmpty) return;

    try {
      await Clipboard.setData(ClipboardData(text: text));
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
    final text = _extractedText;
    if (text == null || text.trim().isEmpty) return;

    try {
      await Share.share(
        text,
        subject: 'OCR text',
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

/// Internal exception used to unify pipeline errors for the UI.
class _OcrPipelineException implements Exception {
  const _OcrPipelineException(this.message);

  final String message;
}