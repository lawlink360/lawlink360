import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/models/admin_activity_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/providers/admin_users_provider.dart';

class AdminUserActivityScreen extends ConsumerWidget {
  final String userId;

  const AdminUserActivityScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(adminUsersProvider);
    final user = _findUser(
      userState,
      userId,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Activity'),
      ),
      body: user == null
          ? const Center(
              child: Text('User not found.'),
            )
          : _buildContent(
              context,
              user.name,
            ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    String userName,
  ) {
    final activities = _mockActivities();

    if (activities.isEmpty) {
      return const Center(
        child: Text('No activity found.'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(
          context,
          userName,
        ),
        const SizedBox(height: 16),
        ...activities.map(
          (activity) => _ActivityCard(
            activity: activity,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String userName,
  ) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity History',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    userName,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _findUser(
    List users,
    String id,
  ) {
    for (final user in users) {
      if (user.id == id) {
        return user;
      }
    }

    return null;
  }

  List<AdminActivityModel> _mockActivities() {
    final now = DateTime.now();

    return [
      AdminActivityModel(
        id: 'activity_001',
        userId: userId,
        title: 'Profile Updated',
        description:
            'User profile information was updated.',
        type: 'profile',
        timestamp: now.subtract(
          const Duration(hours: 2),
        ),
      ),
      AdminActivityModel(
        id: 'activity_002',
        userId: userId,
        title: 'Appointment Booked',
        description:
            'A legal consultation appointment was booked.',
        type: 'appointment',
        timestamp: now.subtract(
          const Duration(days: 1),
        ),
      ),
      AdminActivityModel(
        id: 'activity_003',
        userId: userId,
        title: 'Document Uploaded',
        description:
            'A document was uploaded to the account.',
        type: 'document',
        timestamp: now.subtract(
          const Duration(days: 2),
        ),
      ),
      AdminActivityModel(
        id: 'activity_004',
        userId: userId,
        title: 'Login',
        description:
            'User successfully logged into LawLink360.',
        type: 'login',
        timestamp: now.subtract(
          const Duration(days: 3),
        ),
      ),
    ];
  }
}

class _ActivityCard extends StatelessWidget {
  final AdminActivityModel activity;

  const _ActivityCard({
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(
                  alpha: 0.10,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(activity.type),
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activity.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDateTime(activity.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'profile':
        return Icons.person_outline;
      case 'appointment':
        return Icons.calendar_today_outlined;
      case 'document':
        return Icons.description_outlined;
      case 'login':
        return Icons.login;
      default:
        return Icons.history;
    }
  }

  String _formatDateTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} • $hour:$minute $period';
  }
}