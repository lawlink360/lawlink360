import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/copy_house/services/copy_house_support_launcher.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class RepresentativeContactScreen extends StatelessWidget {
  const RepresentativeContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Apply Through a Representative',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Choose how you would like our team to assist you.',
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ContactOption(
            icon: Icons.chat_rounded,
            title: 'Request by WhatsApp',
            subtitle:
                'Open WhatsApp with a pre-filled message. You can review '
                'and send the message yourself.',
            onTap: () => _launch(
              context,
              () => const CopyHouseSupportLauncher().openWhatsApp(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ContactOption(
            icon: Icons.call_rounded,
            title: 'Request by Phone Call',
            subtitle:
                'Open the phone dialler with the support number filled in. '
                'The call is not placed automatically.',
            onTap: () => _launch(
              context,
              () => const CopyHouseSupportLauncher().openDialler(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launch(
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

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
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
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.11),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.42),
              ),
            ],
          ),
        ),
      ),
    );
  }
}