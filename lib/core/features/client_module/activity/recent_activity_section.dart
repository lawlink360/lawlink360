import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/appointments/screens/appointments_screen.dart';
import 'package:lawlink360/core/features/client_module/client_dashboard/screens/dashboard_screen.dart';
import 'package:lawlink360/core/features/client_module/documents/screens/documents_screen.dart';
import 'package:lawlink360/core/features/client_module/my_cases/screens/my_cases_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'activity_card.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  void _openScreen(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

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
                onPressed: () {
                  _openScreen(
                    context,
                    const DashboardScreen(),
                  );
                },
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

          ActivityCard(
            icon: Icons.description_rounded,
            iconColor: Colors.green,
            title: 'Application Generated',
            subtitle: 'NADRA CNIC Application',
            time: '2 hours ago',
            onTap: () {
              _openScreen(
                context,
                const ApplicationHomeScreen(),
              );
            },
          ),

          ActivityCard(
            icon: Icons.video_call_rounded,
            iconColor: Colors.blue,
            title: 'Lawyer Consultation',
            subtitle: 'Video Call with Adv. Ahmed Khan',
            time: 'Yesterday',
            onTap: () {
              _openScreen(
                context,
                const AppointmentsScreen(),
              );
            },
          ),

          ActivityCard(
            icon: Icons.gavel_rounded,
            iconColor: Colors.deepPurple,
            title: 'Case Updated',
            subtitle: 'Civil Suit No.123/2026',
            time: '2 days ago',
            onTap: () {
              _openScreen(
                context,
                const MyCasesScreen(),
              );
            },
          ),

          ActivityCard(
            icon: Icons.verified_user_rounded,
            iconColor: Colors.orange,
            title: 'Document Verified',
            subtitle: 'Sale Agreement Verification',
            time: '3 days ago',
            onTap: () {
              _openScreen(
                context,
                const DocumentsScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
