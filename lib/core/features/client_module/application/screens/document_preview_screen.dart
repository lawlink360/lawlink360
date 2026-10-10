import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/services/pdf_service.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_template.dart';
import '../providers/application_recent_documents_provider.dart';
import 'document_editor_screen.dart';

class DocumentPreviewScreen extends ConsumerStatefulWidget {
  final DocumentTemplate template;

  const DocumentPreviewScreen({
    super.key,
    required this.template,
  });

  @override
  ConsumerState<DocumentPreviewScreen> createState() =>
      _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState
    extends ConsumerState<DocumentPreviewScreen> {
  late String documentBody;

  @override
  void initState() {
    super.initState();
    documentBody = widget.template.body;

    // Record the template visit once, when this screen initializes.
    // Deferred to the next microtask because Riverpod forbids
    // modifying a provider during the widget-tree build phase
    // (initState runs as part of that phase). Rebuilds do not
    // re-trigger this, so a single screen open yields one visit.
    Future(() {
      if (!mounted) return;
      ref.read(recentDocumentsProvider.notifier).recordVisit(
            widget.template.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Document Preview',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: colorScheme.outlineVariant
                        .withValues(alpha: 0.55),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: colorScheme.primary
                                .withValues(alpha: 0.08),
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            widget.template.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.headline.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(
                      color: colorScheme.outlineVariant
                          .withValues(alpha: 0.55),
                      height: 1,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      documentBody,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant
                        .withValues(alpha: 0.55),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final editedDocument =
                            await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DocumentEditorScreen(
                              template: widget.template,
                            ),
                          ),
                        );

                        if (editedDocument != null) {
                          setState(() {
                            documentBody = editedDocument;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 18,
                      ),
                      label: const Text('Edit Manually'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        side: BorderSide(
                          color: colorScheme.primary,
                        ),
                        minimumSize: const Size(
                          0,
                          AppSpacing.buttonHeight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppRadius.md,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await PdfService.previewPdf(
                          title: widget.template.title,
                          body: documentBody,
                          rtl: false,
                        );
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf_outlined,
                        size: 18,
                      ),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
                        minimumSize: const Size(
                          0,
                          AppSpacing.buttonHeight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppRadius.md,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}