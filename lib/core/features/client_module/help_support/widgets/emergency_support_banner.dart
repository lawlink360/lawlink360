import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class EmergencySupportBanner extends StatelessWidget {
  final VoidCallback? onContact;

  const EmergencySupportBanner({
    super.key,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Color(0xFF1E3A8A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.16),
              ),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Need Immediate Assistance?',
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Our support team is ready to help you with technical issues and account-related questions.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: onContact,
              icon: const Icon(
                Icons.headset_mic_rounded,
                size: 19,
              ),
              label: const Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                textStyle: AppTextStyles.button.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
