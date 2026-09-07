import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/profile_menu_data.dart';
import '../data/profile_stats_data.dart';
import '../data/profile_user_data.dart';
import '../widgets/logout_button.dart';
import '../widgets/premium_banner.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_tile.dart';
import '../widgets/profile_stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: AppTextStyles.title.copyWith(
            color: AppColors.lightTextPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: AppSpacing.md,
          bottom: AppSpacing.lg,
        ),
        children: [
          ProfileHeaderCard(
            name: ProfileUserData.currentUser.name,
            email: ProfileUserData.currentUser.email,
            phone: ProfileUserData.currentUser.phone,
            imageUrl: ProfileUserData.currentUser.imageUrl,
            verified: ProfileUserData.currentUser.verified,
          ),

          const SizedBox(height: AppSpacing.lg),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: AppColors.lightBorder,
              ),
            ),
            child: Row(
              children: ProfileStatsData.items
                  .map(
                    (stat) => ProfileStatsCard(
                      icon: stat.icon,
                      iconColor: stat.iconColor,
                      value: stat.value,
                      title: stat.title,
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          const PremiumBanner(),

          const SizedBox(height: AppSpacing.lg),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: AppColors.lightBorder,
              ),
            ),
            child: Column(
              children: ProfileMenuData.items
                  .map(
                    (item) => ProfileMenuTile(
                      icon: item.icon,
                      iconColor: item.iconColor,
                      title: item.title,
                      subtitle: item.subtitle,
                      onTap: item.onTap,
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          const LogoutButton(),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}