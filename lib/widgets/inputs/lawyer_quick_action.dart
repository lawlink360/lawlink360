import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/chat_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/video_consultation_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/voice_call_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionButton(
            icon: Icons.search,
            title: 'Find Lawyer',
            color: AppColors.primary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindLawyerScreen(),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.call_outlined,
            title: 'Call',
            color: AppColors.primary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VoiceCallScreen(),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.videocam_outlined,
            title: 'Video',
            color: AppColors.primary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VideoConsultationScreen(),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.chat_bubble_outline,
            title: 'Chat',
            color: AppColors.primary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonColor = isDark
        ? AppColors.darkSurface
        : color;

    final iconColor = isDark
        ? AppColors.accent
        : Colors.white;

    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            splashColor: AppColors.accent.withValues(alpha: 0.15),
            child: Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: isDark
                    ? Border.all(
                        color: AppColors.darkBorder,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDark ? 0.18 : 0.08,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}