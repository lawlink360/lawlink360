import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/user_profile/screens/profile_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final String greeting;
  final String name;
  final String subtitle;

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.name,
    this.subtitle = 'Your Legal Companion',
  });

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        55,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            AppRadius.xl + AppSpacing.xs,
          ),
          bottomRight: Radius.circular(
            AppRadius.xl + AppSpacing.xs,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xFF1B263B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  greeting,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              IconButton(
                tooltip: 'Notifications',
                onPressed: null,
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: AppSpacing.xs),

              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => _openProfile(context),
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.accent,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            name,
            style: AppTextStyles.displayLarge.copyWith(
              color: Colors.white,
              fontSize: 30,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.body.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}