import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Document Tools → Fill.
///
/// Phase 10D.6.6. Standalone document-tool operation. Accepts an
/// arbitrary PDF, embeds the public `SfPdfViewer` so the user can
/// fill any interactive AcroForm fields the document already
/// contains, then saves the filled PDF to a temporary file for
/// sharing.
///
/// The Viewer provides the native form-field interaction. This
/// screen does not detect, enumerate, render, or fabricate form
/// fields itself — it only hosts the Viewer, saves, and shares.
///
/// Not connected to the scanner capture pipeline. Does not create
/// ScannerDocuments or ScannerPages, and does not touch scanner
/// storage, sessions, or repositories.
///
/// Flattening: this MVP saves with `PdfFlattenOption.none` so the
/// output PDF preserves its interactive form fields. Flattening is
/// intentionally not exposed in this batch.
class ScannerDocumentFillScreen extends ConsumerStatefulWidget {
  const ScannerDocumentFillScreen({super.key});

  @override
  ConsumerState<ScannerDocumentFillScreen> createState() =>
      _ScannerDocumentFillScreenState();
}

class _ScannerDocumentFillScreenState
    extends ConsumerState<ScannerDocumentFillScreen> {
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();
  final PdfViewerController _pdfController = PdfViewerController();

  String? _pdfPath;
  bool _isSaving = false;
  bool _isSharing = false;
  String? _errorMessage;
  String? _savedPdfPath;

  @override
  void dispose() {
    _pdfController.dispose();
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
        title: const Text('Fill'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _pdfPath == null ? _buildEmptyState() : _buildViewer(),
            if (_isSaving || _isSharing)
              ScannerLoadingOverlay(
                label: _isSaving
                    ? 'Saving filled PDF…'
                    : 'Opening share sheet…',
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
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
                        Icons.edit_note,
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
                            'Fill PDF',
                            style: AppTextStyles.title,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Select a PDF with form fields and fill '
                            'them in directly.',
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
                    onPressed: _isSaving ? null : _pickPdf,
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
          ),
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
    );
  }

  // ------------------------------------------------------------
  // Viewer
  // ------------------------------------------------------------

  Widget _buildViewer() {
    return Column(
      children: [
        Expanded(
          child: SfPdfViewer.file(
            File(_pdfPath!),
            controller: _pdfController,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            enableDoubleTapZooming: true,
            onDocumentLoadFailed: _handleDocumentLoadFailed,
          ),
        ),
        _buildBottomActions(),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              _errorMessage!,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Bottom actions
  // ------------------------------------------------------------

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,
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
              onPressed: (_isSaving || _isSharing) ? null : _pickPdf,
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
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _savedPdfPath == null
                ? ElevatedButton.icon(
                    onPressed:
                        (_isSaving || _isSharing) ? null : _save,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save Filled PDF'),
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
                  )
                : ElevatedButton.icon(
                    onPressed:
                        (_isSaving || _isSharing) ? null : _share,
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share PDF'),
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
      _savedPdfPath = null;
    });
  }

  void _handleDocumentLoadFailed(PdfDocumentLoadFailedDetails details) {
    if (!mounted) return;
    setState(() {
      _errorMessage = _describeLoadFailure(details);
    });
  }

  String _describeLoadFailure(PdfDocumentLoadFailedDetails details) {
    final message = details.description.toLowerCase();
    if (message.contains('password') || message.contains('encrypt')) {
      return 'This PDF is password protected and could not be opened.';
    }
    return 'Unable to open this PDF. It may be damaged or unsupported.';
  }

  Future<void> _save() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final Uint8List bytes = Uint8List.fromList(
        await _pdfController.saveDocument(
          flattenOption: PdfFlattenOption.none,
        ),
      );

      final outputPath = await _newOutputPath();

      try {
        await File(outputPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        throw Exception('Failed to write filled PDF: $e');
      }

      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _savedPdfPath = outputPath;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = 'Failed to save filled PDF: $e';
      });
    }
  }

  Future<void> _share() async {
    if (_isSharing) return;

    final path = _savedPdfPath;
    if (path == null) return;

    setState(() {
      _isSharing = true;
      _errorMessage = null;
    });

    try {
      await Share.shareXFiles(
        [XFile(path)],
        subject: 'Filled PDF',
      );

      if (!mounted) return;
      setState(() {
        _isSharing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSharing = false;
        _errorMessage = 'Failed to share: $e';
      });
    }
  }

  Future<String> _newOutputPath() async {
    final tempDir = Directory.systemTemp;
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final dir = Directory(
      '${tempDir.path}${Platform.pathSeparator}'
      'scanner_360_fill_$stamp',
    );
    await dir.create(recursive: true);
    return '${dir.path}${Platform.pathSeparator}filled_$stamp.pdf';
  }
}