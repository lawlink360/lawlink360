import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

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
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.outlineVariant
                        .withValues(alpha: 0.55),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                  size: 30,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'No templates available',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                'Templates for this subcategory will appear here once available.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.62),
                  height: 1.4,
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