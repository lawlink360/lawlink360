import 'package:flutter/material.dart';

class AdminFilterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool hasActiveFilters;

  const AdminFilterButton({
    super.key,
    this.onPressed,
    this.label = 'Filter',
    this.hasActiveFilters = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.filter_list),
          if (hasActiveFilters)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      label: Text(label),
    );
  }
}