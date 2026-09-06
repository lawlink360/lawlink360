import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatDocumentMessage extends StatelessWidget {
  const ChatDocumentMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: colorScheme.secondary,
            child: Icon(
              Icons.person_rounded,
              color: colorScheme.onSecondary,
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.18
                          : 0.06,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "I've reviewed your document.",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                          ),
                          child: const Icon(
                            Icons.picture_as_pdf_rounded,
                            color: AppColors.error,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Case_Document.pdf",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                "2.4 MB",
                                style: AppTextStyles.caption.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(
                          Icons.download_rounded,
                          color: colorScheme.primary,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    "09:25 AM",
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurfaceVariant,
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