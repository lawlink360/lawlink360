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

/// Document Tools → Annotate.
///
/// Phase 10D.6.4. Standalone document-tool operation. Accepts an
/// arbitrary PDF, embeds the public `SfPdfViewer` for viewing and
/// annotation, and saves the modified PDF to a temporary file for
/// sharing.
///
/// Not connected to the scanner capture pipeline. Does not create
/// ScannerDocuments or ScannerPages, and does not touch scanner
/// storage, sessions, or repositories.
///
/// Supported annotation modes are the ones publicly exposed by the
/// installed `syncfusion_flutter_pdfviewer 33.2.13`:
///   - None
///   - Highlight
///   - Underline
///   - Strikethrough
///   - Squiggly
///   - Sticky Note
class ScannerDocumentAnnotateScreen extends ConsumerStatefulWidget {
  const ScannerDocumentAnnotateScreen({super.key});

  @override
  ConsumerState<ScannerDocumentAnnotateScreen> createState() =>
      _ScannerDocumentAnnotateScreenState();
}

class _ScannerDocumentAnnotateScreenState
    extends ConsumerState<ScannerDocumentAnnotateScreen> {
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();
  final PdfViewerController _pdfController = PdfViewerController();

  String? _pdfPath;
  PdfAnnotationMode _annotationMode = PdfAnnotationMode.none;

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
        title: const Text('Annotate'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _pdfPath == null ? _buildEmptyState() : _buildViewer(),
            if (_isSaving || _isSharing)
              ScannerLoadingOverlay(
                label: _isSaving
                    ? 'Saving annotations…'
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
                        Icons.draw_outlined,
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
                            'Annotate PDF',
                            style: AppTextStyles.title,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Select a PDF to add supported '
                            'annotations.',
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
          ),
        ),
        _buildAnnotationToolbar(),
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
  // Annotation toolbar
  // ------------------------------------------------------------

  Widget _buildAnnotationToolbar() {
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildModeChip(
              label: 'None',
              icon: Icons.pan_tool_outlined,
              mode: PdfAnnotationMode.none,
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildModeChip(
              label: 'Highlight',
              icon: Icons.brush_outlined,
              mode: PdfAnnotationMode.highlight,
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildModeChip(
              label: 'Underline',
              icon: Icons.format_underline,
              mode: PdfAnnotationMode.underline,
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildModeChip(
              label: 'Strikethrough',
              icon: Icons.format_strikethrough,
              mode: PdfAnnotationMode.strikethrough,
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildModeChip(
              label: 'Squiggly',
              icon: Icons.gesture,
              mode: PdfAnnotationMode.squiggly,
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildModeChip(
              label: 'Sticky Note',
              icon: Icons.sticky_note_2_outlined,
              mode: PdfAnnotationMode.stickyNote,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeChip({
    required String label,
    required IconData icon,
    required PdfAnnotationMode mode,
  }) {
    final isSelected = _annotationMode == mode;
    return GestureDetector(
      onTap: () => _handleModeSelected(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.lightBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSpacing.iconSm,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.lightTextPrimary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.lightTextPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
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
                    label: const Text('Save'),
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

  void _handleModeSelected(PdfAnnotationMode mode) {
    setState(() {
      _annotationMode = mode;
    });
    _pdfController.annotationMode = mode;
  }

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
      _annotationMode = PdfAnnotationMode.none;
    });
  }

  Future<void> _save() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final Uint8List bytes = Uint8List.fromList(
        await _pdfController.saveDocument(),
      );

      final outputPath = await _newOutputPath();

      try {
        await File(outputPath).writeAsBytes(bytes, flush: true);
      } catch (e) {
        throw Exception('Failed to write annotated PDF: $e');
      }

      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _savedPdfPath = outputPath;
        _annotationMode = PdfAnnotationMode.none;
      });
      _pdfController.annotationMode = PdfAnnotationMode.none;
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = 'Failed to save annotations: $e';
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
        subject: 'Annotated PDF',
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
      'scanner_360_annotate_$stamp',
    );
    await dir.create(recursive: true);
    return '${dir.path}${Platform.pathSeparator}annotated_$stamp.pdf';
  }
}