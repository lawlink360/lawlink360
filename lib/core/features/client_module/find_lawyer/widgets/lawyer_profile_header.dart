import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerProfileHeader extends StatefulWidget {
  final Lawyer? lawyer;

  const LawyerProfileHeader({
    super.key,
    this.lawyer,
  });

  @override
  State<LawyerProfileHeader> createState() =>
      _LawyerProfileHeaderState();
}

class _LawyerProfileHeaderState
    extends State<LawyerProfileHeader> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final lawyer = widget.lawyer;

    final name = lawyer?.name ?? 'Adv. Ahmed Khan';
    final speciality =
        lawyer?.speciality ?? 'Criminal & Civil Lawyer';

    final rating =
        lawyer?.rating.toStringAsFixed(1) ?? '4.9';

    final experience =
        lawyer != null ? '${lawyer.experience}+' : '12+';

    final cases =
        lawyer != null ? '${lawyer.casesHandled}+' : '560+';

    final verified = lawyer?.verified ?? true;

    final courtLevel =
        _formatCourtLevel(lawyer?.courtLevel);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.22 : 0.07,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _HeaderActionButton(
                icon: _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isFavorite
                    ? Colors.redAccent
                    : colorScheme.onSurface,
                tooltip: _isFavorite
                    ? 'Remove from favorites'
                    : 'Add to favorites',
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          _isFavorite
                              ? 'Lawyer added to favorites'
                              : 'Lawyer removed from favorites',
                        ),
                        duration:
                            const Duration(seconds: 1),
                      ),
                    );
                },
              ),
              const SizedBox(width: AppSpacing.xs),
              _HeaderActionButton(
                icon: Icons.share_outlined,
                color: colorScheme.onSurface,
                tooltip: 'Share lawyer',
                onPressed: () {
                  _showShareDialog(context, name);
                },
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(
                alpha: isDark ? 0.18 : 0.10,
              ),
              border: Border.all(
                color: AppColors.accent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(
                    alpha: 0.18,
                  ),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 55,
              color: AppColors.accent,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headline.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                  ),
                ),
              ),
              if (verified) ...[
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.verified_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            speciality,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'LL.B • LL.M',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _InfoBadge(
                icon: Icons.star_rounded,
                text: '$rating Rating',
              ),
              _InfoBadge(
                icon: Icons.rate_review_outlined,
                text: '428 Reviews',
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Divider(
            color: colorScheme.outline.withValues(
              alpha: 0.45,
            ),
            height: 1,
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatItem(
                value: experience,
                label: 'Years',
                icon: Icons.workspace_premium_rounded,
              ),
              _VerticalDivider(
                color: colorScheme.outline.withValues(
                  alpha: 0.45,
                ),
              ),
              _StatItem(
                value: cases,
                label: 'Cases',
                icon: Icons.gavel_rounded,
              ),
              _VerticalDivider(
                color: colorScheme.outline.withValues(
                  alpha: 0.45,
                ),
              ),
              _StatItem(
                value: courtLevel,
                label: 'Court',
                icon: Icons.account_balance_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCourtLevel(String? value) {
    switch (value?.trim().toLowerCase()) {
      case 'lower':
        return 'Lower';
      case 'high':
        return 'High';
      case 'supreme':
        return 'Supreme';
      default:
        return 'High';
    }
  }

  void _showShareDialog(
    BuildContext context,
    String name,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share Lawyer'),
          content: Text(
            'Share $name with your contacts.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Share link ready',
                      ),
                      duration:
                          Duration(seconds: 1),
                    ),
                  );
              },
              icon: const Icon(
                Icons.share_outlined,
              ),
              label: const Text('Share'),
            ),
          ],
        );
      },
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const _HeaderActionButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest
          .withValues(alpha: 0.55),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: Icon(
          icon,
          color: color,
          size: 21,
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoBadge({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(
          alpha: 0.10,
        ),
        borderRadius:
            BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppColors.accent.withValues(
            alpha: 0.35,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.accent,
            size: 17,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final Color color;

  const _VerticalDivider({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 46,
      color: color,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.accent,
            size: 19,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
