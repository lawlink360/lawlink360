import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document_category.dart';
import '../../models/scanner_export_format.dart';

/// Read-only summary of the pending save.
class ScannerSaveSummaryCard extends StatelessWidget {
  const ScannerSaveSummaryCard({
    super.key,
    required this.pageCount,
    required this.category,
    required this.format,
    required this.name,
  });

  final int pageCount;
  final ScannerDocumentCategory category;
  final ScannerExportFormat format;
  final String name;

  @override
  Widget build(BuildContext context) {
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
          _row('Name', name.isEmpty ? 'Untitled' : name),
          const SizedBox(height: AppSpacing.sm),
          _row('Category', _categoryLabel(category)),
          const SizedBox(height: AppSpacing.sm),
          _row(
            'Pages',
            pageCount == 1 ? '1 page' : '$pageCount pages',
          ),
          const SizedBox(height: AppSpacing.sm),
          _row('Format', _formatLabel(format)),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }

  static String _categoryLabel(ScannerDocumentCategory c) {
    switch (c) {
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

  static String _formatLabel(ScannerExportFormat f) {
    switch (f) {
      case ScannerExportFormat.pdf:
        return 'PDF';
      case ScannerExportFormat.image:
        return 'Image';
      case ScannerExportFormat.both:
        return 'PDF + Image';
      case ScannerExportFormat.searchablePdf:
        return 'Searchable PDF';
    }
  }
}