import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookConsultationType extends StatelessWidget {
  const BookConsultationType({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consultation Type',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 19,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const Row(
          children: [
            Expanded(
              child: ConsultationCard(
                icon: Icons.person_outline_rounded,
                title: 'In Person',
                selected: true,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ConsultationCard(
                icon: Icons.call_outlined,
                title: 'Voice',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const Row(
          children: [
            Expanded(
              child: ConsultationCard(
                icon: Icons.videocam_outlined,
                title: 'Video',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ConsultationCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Chat',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;

  const ConsultationCard({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = selected
        ? AppColors.accent
        : colorScheme.surface;

    final foregroundColor = selected
        ? Colors.white
        : colorScheme.onSurface;

    final borderColor = selected
        ? AppColors.accent
        : colorScheme.outline.withValues(alpha: 0.45);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 92,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppRadius.lg,
        ),
        border: Border.all(
          color: borderColor,
          width: selected ? 1.4 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(
                    alpha: 0.16,
                  ),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 27,
            color: foregroundColor,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}