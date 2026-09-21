import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/ocr_result.dart';
import '../models/scanner_document.dart';
import '../models/scanner_document_category.dart';
import '../models/scanner_page.dart';
import '../providers/scanner_documents_provider.dart';
import '../providers/scanner_ocr_provider.dart';
import '../providers/scanner_settings_provider.dart';
import '../repositories/local_scanner_repository.dart';
import '../widgets/shared/scanner_empty_view.dart';
import '../widgets/shared/scanner_error_view.dart';
import '../widgets/shared/scanner_loading_overlay.dart';
import '../widgets/viewer/scanner_viewer_header.dart';
import '../widgets/viewer/scanner_viewer_page_card.dart';
import 'scanner_image_viewer_screen.dart';
import 'scanner_ocr_result_screen.dart';
import 'scanner_pdf_viewer_screen.dart';

/// Scanner 360 Document Viewer.
///
/// Loads a saved document by id and displays its metadata and
/// pages. Tapping a page opens the image viewer. When a PDF was
/// generated, the More menu offers a PDF viewer. The More menu
/// also offers Run OCR / View OCR based on the document's OCR
/// state, and wires Rename and Delete through the documents
/// provider.
class ScannerDocumentViewerScreen extends ConsumerStatefulWidget {
  const ScannerDocumentViewerScreen({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  ConsumerState<ScannerDocumentViewerScreen> createState() =>
      _ScannerDocumentViewerScreenState();
}

class _ScannerDocumentViewerScreenState
    extends ConsumerState<ScannerDocumentViewerScreen> {
  final LocalScannerRepository _repository = LocalScannerRepository();

  ScannerDocument? _document;
  bool _isLoading = true;
  bool _isOcrRunning = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadDocument();
    });
  }

  Future<void> _loadDocument() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final document = await _repository.getDocument(widget.documentId);
      if (!mounted) return;
      setState(() {
        _document = document;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _document == null
            ? const Text('Document')
            : ScannerViewerHeader(
                title: _document!.metadata.name,
                isFavorite: _document!.metadata.isFavorite,
                onBack: _handleBack,
                onToggleFavorite: _handleToggleFavorite,
                onOpenMore: _handleOpenMore,
              ),
      ),
      body: Stack(
        children: [
          _buildBody(),
          if (_isLoading)
            const ScannerLoadingOverlay(label: 'Loading documentâ€¦'),
          if (_isOcrRunning)
            const ScannerLoadingOverlay(label: 'Running OCRâ€¦'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return ScannerErrorView(
        title: 'Unable to load document',
        message: _errorMessage!,
        onRetry: _loadDocument,
        retryLabel: 'Retry',
      );
    }

    if (!_isLoading && _document == null) {
      return ScannerEmptyView(
        icon: Icons.description_outlined,
        title: 'Document not found',
        subtitle:
            'This document may have been deleted or moved.',
        actionLabel: 'Back',
        onAction: _handleBack,
      );
    }

    final document = _document;
    if (document == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MetadataBlock(document: document),
          const SizedBox(height: AppSpacing.lg),
          if (document.pages.isEmpty)
            const ScannerEmptyView(
              icon: Icons.image_not_supported_outlined,
              title: 'No pages',
              subtitle: 'This document has no saved pages.',
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: document.pages.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final page = document.pages[index];
                return ScannerViewerPageCard(
                  page: page,
                  pageNumber: index + 1,
                  onTap: () => _handlePageTap(index),
                );
              },
            ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  void _handleBack() {
    Navigator.of(context).pop();
  }

  Future<void> _handleToggleFavorite() async {
    final document = _document;
    if (document == null) return;

    final newValue = !document.metadata.isFavorite;

    try {
      await ref
          .read(scannerDocumentsProvider.notifier)
          .setFavorite(document.id, newValue);

      if (!mounted) return;
      await _loadDocument();
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to update favourite: $e');
    }
  }

  void _handleOpenMore() {
    final document = _document;
    if (document == null) return;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (document.pdfDocument != null)
              ListTile(
                leading: const Icon(Icons.picture_as_pdf_outlined),
                title: const Text('View PDF'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ScannerPdfViewerScreen(
                        pdfDocument: document.pdfDocument!,
                        documentName: document.metadata.name,
                      ),
                    ),
                  );
                },
              ),
            if (document.ocrResult == null)
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Run OCR'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _handleRunOcr();
                },
              ),
            if (document.ocrResult != null)
              ListTile(
                leading: const Icon(Icons.text_snippet_outlined),
                title: const Text('View OCR'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ScannerOcrResultScreen(
                        initialResult: document.ocrResult!,
                      ),
                    ),
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.drive_file_rename_outline),
              title: const Text('Rename'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _handleRename();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: AppColors.error,
              ),
              title: const Text('Delete'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _handleDelete();
              },
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Rename
  // ------------------------------------------------------------

  Future<void> _handleRename() async {
    final document = _document;
    if (document == null) return;

    final controller =
        TextEditingController(text: document.metadata.name);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Rename document'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Document name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isEmpty) return;
              Navigator.of(dialogContext).pop(trimmed);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final trimmed = controller.text.trim();
                if (trimmed.isEmpty) return;
                Navigator.of(dialogContext).pop(trimmed);
              },
              child: const Text('Rename'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result == null) return;
    if (result.isEmpty) return;

    try {
      await ref
          .read(scannerDocumentsProvider.notifier)
          .renameDocument(document.id, result);

      if (!mounted) return;
      await _loadDocument();
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to rename: $e');
    }
  }

  // ------------------------------------------------------------
  // Delete
  // ------------------------------------------------------------

  Future<void> _handleDelete() async {
    final document = _document;
    if (document == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete document'),
          content: Text(
            'Delete "${document.metadata.name}"? '
            'This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.textLight,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await ref
          .read(scannerDocumentsProvider.notifier)
          .deleteDocument(document.id);

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to delete: $e');
    }
  }

  // ------------------------------------------------------------
  // OCR
  // ------------------------------------------------------------

  Future<void> _handleRunOcr() async {
    final document = _document;
    if (document == null) return;
    if (document.pages.isEmpty) {
      _showSnackBar('This document has no pages to process.');
      return;
    }

    setState(() => _isOcrRunning = true);

    try {
      final settings = ref.read(scannerSettingsProvider);
      final language = settings.ocrLanguage;

      final updatedPages = <ScannerPage>[];
      final combinedBlocks = <dynamic>[];

      for (final page in document.pages) {
        final result = await ref
            .read(scannerOcrProvider.notifier)
            .runOcrOnPage(page: page, language: language);

        if (result == null) {
          throw Exception(
            'OCR failed on page "${page.id}".',
          );
        }

        updatedPages.add(page.copyWith(ocrResult: result));
        combinedBlocks.addAll(result.blocks);
      }

      final combinedText = updatedPages
          .map((p) => p.ocrResult?.text ?? '')
          .where((t) => t.isNotEmpty)
          .join('\n\n');

      final combined = OcrResult(
        text: combinedText,
        blocks: combinedBlocks.cast(),
        language: language,
        createdAt: DateTime.now(),
      );

      final updatedDocument = document.copyWith(
        pages: updatedPages,
        ocrResult: combined,
      );

      await _repository.saveDocument(updatedDocument);

      if (!mounted) return;
      await _loadDocument();
      if (!mounted) return;
      _showSnackBar('OCR complete');
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('OCR failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isOcrRunning = false);
      }
    }
  }

  void _handlePageTap(int index) {
    final document = _document;
    if (document == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScannerImageViewerScreen(
          pages: document.pages,
          initialIndex: index,
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// ============================================================
// Metadata block
// ============================================================

class _MetadataBlock extends StatelessWidget {
  const _MetadataBlock({required this.document});

  final ScannerDocument document;

  @override
  Widget build(BuildContext context) {
    final meta = document.metadata;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meta.name,
            style: AppTextStyles.headline,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _Chip(label: _categoryLabel(meta.category)),
              _Chip(
                label: meta.pageCount == 1
                    ? '1 page'
                    : '${meta.pageCount} pages',
              ),
              _Chip(label: _formatDate(meta.updatedAt)),
            ],
          ),
          if (meta.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: meta.tags
                  .map((tag) => _Chip(label: tag))
                  .toList(growable: false),
            ),
          ],
        ],
      ),
    );
  }

  static String _categoryLabel(ScannerDocumentCategory category) {
    switch (category) {
      case ScannerDocumentCategory.courtDocument:
        return 'Court Document';
      case ScannerDocumentCategory.legalNotice:
        return 'Legal Notice';
      case ScannerDocumentCategory.contract:
        return 'Contract';
      case ScannerDocumentCategory.cnicOrDocumentScan:
        return 'CNIC / Document Scan';
      case ScannerDocumentCategory.propertyDocument:
        return 'Property Document';
      case ScannerDocumentCategory.agreement:
        return 'Agreement';
      case ScannerDocumentCategory.application:
        return 'Application';
      case ScannerDocumentCategory.affidavit:
        return 'Affidavit';
      case ScannerDocumentCategory.judgment:
        return 'Judgment';
      case ScannerDocumentCategory.evidenceDocument:
        return 'Evidence';
      case ScannerDocumentCategory.caseFile:
        return 'Case File';
      case ScannerDocumentCategory.legalCorrespondence:
        return 'Legal Correspondence';
      case ScannerDocumentCategory.other:
        return 'Other';
    }
  }

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.lightTextPrimary,
        ),
      ),
    );
  }
}