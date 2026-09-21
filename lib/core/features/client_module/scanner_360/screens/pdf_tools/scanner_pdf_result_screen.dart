import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/services/share_service.dart';
import '../../models/document_metadata.dart';
import '../../models/pdf_document.dart';
import '../../models/scanner_document.dart';
import '../../models/scanner_document_category.dart';
import '../../models/scanner_export_format.dart';
import '../../providers/scanner_documents_provider.dart';
import '../../repositories/local_scanner_repository.dart';
import '../../services/scanner_printing_service.dart';

/// Screen shown after a PDF tool completes successfully.
class ScannerPdfResultScreen extends ConsumerStatefulWidget {
  const ScannerPdfResultScreen({
    super.key,
    required this.outputPaths,
    required this.toolTitle,
  });

  final List<String> outputPaths;
  final String toolTitle;

  @override
  ConsumerState<ScannerPdfResultScreen> createState() =>
      _ScannerPdfResultScreenState();
}

class _ScannerPdfResultScreenState
    extends ConsumerState<ScannerPdfResultScreen> {
  final ShareService _shareService = const ShareService();
  final ScannerPrintingService _printingService =
      const ScannerPrintingService();
  final LocalScannerRepository _repository = LocalScannerRepository();

  bool _isBusy = false;
  bool _savedToLibrary = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Result'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.toolTitle} complete',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: AppSpacing.md),
              ...widget.outputPaths.map(
                (path) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    path,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _ResultAction(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: _isBusy ? null : _handleShare,
              ),
              _ResultAction(
                icon: Icons.print_outlined,
                label: 'Print',
                onTap: _isBusy ? null : _handlePrint,
              ),
              _ResultAction(
                icon: Icons.library_add_outlined,
                label: _savedToLibrary
                    ? 'Saved to Scanner Library'
                    : 'Save to Scanner Library',
                onTap: (_isBusy || _savedToLibrary)
                    ? null
                    : _handleSaveToLibrary,
              ),
              _ResultAction(
                icon: Icons.check_circle_outline,
                label: 'Done',
                onTap: _isBusy
                    ? null
                    : () => Navigator.of(context).pop(),
              ),
              if (_isBusy) ...[
                const SizedBox(height: AppSpacing.lg),
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleShare() async {
    if (widget.outputPaths.isEmpty) return;
    _setBusy(true);
    try {
      await _shareService.shareFile(widget.outputPaths.first);
    } catch (e) {
      _showSnackBar('Share failed: $e');
    } finally {
      _setBusy(false);
    }
  }

  Future<void> _handlePrint() async {
    if (widget.outputPaths.isEmpty) return;
    _setBusy(true);
    try {
      await _printingService.printPdfFile(widget.outputPaths.first);
    } catch (e) {
      _showSnackBar('Print failed: $e');
    } finally {
      _setBusy(false);
    }
  }

  Future<void> _handleSaveToLibrary() async {
    if (widget.outputPaths.isEmpty) return;
    _setBusy(true);
    try {
      final path = widget.outputPaths.first;
      final file = File(path);
      final size = await file.length();
      final now = DateTime.now();
      final documentId =
          'doc_${now.microsecondsSinceEpoch}';

      final pdfDoc = PdfDocument(
        id: documentId,
        filePath: path,
        pageCount: 0,
        sizeInBytes: size,
        createdAt: now,
        isSearchable: false,
      );

      final metadata = DocumentMetadata(
        id: documentId,
        name: '${widget.toolTitle} - ${now.year}-${now.month}-${now.day}',
        category: ScannerDocumentCategory.other,
        createdAt: now,
        updatedAt: now,
        pageCount: 0,
      );

      final document = ScannerDocument(
        id: documentId,
        metadata: metadata,
        pages: const [],
        exportFormat: ScannerExportFormat.pdf,
        pdfDocument: pdfDoc,
      );

      await _repository.saveDocument(document);
      await ref.read(scannerDocumentsProvider.notifier).refresh();

      if (!mounted) return;
      setState(() => _savedToLibrary = true);
      _showSnackBar('Saved to Scanner Library');
    } catch (e) {
      _showSnackBar('Save failed: $e');
    } finally {
      _setBusy(false);
    }
  }

  void _setBusy(bool value) {
    if (!mounted) return;
    setState(() => _isBusy = value);
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ResultAction extends StatelessWidget {
  const _ResultAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.lightBorder),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primary,
                  size: AppSpacing.iconMd,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.body,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.lightTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}