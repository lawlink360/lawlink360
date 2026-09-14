import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_data.dart';
import '../models/notification_model.dart';
import '../models/notification_type.dart';

final notificationProvider =
    NotifierProvider<NotificationNotifier, List<NotificationModel>>(
  NotificationNotifier.new,
);

class NotificationNotifier extends Notifier<List<NotificationModel>> {
  @override
  List<NotificationModel> build() {
    return List<NotificationModel>.from(NotificationData.notifications);
  }

  int get unreadCount {
    return state.where((notification) => !notification.isRead).length;
  }

  void markAsRead(String notificationId) {
    state = [
      for (final notification in state)
        if (notification.notificationId == notificationId)
          notification.copyWith(isRead: true)
        else
          notification,
    ];
  }

  void markAllAsRead() {
    state = [
      for (final notification in state)
        notification.copyWith(isRead: true),
    ];
  }

  void removeNotification(String notificationId) {
    state = state
        .where(
          (notification) =>
              notification.notificationId != notificationId,
        )
        .toList();
  }

  List<NotificationModel> notificationsByType(
    NotificationType? type,
  ) {
    if (type == null) {
      return state;
    }

    return state
        .where((notification) => notification.type == type)
        .toList();
  }

  void resetNotifications() {
    state = List<NotificationModel>.from(
      NotificationData.notifications,
    );
  }
}

final unreadNotificationCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationProvider);

  return notifications
      .where((notification) => !notification.isRead)
      .length;
});