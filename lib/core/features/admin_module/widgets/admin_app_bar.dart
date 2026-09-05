import 'package:flutter/material.dart';

/// Reusable AppBar for the LawLink360 Admin Module.
class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const AdminAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: onMenuPressed == null
          ? null
          : IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
            ),
      actions: [
        IconButton(
          onPressed: onNotificationPressed,
          icon: const Icon(Icons.notifications_none),
          tooltip: 'Notifications',
        ),
        IconButton(
          onPressed: onProfilePressed,
          icon: const Icon(Icons.account_circle_outlined),
          tooltip: 'Admin Profile',
        ),
      ],
    );
  }
}