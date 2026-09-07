import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/faq_data.dart';
import '../data/help_data.dart';
import '../widgets/contact_card.dart';
import '../widgets/emergency_support_banner.dart';
import '../widgets/faq_tile.dart';
import '../widgets/help_category_card.dart';
import '../widgets/social_links_card.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        centerTitle: true,
        title: Text(
          'Help & Support',
          style: AppTextStyles.title.copyWith(
            color: AppColors.lightTextPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Help',
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.lightTextSecondary,
                ),
                filled: true,
                fillColor: AppColors.lightSurface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(
                    color: AppColors.lightBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(
                    color: AppColors.accent,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            _SectionHeader(
              title: 'Help Categories',
              icon: Icons.category_outlined,
            ),

            const SizedBox(height: AppSpacing.sm),

            ...HelpData.categories.map(
              (item) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.sm,
                ),
                child: HelpCategoryCard(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  onTap: item.onTap,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionHeader(
              title: 'Frequently Asked Questions',
              icon: Icons.help_outline_rounded,
            ),

            const SizedBox(height: AppSpacing.sm),

            ...FaqData.items.map(
              (faq) => FaqTile(
                question: faq.question,
                answer: faq.answer,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionHeader(
              title: 'Contact Support',
              icon: Icons.support_agent_rounded,
            ),

            const SizedBox(height: AppSpacing.sm),

            Container(
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.lightBorder,
                ),
              ),
              child: const Column(
                children: [
                  ContactCard(
                    icon: Icons.email_outlined,
                    iconColor: AppColors.info,
                    title: 'Email',
                    subtitle: 'support@lawlink360.com',
                  ),
                  Divider(
                    height: 1,
                    color: AppColors.divider,
                  ),
                  ContactCard(
                    icon: Icons.phone_outlined,
                    iconColor: AppColors.success,
                    title: 'Phone',
                    subtitle: '+92 XXX XXXXXXX',
                  ),
                  Divider(
                    height: 1,
                    color: AppColors.divider,
                  ),
                  ContactCard(
                    icon: Icons.chat_outlined,
                    iconColor: AppColors.warning,
                    title: 'Live Chat',
                    subtitle: 'Available soon',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionHeader(
              title: 'Follow Us',
              icon: Icons.public_rounded,
            ),

            const SizedBox(height: AppSpacing.sm),

            const SocialLinksCard(
              title: 'Facebook',
              icon: Icons.facebook,
              color: AppColors.info,
            ),

            const SizedBox(height: AppSpacing.sm),

            const SocialLinksCard(
              title: 'Instagram',
              icon: Icons.camera_alt_outlined,
              color: Color(0xFF8B5CF6),
            ),

            const SizedBox(height: AppSpacing.sm),

            const SocialLinksCard(
              title: 'LinkedIn',
              icon: Icons.business,
              color: AppColors.secondary,
            ),

            const SizedBox(height: AppSpacing.sm),

            const SocialLinksCard(
              title: 'YouTube',
              icon: Icons.play_circle_outline,
              color: AppColors.error,
            ),

            const SizedBox(height: AppSpacing.lg),

            const EmergencySupportBanner(),

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: const Icon(
            Icons.help_outline_rounded,
            color: AppColors.accent,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.title.copyWith(
              color: AppColors.lightTextPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
