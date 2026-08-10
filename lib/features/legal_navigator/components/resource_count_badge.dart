/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : resource_count_badge.dart
/// Purpose : Displays the number of related resources.
/// ------------------------------------------------------------

import 'package:flutter/material.dart';

class ResourceCountBadge extends StatelessWidget {
  final int count;

  const ResourceCountBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}