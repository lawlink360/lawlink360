import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class AboutCard extends StatelessWidget {
  final String version;
  final VoidCallback? onPrivacyPolicy;
  final VoidCallback? onTermsConditions;

  const AboutCard({
    super.key,
    required this.version,
    this.onPrivacyPolicy,
    this.onTermsConditions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About LawLink360',
            style: AppTextStyles.title.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: AppColors.info,
                size: 21,
              ),
            ),
            title: Text(
              'App Version',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              version,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Divider(
            color: AppColors.divider,
            height: AppSpacing.lg,
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: const Icon(
                Icons.privacy_tip_outlined,
                color: AppColors.primary,
                size: 21,
              ),
            ),
            title: Text(
              'Privacy Policy',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurface.withValues(
                alpha: 0.45,
              ),
            ),
            onTap: onPrivacyPolicy,
          ),

          Divider(
            color: AppColors.divider,
            height: AppSpacing.lg,
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.secondary,
                size: 21,
              ),
            ),
            title: Text(
              'Terms & Conditions',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurface.withValues(
                alpha: 0.45,
              ),
            ),
            onTap: onTermsConditions,
          ),
        ],
      ),
    );
  }
}