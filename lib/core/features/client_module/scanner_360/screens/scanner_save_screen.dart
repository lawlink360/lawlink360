import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/scanner_document_category.dart';
import '../models/scanner_export_format.dart';
import '../providers/scanner_documents_provider.dart';
import '../providers/scanner_pages_provider.dart';
import '../providers/scanner_pdf_provider.dart';
import '../providers/scanner_session_provider.dart';
import '../providers/scanner_settings_provider.dart';
import '../utils/scanner_naming_utils.dart';
import '../widgets/save/scanner_save_format_selector.dart';
import '../widgets/save/scanner_save_metadata_form.dart';
import '../widgets/save/scanner_save_name_field.dart';
import '../widgets/save/scanner_save_summary_card.dart';
import '../widgets/shared/scanner_loading_overlay.dart';

/// Save screen for Scanner 360.
class ScannerSaveScreen extends ConsumerStatefulWidget {
  const ScannerSaveScreen({super.key});

  @override
  ConsumerState<ScannerSaveScreen> createState() =>
      _ScannerSaveScreenState();
}

class _ScannerSaveScreenState
    extends ConsumerState<ScannerSaveScreen> {
  late final TextEditingController _nameController;
  ScannerDocumentCategory _category = ScannerDocumentCategory.other;
  List<String> _tags = const [];
  ScannerExportFormat _format = ScannerExportFormat.pdf;

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: ScannerNamingUtils.defaultNameFor(_category),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final settings = ref.read(scannerSettingsProvider);
      setState(() {
        _format = settings.saveFormat;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount =
        ref.watch(scannerPagesProvider).pages.length;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Save Document'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScannerSaveNameField(
                  controller: _nameController,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.lg),
                ScannerSaveMetadataForm(
                  initialCategory: _category,
                  initialTags: _tags,
                  onCategoryChanged: (c) =>
                      setState(() => _category = c),
                  onTagsChanged: (t) => setState(() => _tags = t),
                ),
                const SizedBox(height: AppSpacing.lg),
                ScannerSaveFormatSelector(
                  value: _format,
                  onChanged: (f) => setState(() => _format = f),
                ),
                const SizedBox(height: AppSpacing.lg),
                ScannerSaveSummaryCard(
                  pageCount: pageCount,
                  category: _category,
                  format: _format,
                  name: _nameController.text.trim(),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    _errorMessage!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _handleSave,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
          if (_isSaving)
            const ScannerLoadingOverlay(label: 'Saving documentâ€¦'),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Save
  // ------------------------------------------------------------

  Future<void> _handleSave() async {
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final pages = ref.read(scannerPagesProvider).pages;
      if (pages.isEmpty) {
        setState(() {
          _isSaving = false;
          _errorMessage = 'There are no pages to save.';
        });
        return;
      }

      final session = ref.read(scannerSessionProvider);
      if (session == null) {
        setState(() {
          _isSaving = false;
          _errorMessage = 'Session is no longer active.';
        });
        return;
      }

      final sessionWithPages = session.copyWith(pages: pages);

      final documentId =
          'doc_${DateTime.now().microsecondsSinceEpoch}';

      final document =
          await ref.read(scannerPdfProvider.notifier).exportDocument(
                documentId: documentId,
                session: sessionWithPages,
                format: _format,
                category: _category,
                tags: _tags,
                nameOverride: _nameController.text.trim(),
              );

      if (document == null) {
        setState(() {
          _isSaving = false;
          _errorMessage = 'Failed to create the document.';
        });
        return;
      }

      ref.read(scannerSessionProvider.notifier).markSaved();
      await ref
          .read(scannerPagesProvider.notifier)
          .clearPages(sessionId: session.id);
      ref.read(scannerSessionProvider.notifier).clearSession();
      await ref.read(scannerDocumentsProvider.notifier).refresh();

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = e.toString();
      });
    }
  }
}