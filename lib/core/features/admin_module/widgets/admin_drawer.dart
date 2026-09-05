import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AdminDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const List<_AdminDrawerItem> _items = [
    _AdminDrawerItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    _AdminDrawerItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'Users',
    ),
    _AdminDrawerItem(
      icon: Icons.gavel_outlined,
      activeIcon: Icons.gavel,
      label: 'Lawyers',
    ),
    _AdminDrawerItem(
      icon: Icons.event_outlined,
      activeIcon: Icons.event,
      label: 'Appointments',
    ),
    _AdminDrawerItem(
      icon: Icons.folder_outlined,
      activeIcon: Icons.folder,
      label: 'Cases',
    ),
    _AdminDrawerItem(
      icon: Icons.verified_outlined,
      activeIcon: Icons.verified,
      label: 'Verification',
    ),
    _AdminDrawerItem(
      icon: Icons.payments_outlined,
      activeIcon: Icons.payments,
      label: 'Payments',
    ),
    _AdminDrawerItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
      label: 'Notifications',
    ),
    _AdminDrawerItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icons.analytics,
      label: 'Analytics',
    ),
    _AdminDrawerItem(
      icon: Icons.description_outlined,
      activeIcon: Icons.description,
      label: 'Reports',
    ),
    _AdminDrawerItem(
      icon: Icons.article_outlined,
      activeIcon: Icons.article,
      label: 'Content',
    ),
    _AdminDrawerItem(
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
      label: 'Activity',
    ),
    _AdminDrawerItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final isSelected = selectedIndex == index;

                  return ListTile(
                    leading: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.iconTheme.color,
                    ),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor:
                        theme.colorScheme.primary.withValues(alpha: 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 2,
                    ),
                    onTap: () {
                      onItemSelected(index);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              onTap: () {
                Navigator.of(context).pop();
                // Logout logic will be connected later.
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: theme.colorScheme.primary.withValues(
              alpha: 0.12,
            ),
            child: Icon(
              Icons.admin_panel_settings_outlined,
              size: 30,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LawLink360',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Admin Panel',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminDrawerItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _AdminDrawerItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}