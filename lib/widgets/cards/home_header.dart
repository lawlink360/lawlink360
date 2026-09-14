import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/notification/providers/notification_provider.dart';
import 'package:lawlink360/core/features/client_module/notification/screens/notification_screen.dart';
import 'package:lawlink360/core/features/client_module/user_profile/screens/profile_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class HomeHeader extends ConsumerWidget {
  final String greeting;
  final String name;
  final String? subtitle;

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.name,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        120.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.xl),
          bottomRight: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Row: Menu, Profile, Greeting, Notifications
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --------------------------------------------------------------
              // MENU + PROFILE — VERTICAL
              // --------------------------------------------------------------
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderIconButton(
                    icon: Icons.menu_rounded,
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: _ProfileAvatar(name: name),
                  ),
                ],
              ),

              const SizedBox(width: AppSpacing.md),

              // --------------------------------------------------------------
              // GREETING + NAME - Properly aligned with profile avatar (center)
              // --------------------------------------------------------------
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      greeting,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // --------------------------------------------------------------
              // NOTIFICATIONS
              // --------------------------------------------------------------
              _NotificationButton(
                unreadCount: unreadCount,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // --------------------------------------------------------------
          // SUBTITLE - Full width, center aligned
          // --------------------------------------------------------------
          if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith( // CHANGED: Using 'body' instead of 'bodyMedium'
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================================
// HEADER ICON BUTTON
// ============================================================================

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.35),
            ),
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppColors.accent,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PROFILE AVATAR
// ============================================================================

class _ProfileAvatar extends StatelessWidget {
  final String name;

  const _ProfileAvatar({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isEmpty
        ? 'U'
        : name.trim()[0].toUpperCase();

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accent,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.85),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.24),
            blurRadius: AppSpacing.sm,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          initial,
          style: AppTextStyles.title.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// NOTIFICATION BUTTON
// ============================================================================

class _NotificationButton extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onTap;

  const _NotificationButton({
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.35),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 23,
                    color: AppColors.accent,
                  ),
                ),
              ),

              if (unreadCount > 0)
                Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 17,
                      minHeight: 17,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          height: 1,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}