import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_type.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_empty_state.dart';
import '../widgets/notification_filter_tabs.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends ConsumerState<NotificationsScreen> {
  NotificationType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notifications = ref.watch(notificationProvider);

    final filteredNotifications = _selectedType == null
        ? notifications
        : notifications
            .where(
              (notification) =>
                  notification.type == _selectedType,
            )
            .toList();

    final unreadCount = notifications
        .where((notification) => !notification.isRead)
        .length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        titleSpacing: 20,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                ref
                    .read(notificationProvider.notifier)
                    .markAllAsRead();
              },
              child: const Text('Mark all read'),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),

          NotificationFilterTabs(
            selectedType: _selectedType,
            onChanged: (type) {
              setState(() {
                _selectedType = type;
              });
            },
          ),

          const SizedBox(height: 16),

          Expanded(
            child: filteredNotifications.isEmpty
                ? const NotificationEmptyState()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      24,
                    ),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification =
                          filteredNotifications[index];

                      return NotificationCard(
                        notification: notification,
                        onTap: () {
                          ref
                              .read(notificationProvider.notifier)
                              .markAsRead(
                                notification.notificationId,
                              );

                          _handleNotificationAction(
                            context,
                            notification.actionKey,
                          );
                        },
                        onDismiss: () {
                          ref
                              .read(notificationProvider.notifier)
                              .removeNotification(
                                notification.notificationId,
                              );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationAction(
    BuildContext context,
    String? actionKey,
  ) {
    if (actionKey == null) {
      return;
    }

    switch (actionKey) {
      case 'appointments':
        _showComingSoon(context, 'Appointments');
        break;

      case 'myCases':
        _showComingSoon(context, 'My Cases');
        break;

      case 'messages':
        _showComingSoon(context, 'Messages');
        break;

      case 'documents':
        _showComingSoon(context, 'Documents');
        break;

      case 'payments':
        _showComingSoon(context, 'Payments');
        break;

      case 'verification':
        _showComingSoon(context, 'Verification');
        break;

      case 'profile':
        _showComingSoon(context, 'Profile');
        break;
    }
  }

  void _showComingSoon(
    BuildContext context,
    String featureName,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$featureName details will open here.',
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}