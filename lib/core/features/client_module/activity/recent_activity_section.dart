import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'activity_card.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Recent Activity',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppRadius.md,
                    ),
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

          const SizedBox(height: AppSpacing.sm),

          const ActivityCard(
            icon: Icons.description_rounded,
            iconColor: Colors.green,
            title: 'Application Generated',
            subtitle: 'NADRA CNIC Application',
            time: '2 hours ago',
          ),

          const ActivityCard(
            icon: Icons.video_call_rounded,
            iconColor: Colors.blue,
            title: 'Lawyer Consultation',
            subtitle: 'Video Call with Adv. Ahmed Khan',
            time: 'Yesterday',
          ),

          const ActivityCard(
            icon: Icons.gavel_rounded,
            iconColor: Colors.deepPurple,
            title: 'Case Updated',
            subtitle: 'Civil Suit No.123/2026',
            time: '2 days ago',
          ),

          const ActivityCard(
            icon: Icons.verified_user_rounded,
            iconColor: Colors.orange,
            title: 'Document Verified',
            subtitle: 'Sale Agreement Verification',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }
}