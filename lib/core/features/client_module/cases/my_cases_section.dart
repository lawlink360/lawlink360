import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'case_card.dart';

class MyCasesSection extends StatelessWidget {
  const MyCasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'My Cases',
                  style: AppTextStyles.headline.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                ),
                child: Text(
                  'View All',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        SizedBox(
          height: 240,
          child: ListView(
            padding: const EdgeInsets.only(
              left: AppSpacing.lg,
            ),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              CaseCard(
                title: 'Civil Suit No.123/2026',
                status: 'Active',
                hearingDate: '18 July 2026',
                progress: 0.70,
                onTap: () {},
              ),
              CaseCard(
                title: 'Family Matter',
                status: 'Pending',
                hearingDate: '22 July 2026',
                progress: 0.45,
                onTap: () {},
              ),
              CaseCard(
                title: 'Bail Application',
                status: 'Completed',
                hearingDate: 'Completed',
                progress: 1.0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}