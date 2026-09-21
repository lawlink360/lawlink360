import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../services/scanner_printing_service.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Document Tools → Print.
///
/// Phase 10D.6.2. Standalone document-tool operation. Accepts an
/// arbitrary PDF and sends it to the OS print dialog via
/// [ScannerPrintingService].
///
/// Not connected to the scanner capture pipeline. Does not create
/// ScannerDocuments or ScannerPages, and does not touch scanner
/// storage, sessions, or repositories.
class ScannerDocumentPrintScreen extends ConsumerStatefulWidget {
  const ScannerDocumentPrintScreen({super.key});

  @override
  ConsumerState<ScannerDocumentPrintScreen> createState() =>
      _ScannerDocumentPrintScreenState();
}

class _ScannerDocumentPrintScreenState
    extends ConsumerState<ScannerDocumentPrintScreen> {
  final ScannerPrintingService _printingService =
      const ScannerPrintingService();
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  String? _pdfPath;
  bool _isPrinting = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Print'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_pdfPath == null) _buildEmptyState(),
                  if (_pdfPath != null) _buildSelectedState(),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      _errorMessage!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (_isPrinting)
              const ScannerLoadingOverlay(
                label: 'Opening print dialog…',
              ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Empty state
  // ------------------------------------------------------------

  Widget _buildEmptyState() {
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
          Row(
            children: [
              Container(
                width: AppSpacing.xxl,
                height: AppSpacing.xxl,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.print_outlined,
                  color: AppColors.accent,
                  size: AppSpacing.iconMd,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Print Document',
                      style: AppTextStyles.title,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Select a PDF and send it to your device\'s '
                      'printer.',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _isPrinting ? null : _pickPdf,
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
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Selected state
  // ------------------------------------------------------------

  Widget _buildSelectedState() {
    final fileName = _pdfPath!.split(Platform.pathSeparator).last;

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
                'PDF file',
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(
                    Icons.picture_as_pdf_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      fileName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: OutlinedButton.icon(
                  onPressed: _isPrinting ? null : _pickPdf,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Change PDF'),
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
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: _isPrinting ? null : _print,
            icon: const Icon(Icons.print_outlined),
            label: const Text('Print Document'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ),
      ],
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
    });
  }

  Future<void> _print() async {
    if (_isPrinting) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }

    setState(() {
      _isPrinting = true;
      _errorMessage = null;
    });

    try {
      final completed = await _printingService.printPdfFile(pdfPath);

      if (!mounted) return;
      setState(() {
        _isPrinting = false;
      });

      if (!completed) {
        _showSnackBar('Print job was cancelled.');
      }
    } on ScannerPrintingException catch (e) {
      if (!mounted) return;
      setState(() {
        _isPrinting = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isPrinting = false;
        _errorMessage = 'Failed to print: $e';
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}