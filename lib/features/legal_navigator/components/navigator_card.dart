import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../models/navigator_item_model.dart';
import 'navigator_tile.dart';
import 'section_divider.dart';

class NavigatorCard extends StatelessWidget {
  final List<NavigatorItemModel> items;
  final ValueChanged<NavigatorItemModel>? onItemTap;

  const NavigatorCard({
    super.key,
    required this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassDark,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xs,
          ),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SectionDivider(),
          itemBuilder: (context, index) {
            final item = items[index];

            return NavigatorTile(
              item: item,
              onTap: () => onItemTap?.call(item),
            );
          },
        ),
      ),
    );
  }
}
