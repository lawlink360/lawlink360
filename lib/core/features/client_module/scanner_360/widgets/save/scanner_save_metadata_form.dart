import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document_category.dart';

/// Category selector and tag editor.
class ScannerSaveMetadataForm extends StatefulWidget {
  const ScannerSaveMetadataForm({
    super.key,
    required this.initialCategory,
    required this.initialTags,
    required this.onCategoryChanged,
    required this.onTagsChanged,
  });

  final ScannerDocumentCategory initialCategory;
  final List<String> initialTags;
  final ValueChanged<ScannerDocumentCategory> onCategoryChanged;
  final ValueChanged<List<String>> onTagsChanged;

  @override
  State<ScannerSaveMetadataForm> createState() =>
      _ScannerSaveMetadataFormState();
}

class _ScannerSaveMetadataFormState
    extends State<ScannerSaveMetadataForm> {
  late ScannerDocumentCategory _category;
  late List<String> _tags;
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
    _tags = List<String>.from(widget.initialTags);
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    final text = _tagController.text.trim();
    if (text.isEmpty) return;
    if (_tags.contains(text)) {
      _tagController.clear();
      return;
    }
    setState(() {
      _tags = [..._tags, text];
    });
    _tagController.clear();
    widget.onTagsChanged(_tags);
  }

  void _removeTag(String tag) {
    setState(() {
      _tags = _tags.where((t) => t != tag).toList(growable: false);
    });
    widget.onTagsChanged(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: DropdownButton<ScannerDocumentCategory>(
            value: _category,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            borderRadius: BorderRadius.circular(AppRadius.md),
            items: ScannerDocumentCategory.values
                .map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(_labelFor(c)),
                  ),
                )
                .toList(growable: false),
            onChanged: (v) {
              if (v == null) return;
              setState(() => _category = v);
              widget.onCategoryChanged(v);
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Tags (optional)',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addTag(),
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  hintText: 'Add a tag',
                  filled: true,
                  fillColor: AppColors.lightSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: _addTag,
              icon: const Icon(Icons.add_circle_outline),
              color: AppColors.primary,
              tooltip: 'Add tag',
            ),
          ],
        ),
        if (_tags.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _tags
                .map(
                  (tag) => Chip(
                    label: Text(tag),
                    backgroundColor: AppColors.lightSurface,
                    side: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => _removeTag(tag),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ],
    );
  }

  static String _labelFor(ScannerDocumentCategory c) {
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
}