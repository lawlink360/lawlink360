/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : navigator_card.dart
/// Purpose : Card containing all Legal Navigator resources.
/// ------------------------------------------------------------

import 'package:flutter/material.dart';

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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SectionDivider(),
        itemBuilder: (context, index) {
          final item = items[index];

          return NavigatorTile(
            item: item,
            onTap: () => onItemTap?.call(item),
          );
        },
      ),
    );
  }
}