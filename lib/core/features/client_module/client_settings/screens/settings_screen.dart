
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/settings_data.dart';
import '../widgets/about_card.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/switch_setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsSection(
            title: 'General',
            children: SettingsData.general.map((item) {
              if (item.isSwitch) {
                return SwitchSettingTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  value: item.switchValue,
                  onChanged: (_) {},
                );
              }

              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          SettingsSection(
            title: 'Security',
            children: SettingsData.security.map((item) {
              if (item.isSwitch) {
                return SwitchSettingTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  value: item.switchValue,
                  onChanged: (_) {},
                );
              }

              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          SettingsSection(
            title: 'Application',
            children: SettingsData.application.map((item) {
              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          SettingsSection(
            title: 'Support',
            children: SettingsData.support.map((item) {
              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          AboutCard(
            version: '1.0.0',
            onPrivacyPolicy: () {},
            onTermsConditions: () {},
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
