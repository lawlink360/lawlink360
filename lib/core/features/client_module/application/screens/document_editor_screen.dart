import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_template.dart';

class DocumentEditorScreen extends StatefulWidget {
  final DocumentTemplate template;

  const DocumentEditorScreen({
    super.key,
    required this.template,
  });

  @override
  State<DocumentEditorScreen> createState() => _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.template.body,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          'Edit Document',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Save',
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              Navigator.pop(
                context,
                controller.text,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            expands: true,
            maxLines: null,
            minLines: null,
            textAlignVertical: TextAlignVertical.top,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              height: 1.6,
            ),
            decoration: InputDecoration(
              hintText: 'Edit your document here...',
              hintStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(
                AppSpacing.md,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
