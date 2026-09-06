import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AboutLawyerCard extends StatelessWidget {
  const AboutLawyerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.20
                  : 0.06,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Lawyer',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Adv. Ahmed Khan is a highly experienced Criminal Lawyer with over 10 years of professional practice. He specializes in criminal trials, bail matters, FIRs, white-collar crimes, appeals and constitutional petitions. His dedication, integrity and successful case history have earned the trust of hundreds of clients across Pakistan.',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.sm),
          _infoRow(
            context,
            Icons.badge_outlined,
            'Pakistan Bar Council',
          ),
          const SizedBox(height: AppSpacing.sm),
          _infoRow(
            context,
            Icons.location_on_outlined,
            'Islamabad High Court',
          ),
          const SizedBox(height: AppSpacing.sm),
          _infoRow(
            context,
            Icons.schedule_outlined,
            'Mon - Sat • 9:00 AM - 7:00 PM',
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.accent,
          size: 21,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}