import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document.dart';
import '../../models/scanner_document_category.dart';

/// Presentation-only library card for a single document.
///
/// Designed to be placed inside a bounded GridView cell. It uses
/// intrinsic sizing from its parent cell and does not request
/// infinite width.
class ScannerLibraryCard extends StatelessWidget {
  const ScannerLibraryCard({
    super.key,
    required this.document,
    required this.onTap,
  });

  final ScannerDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = document.metadata;

    return Material(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      _documentIcon(document),
                      color: AppColors.accent,
                      size: AppSpacing.iconSm,
                    ),
                  ),
                  const Spacer(),
                  if (meta.isFavorite)
                    const Icon(
                      Icons.star,
                      color: AppColors.accent,
                      size: AppSpacing.iconSm,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    meta.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _categoryLabel(meta.category),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDate(meta.updatedAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption,
                    ),
                  ),
                  Text(
                    '${meta.pageCount} p.',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _documentIcon(ScannerDocument document) {
    if (document.pdfDocument != null) {
      return Icons.picture_as_pdf_outlined;
    }
    return Icons.description_outlined;
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