import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/ocr_result.dart';
import '../../models/scanner_language.dart';
import '../../services/scanner_ocr_service.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Image → Text conversion screen.
///
/// Phase 10D.4. Standalone conversion tool. Does not create
/// ScannerDocuments and does not touch scanner sessions, storage,
/// or the scanner library.
///
/// The selected image is an arbitrary conversion input. It is
/// processed only by [ScannerOcrService.extractText], which
/// accepts an arbitrary image path and returns a standalone
/// [OcrResult].
class ScannerImageToTextScreen extends StatefulWidget {
  const ScannerImageToTextScreen({super.key});

  @override
  State<ScannerImageToTextScreen> createState() =>
      _ScannerImageToTextScreenState();
}

class _ScannerImageToTextScreenState
    extends State<ScannerImageToTextScreen> {
  final ScannerOcrService _service = const ScannerOcrService();

  static const List<String> _allowedExtensions = <String>[
    'jpg',
    'jpeg',
    'png',
    'webp',
  ];

  String? _imagePath;
  bool _isExtracting = false;
  String? _errorMessage;
  OcrResult? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Image to Text'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSelection(),
                  const SizedBox(height: AppSpacing.lg),
                  if (_imagePath != null) ...[
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
  // Image selection
  // ------------------------------------------------------------

  Widget _buildImageSelection() {
    final fileName = _imagePath == null
        ? 'No image selected.'
        : _imagePath!.split(Platform.pathSeparator).last;

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
            'Image file',
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
            onPressed: _isExtracting ? null : _pickImage,
            icon: const Icon(Icons.image_outlined),
            label: const Text('Select Image'),
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

    if (result.text.trim().isEmpty) {
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
            'No text detected in this image. Try a clearer '
            'photo with visible text.',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  Future<void> _pickImage() async {
    setState(() => _errorMessage = null);

    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: false,
        withData: false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to open picker: $e';
      });
      return;
    }

    if (result == null || result.files.isEmpty) return;

    final picked = result.files.single.path;
    if (picked == null || picked.isEmpty) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'No valid image path was returned.';
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _imagePath = picked;
      _result = null;
    });
  }

  Future<void> _extract() async {
    if (_isExtracting) return;

    final imagePath = _imagePath;
    if (imagePath == null) {
      setState(() => _errorMessage = 'Please select an image first.');
      return;
    }

    setState(() {
      _isExtracting = true;
      _errorMessage = null;
      _result = null;
    });

    try {
      final result = await _service.extractText(
        imagePath: imagePath,
        language: ScannerLanguage.latin,
      );

      if (!mounted) return;
      setState(() {
        _isExtracting = false;
        _result = result;
      });
    } on ScannerOcrException catch (e) {
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
    if (result == null || result.text.trim().isEmpty) return;

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
    if (result == null || result.text.trim().isEmpty) return;

    try {
      await Share.share(
        result.text,
        subject: 'Image text',
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