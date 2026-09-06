
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../../models/document_template.dart';
import '../../screens/document_preview_screen.dart';

import 'application_template_card.dart';

class ApplicationTemplateGrid extends StatelessWidget {
  final List<DocumentTemplate> templates;

  const ApplicationTemplateGrid({
    super.key,
    required this.templates,
  });

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.lightBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: AppColors.textSecondary,
                  size: 30,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No templates available',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: AppSpacing.xs,
        bottom: AppSpacing.xxl,
      ),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];

        return ApplicationTemplateCard(
          template: template,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DocumentPreviewScreen(
                  template: template,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
