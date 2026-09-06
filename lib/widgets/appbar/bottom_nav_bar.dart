import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      height: 80,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      indicatorColor: AppColors.accent.withValues(alpha: 0.16),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: const Icon(
            Icons.home_rounded,
            color: AppColors.accent,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.balance_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: const Icon(
            Icons.balance_rounded,
            color: AppColors.accent,
          ),
          label: 'Lawyers',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: const Icon(
            Icons.chat_bubble_rounded,
            color: AppColors.accent,
          ),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.description_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: const Icon(
            Icons.description_rounded,
            color: AppColors.accent,
          ),
          label: 'Documents',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: const Icon(
            Icons.person_rounded,
            color: AppColors.accent,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}