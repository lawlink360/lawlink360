import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find the\nRight Lawyer',
                  style: AppTextStyles.headline.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Connect with verified advocates across Pakistan.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.78),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          Expanded(
            flex: 4,
            child: Image.asset(
              'assets/images/find_lawyer_hero.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}