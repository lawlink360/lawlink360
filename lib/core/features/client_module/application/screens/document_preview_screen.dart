import 'package:flutter/material.dart';

import 'package:lawlink360/core/services/pdf_service.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_template.dart';
import 'document_editor_screen.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final DocumentTemplate template;

  const DocumentPreviewScreen({
    super.key,
    required this.template,
  });

  @override
  State<DocumentPreviewScreen> createState() => _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late String documentBody;

  @override
  void initState() {
    super.initState();
    documentBody = widget.template.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          'Document Preview',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
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
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
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
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: AppColors.primary,
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
                              color: AppColors.textPrimary,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(
                      color: AppColors.divider,
                      height: 1,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      documentBody,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
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
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(
                    color: AppColors.border,
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
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
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
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.surface,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppRadius.xl),
                            ),
                          ),
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  AppSpacing.lg,
                                  AppSpacing.md,
                                  AppSpacing.lg,
                                  AppSpacing.lg,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: AppColors.border,
                                        borderRadius:
                                            BorderRadius.circular(
                                          AppRadius.pill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.lg),
                                    Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary
                                                .withValues(alpha: 0.08),
                                            borderRadius:
                                                BorderRadius.circular(
                                              AppRadius.md,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.download_outlined,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.md,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Download Document',
                                            style: AppTextStyles.title
                                                .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        width: 42,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          color: AppColors.error
                                              .withValues(alpha: 0.08),
                                          borderRadius:
                                              BorderRadius.circular(
                                            AppRadius.sm,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.picture_as_pdf_outlined,
                                          color: AppColors.error,
                                        ),
                                      ),
                                      title: Text(
                                        'Download as PDF',
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Prepare the document as a PDF',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        width: 42,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          color: AppColors.info
                                              .withValues(alpha: 0.08),
                                          borderRadius:
                                              BorderRadius.circular(
                                            AppRadius.sm,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.description_outlined,
                                          color: AppColors.info,
                                        ),
                                      ),
                                      title: Text(
                                        'Download as DOCX',
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Prepare the document file',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);

                                        await PdfService.previewPdf(
                                          title: widget.template.title,
                                          body: documentBody,
                                          rtl: false,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        size: 18,
                      ),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textLight,
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
