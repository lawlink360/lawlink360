import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../services/copy_house_support_launcher.dart';

/// Customer Support Center shown on the Copy House landing screen.
///
/// Two options side by side: WhatsApp Support and Direct Call. Both
/// refuse to launch while the support number is the placeholder, and
/// both surface a user-facing message if the device cannot handle the
/// action.
class CustomerSupportCenter extends StatelessWidget {
  final CopyHouseSupportLauncher launcher;

  const CustomerSupportCenter({
    super.key,
    this.launcher = const CopyHouseSupportLauncher(),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.support_agent_rounded,
                size: 22,
                color: colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Customer Support Center',
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            'Reach our team for help with Copy House requests.',
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _SupportAction(
                  icon: Icons.chat_rounded,
                  label: 'WhatsApp Support',
                  onTap: () => _handle(
                    context,
                    () => launcher.openWhatsApp(),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SupportAction(
                  icon: Icons.call_rounded,
                  label: 'Direct Call',
                  onTap: () => _handle(
                    context,
                    () => launcher.openDialler(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handle(
    BuildContext context,
    Future<SupportLaunchResult> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);

    final result = await action();

    if (!context.mounted) return;

    switch (result) {
      case SupportLaunchResult.launched:
        return;
      case SupportLaunchResult.notConfigured:
        messenger?.showSnackBar(
          const SnackBar(
            content: Text(
              'Support contact is being configured. Please try again later.',
            ),
          ),
        );
        return;
      case SupportLaunchResult.unsupportedOrFailed:
        messenger?.showSnackBar(
          const SnackBar(
            content: Text(
              'This action is not supported on this device.',
            ),
          ),
        );
        return;
    }
  }
}

class _SupportAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SupportAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.accent, size: 26),
              const SizedBox(height: AppSpacing.xs),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}