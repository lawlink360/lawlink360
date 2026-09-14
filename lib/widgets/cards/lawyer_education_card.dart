import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerEducationCard extends StatelessWidget {
  final Lawyer? lawyer;

  const LawyerEducationCard({
    super.key,
    this.lawyer,
  });

  @override
  Widget build(BuildContext context) {
    if (lawyer != null) {
      return _buildProfessionalInformation(
        context,
        lawyer!,
      );
    }

    return _buildDemoEducation(context);
  }

  Widget _buildProfessionalInformation(
    BuildContext context,
    Lawyer lawyer,
  ) {
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
            'Professional Information',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _item(
            context,
            Icons.gavel_rounded,
            'Speciality',
            lawyer.speciality.isEmpty
                ? 'Legal Practice'
                : lawyer.speciality,
          ),
          const Divider(
            height: AppSpacing.xxl,
          ),
          _item(
            context,
            Icons.workspace_premium_rounded,
            'Professional Experience',
            '${lawyer.experience} years',
          ),
          const Divider(
            height: AppSpacing.xxl,
          ),
          _item(
            context,
            lawyer.verified
                ? Icons.verified_rounded
                : Icons.info_outline_rounded,
            'Verification Status',
            lawyer.verified
                ? 'Verified Lawyer'
                : 'Verification pending',
          ),
        ],
      ),
    );
  }

  Widget _buildDemoEducation(BuildContext context) {
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
            'Education & Certifications',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _item(
            context,
            Icons.school_rounded,
            'LL.B',
            'University of Punjab',
          ),
          const Divider(
            height: AppSpacing.xxl,
          ),
          _item(
            context,
            Icons.workspace_premium_rounded,
            'LL.M (Criminal Law)',
            'International Islamic University',
          ),
          const Divider(
            height: AppSpacing.xxl,
          ),
          _item(
            context,
            Icons.verified_rounded,
            'Pakistan Bar Council',
            'Licensed Advocate',
          ),
        ],
      ),
    );
  }

  static Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(
            icon,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}