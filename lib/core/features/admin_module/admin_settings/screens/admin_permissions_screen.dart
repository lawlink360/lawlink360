import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_permission_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/providers/admin_permission_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/widgets/permission_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_empty_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_search_bar.dart';

class AdminPermissionsScreen extends ConsumerWidget {
  const AdminPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(adminPermissionProvider);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Permissions',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 12,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: permissionState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load permissions.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (permissions) {
          final notifier = ref.read(adminPermissionProvider.notifier);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: AdminSearchBar(
                  hintText: 'Search permissions...',
                  onChanged: notifier.search,
                ),
              ),
              _buildSummary(
                context,
                notifier,
              ),
              _buildCategoryFilter(
                context,
                ref,
                notifier,
              ),
              Expanded(
                child: permissions.isEmpty
                    ? const AdminEmptyState(
                        title: 'No Permissions Found',
                        message:
                            'No permissions match your current search or filter.',
                        icon: Icons.security_outlined,
                      )
                    : RefreshIndicator(
                        onRefresh: () => notifier.refresh(),
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: permissions.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final permission = permissions[index];

                            return PermissionCard(
                              permission: permission,
                              onChanged: (enabled) {
                                notifier.setPermissionEnabled(
                                  permission.id,
                                  enabled,
                                );
                              },
                              onTap: () {
                                _showPermissionDetails(
                                  context,
                                  permission,
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    AdminPermissionNotifier notifier,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              label: 'Total',
              value: notifier.totalPermissions.toString(),
              icon: Icons.security_outlined,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SummaryItem(
              label: 'Enabled',
              value: notifier.enabledPermissions.toString(),
              icon: Icons.check_circle_outline,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SummaryItem(
              label: 'Disabled',
              value: notifier.disabledPermissions.toString(),
              icon: Icons.block_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(
    BuildContext context,
    WidgetRef ref,
    AdminPermissionNotifier notifier,
  ) {
    final categories = notifier.categories;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = notifier.categoryFilter == category;

          return FilterChip(
            label: Text(category),
            selected: selected,
            onSelected: (_) {
              notifier.setCategoryFilter(category);
            },
          );
        },
      ),
    );
  }

  void _showPermissionDetails(
    BuildContext context,
    AdminPermissionModel permission,
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
                  permission.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                _DetailRow(
                  label: 'Permission Key',
                  value: permission.key,
                ),
                _DetailRow(
                  label: 'Category',
                  value: permission.category,
                ),
                _DetailRow(
                  label: 'Status',
                  value: permission.isEnabled ? 'Enabled' : 'Disabled',
                ),
                const SizedBox(height: 8),
                Text(
                  permission.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}