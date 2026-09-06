import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class ApplicationRecentDocuments extends StatelessWidget {
  const ApplicationRecentDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final recentDocuments = [
      {
        'title': 'Leave Application',
        'subtitle': 'Applications & Requests',
        'icon': Icons.description_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'FIR Request',
        'subtitle': 'Government Applications',
        'icon': Icons.local_police_rounded,
        'color': Colors.indigo,
      },
      {
        'title': 'Rent Agreement',
        'subtitle': 'Contracts & Agreements',
        'icon': Icons.home_work_rounded,
        'color': Colors.green,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Documents',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentDocuments.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final document = recentDocuments[index];
              final documentColor = document['color'] as Color;

              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Ink(
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: documentColor.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: documentColor.withValues(alpha: 0.16),
                            ),
                          ),
                          child: Icon(
                            document['icon'] as IconData,
                            color: documentColor,
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                document['subtitle'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.caption.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.62),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: colorScheme.onSurface
                              .withValues(alpha: 0.42),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
