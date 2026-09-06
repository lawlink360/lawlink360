
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'service_card.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Popular Services',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ServiceCard(
            icon: Icons.badge_outlined,
            title: 'NADRA Services',
            subtitle: 'CNIC, FRC & Family Records',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ServiceCard(
            icon: Icons.local_police_outlined,
            title: 'Police Applications',
            subtitle: 'FIR & Police Verification',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ServiceCard(
            icon: Icons.description_outlined,
            title: 'Revenue Applications',
            subtitle: 'Land & Property Records',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ServiceCard(
            icon: Icons.balance,
            title: 'Consumer Court',
            subtitle: 'Consumer Complaints',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ServiceCard(
            icon: Icons.flash_on,
            title: 'WAPDA Complaints',
            subtitle: 'Electricity Complaints',
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          ServiceCard(
            icon: Icons.account_balance,
            title: 'PM Portal',
            subtitle: 'Government Complaints',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
