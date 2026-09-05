import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/providers/admin_users_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/screens/admin_user_activity_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/screens/admin_user_details_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_filter_sheet.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_search_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_empty_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_error_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_loading_state.dart';

class AdminUsersScreen extends ConsumerStatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    Future.microtask(() => ref.read(adminUsersProvider.notifier).loadUsers());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(adminUsersProvider.notifier);
    final users = notifier.filteredUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            tooltip: 'Filter users',
            onPressed: () {
              _openFilterSheet(context);
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            tooltip: 'Refresh users',
            onPressed: () {
              notifier.refreshUsers();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: notifier.refreshUsers,
          child: _buildBody(context, users),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, List users) {
    final usersState = ref.watch(adminUsersProvider);
    final notifier = ref.read(adminUsersProvider.notifier);

    if (notifier.isLoading && usersState.isEmpty) {
      return const AdminLoadingState();
    }

    if (notifier.hasError && usersState.isEmpty) {
      return AdminErrorState(message: notifier.error.toString());
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(context, notifier),
        const SizedBox(height: 16),
        AdminUserSearchBar(
          controller: _searchController,
          onChanged: notifier.searchUsers,
          onClear: () {
            notifier.searchUsers('');
          },
        ),
        const SizedBox(height: 16),
        _buildFilterIndicator(context, notifier),
        const SizedBox(height: 16),
        if (users.isEmpty)
          const AdminEmptyState(
            title: 'No Users Found',
            message: 'No users match your current search or filter.',
          )
        else
          ...users.map(
            (user) => AdminUserCard(
              user: user,
              onViewDetails: () {
                _openUserDetails(context, user.id);
              },
              onViewActivity: () {
                _openUserActivity(context, user.id);
              },
              onActivate: () {
                _updateUserStatus(context, user.id, 'active');
              },
              onSuspend: () {
                _updateUserStatus(context, user.id, 'suspended');
              },
              onDeactivate: () {
                _updateUserStatus(context, user.id, 'inactive');
              },
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AdminUsersNotifier notifier) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            '${notifier.totalUsers} Users',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          '${notifier.verifiedUsers} verified',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterIndicator(
    BuildContext context,
    AdminUsersNotifier notifier,
  ) {
    final selectedStatus = notifier.selectedStatus;

    if (selectedStatus == null || selectedStatus.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Icon(Icons.filter_alt_outlined, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'Status: ${selectedStatus.toUpperCase()}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            notifier.clearFilters();
            _searchController.clear();
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }

  void _openFilterSheet(BuildContext context) {
    final notifier = ref.read(adminUsersProvider.notifier);

    AdminUserFilterSheet.show(
      context: context,
      selectedStatus: notifier.selectedStatus,
      onStatusChanged: notifier.filterByStatus,
      onClear: () {
        notifier.clearFilters();
        _searchController.clear();
      },
    );
  }

  void _openUserDetails(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AdminUserDetailsScreen(userId: userId)),
    );
  }

  void _openUserActivity(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminUserActivityScreen(userId: userId),
      ),
    );
  }

  Future<void> _updateUserStatus(
    BuildContext context,
    String userId,
    String status,
  ) async {
    final notifier = ref.read(adminUsersProvider.notifier);

    await notifier.updateUserStatus(userId, status);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User status updated to ${status.toUpperCase()}.'),
      ),
    );
  }
}
