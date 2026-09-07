import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/navigator_item_model.dart';
import 'resource_count_badge.dart';

class NavigatorTile extends StatelessWidget {
  final NavigatorItemModel item;
  final VoidCallback? onTap;

  const NavigatorTile({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foregroundColor = item.isEnabled
        ? AppColors.lightTextPrimary
        : AppColors.lightTextSecondary;

    final secondaryColor = item.isEnabled
        ? AppColors.lightTextSecondary
        : AppColors.lightTextSecondary.withValues(alpha: 0.6);

    final iconColor = item.isEnabled
        ? AppColors.primary
        : AppColors.lightTextSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: item.isEnabled
                      ? AppColors.primary.withValues(alpha: 0.06)
                      : AppColors.lightBorder.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  item.icon,
                  size: 22,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        color: foregroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              if (item.count > 0)
                ResourceCountBadge(count: item.count),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: item.isEnabled
                    ? AppColors.lightTextSecondary
                    : AppColors.lightTextSecondary.withValues(alpha: 0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
