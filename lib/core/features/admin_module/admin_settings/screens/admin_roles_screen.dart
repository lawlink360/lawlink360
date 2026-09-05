import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/widgets/admin_role_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminRolesScreen extends StatelessWidget {
  const AdminRolesScreen({super.key});

  static const List<_AdminRoleData> _roles = [
    _AdminRoleData(
      roleName: 'Super Admin',
      description:
          'Full access to all LawLink360 administration features and settings.',
      adminCount: 1,
      permissionCount: 15,
      isActive: true,
    ),
    _AdminRoleData(
      roleName: 'Administrator',
      description:
          'Manages users, lawyers, verification, appointments, cases and reports.',
      adminCount: 3,
      permissionCount: 12,
      isActive: true,
    ),
    _AdminRoleData(
      roleName: 'Moderator',
      description:
          'Handles reports, complaints, notifications and user activity.',
      adminCount: 5,
      permissionCount: 7,
      isActive: true,
    ),
    _AdminRoleData(
      roleName: 'Verification Officer',
      description:
          'Reviews and manages lawyer and user verification requests.',
      adminCount: 4,
      permissionCount: 4,
      isActive: true,
    ),
    _AdminRoleData(
      roleName: 'Support Staff',
      description:
          'Provides support and handles basic user and appointment assistance.',
      adminCount: 6,
      permissionCount: 3,
      isActive: true,
    ),
    _AdminRoleData(
      roleName: 'Content Manager',
      description:
          'Manages legal content, applications, educational resources and announcements.',
      adminCount: 2,
      permissionCount: 5,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Admin Roles',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 12,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          ..._roles.map(
            (role) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AdminRoleCard(
                roleName: role.roleName,
                description: role.description,
                adminCount: role.adminCount,
                permissionCount: role.permissionCount,
                isActive: role.isActive,
                onTap: () {
                  _showRoleDetails(
                    context,
                    role,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.10),
            ),
            child: Icon(
              Icons.admin_panel_settings_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Administrator Roles',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_roles.length} roles configured for the admin system.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRoleDetails(
    BuildContext context,
    _AdminRoleData role,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role.roleName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  role.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                _RoleDetailRow(
                  label: 'Status',
                  value: role.isActive ? 'Active' : 'Inactive',
                ),
                _RoleDetailRow(
                  label: 'Administrators',
                  value: role.adminCount.toString(),
                ),
                _RoleDetailRow(
                  label: 'Permissions',
                  value: role.permissionCount.toString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AdminRoleData {
  final String roleName;
  final String description;
  final int adminCount;
  final int permissionCount;
  final bool isActive;

  const _AdminRoleData({
    required this.roleName,
    required this.description,
    required this.adminCount,
    required this.permissionCount,
    required this.isActive,
  });
}

class _RoleDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _RoleDetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}