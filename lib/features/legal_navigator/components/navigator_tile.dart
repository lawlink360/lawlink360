import 'package:flutter/material.dart';

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
    return ListTile(
      enabled: item.isEnabled,
      leading: CircleAvatar(
        radius: 22,
        child: Icon(item.icon, size: 22)
      ),
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(item.subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.count > 0)
            ResourceCountBadge(count: item.count),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: item.isEnabled ? onTap : null,
    );
  }
}