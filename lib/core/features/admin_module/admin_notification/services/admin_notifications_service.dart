import '../data/mock/admin_notifications_mock_data.dart';
import '../models/admin_notification_model.dart';
import '../models/notification_campaign_model.dart';

class AdminNotificationsService {
  AdminNotificationsService._();

  static final AdminNotificationsService instance =
      AdminNotificationsService._();

  List<AdminNotificationModel> _notifications =
      List<AdminNotificationModel>.from(
    AdminNotificationsMockData.notifications,
  );

  List<NotificationCampaignModel> _campaigns =
      List<NotificationCampaignModel>.from(
    AdminNotificationsMockData.campaigns,
  );

  Future<List<AdminNotificationModel>> fetchNotifications() async {
    await _simulateDelay();

    return List<AdminNotificationModel>.from(_notifications);
  }

  Future<List<NotificationCampaignModel>> fetchCampaigns() async {
    await _simulateDelay();

    return List<NotificationCampaignModel>.from(_campaigns);
  }

  Future<AdminNotificationModel?> getNotificationById(
    String notificationId,
  ) async {
    await _simulateDelay();

    for (final notification in _notifications) {
      if (notification.id == notificationId) {
        return notification;
      }
    }

    return null;
  }

  Future<NotificationCampaignModel?> getCampaignById(
    String campaignId,
  ) async {
    await _simulateDelay();

    for (final campaign in _campaigns) {
      if (campaign.id == campaignId) {
        return campaign;
      }
    }

    return null;
  }

  Future<AdminNotificationModel> createNotification(
    AdminNotificationModel notification,
  ) async {
    await _simulateDelay();

    _notifications = [
      notification,
      ..._notifications,
    ];

    return notification;
  }

  Future<AdminNotificationModel?> updateNotification(
    AdminNotificationModel notification,
  ) async {
    await _simulateDelay();

    final index = _notifications.indexWhere(
      (item) => item.id == notification.id,
    );

    if (index == -1) {
      return null;
    }

    _notifications[index] = notification;

    return notification;
  }

  Future<bool> markAsRead(String notificationId) async {
    await _simulateDelay();

    final index = _notifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return false;
    }

    final current = _notifications[index];
    final now = DateTime.now();

    _notifications[index] = current.copyWith(
      isRead: true,
      readAt: now,
      updatedAt: now,
    );

    return true;
  }

  Future<bool> markAsUnread(String notificationId) async {
    await _simulateDelay();

    final index = _notifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return false;
    }

    final current = _notifications[index];
    final now = DateTime.now();

    _notifications[index] = AdminNotificationModel(
      id: current.id,
      title: current.title,
      message: current.message,
      type: current.type,
      recipientType: current.recipientType,
      recipientId: current.recipientId,
      recipientName: current.recipientName,
      recipientEmail: current.recipientEmail,
      priority: current.priority,
      status: current.status,
      isRead: false,
      scheduledAt: current.scheduledAt,
      sentAt: current.sentAt,
      readAt: null,
      createdAt: current.createdAt,
      updatedAt: now,
    );

    return true;
  }

  Future<bool> deleteNotification(String notificationId) async {
    await _simulateDelay();

    final originalLength = _notifications.length;

    _notifications.removeWhere(
      (notification) => notification.id == notificationId,
    );

    return _notifications.length != originalLength;
  }

  Future<bool> updateNotificationStatus(
    String notificationId,
    String status,
  ) async {
    await _simulateDelay();

    final index = _notifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return false;
    }

    final current = _notifications[index];
    final now = DateTime.now();

    _notifications[index] = current.copyWith(
      status: status,
      sentAt: status == 'Sent' ? now : current.sentAt,
      updatedAt: now,
    );

    return true;
  }

  Future<NotificationCampaignModel> createCampaign(
    NotificationCampaignModel campaign,
  ) async {
    await _simulateDelay();

    _campaigns = [
      campaign,
      ..._campaigns,
    ];

    return campaign;
  }

  Future<NotificationCampaignModel?> updateCampaign(
    NotificationCampaignModel campaign,
  ) async {
    await _simulateDelay();

    final index = _campaigns.indexWhere(
      (item) => item.id == campaign.id,
    );

    if (index == -1) {
      return null;
    }

    _campaigns[index] = campaign;

    return campaign;
  }

  Future<bool> updateCampaignStatus(
    String campaignId,
    String status,
  ) async {
    await _simulateDelay();

    final index = _campaigns.indexWhere(
      (campaign) => campaign.id == campaignId,
    );

    if (index == -1) {
      return false;
    }

    final current = _campaigns[index];
    final now = DateTime.now();

    _campaigns[index] = current.copyWith(
      status: status,
      sentAt: status == 'Sent' ? now : current.sentAt,
      updatedAt: now,
    );

    return true;
  }

  Future<bool> deleteCampaign(String campaignId) async {
    await _simulateDelay();

    final originalLength = _campaigns.length;

    _campaigns.removeWhere(
      (campaign) => campaign.id == campaignId,
    );

    return _campaigns.length != originalLength;
  }

  Future<List<AdminNotificationModel>> getSentNotifications() async {
    await _simulateDelay();

    return _notifications
        .where(
          (notification) =>
              notification.status.toLowerCase() == 'sent',
        )
        .toList();
  }

  Future<List<NotificationCampaignModel>> getSentCampaigns() async {
    await _simulateDelay();

    return _campaigns
        .where(
          (campaign) => campaign.status.toLowerCase() == 'sent',
        )
        .toList();
  }

  Future<List<AdminNotificationModel>> searchNotifications(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<AdminNotificationModel>.from(_notifications);
    }

    return _notifications.where((notification) {
      return notification.title.toLowerCase().contains(
                normalizedQuery,
              ) ||
          notification.message.toLowerCase().contains(
                normalizedQuery,
              ) ||
          notification.type.toLowerCase().contains(
                normalizedQuery,
              ) ||
          notification.recipientType.toLowerCase().contains(
                normalizedQuery,
              ) ||
          (notification.recipientName?.toLowerCase().contains(
                    normalizedQuery,
                  ) ??
              false) ||
          (notification.recipientEmail?.toLowerCase().contains(
                    normalizedQuery,
                  ) ??
              false);
    }).toList();
  }

  Future<Map<String, int>> getNotificationSummary() async {
    await _simulateDelay();

    return {
      'total': _notifications.length,
      'unread': _notifications.where((n) => !n.isRead).length,
      'read': _notifications.where((n) => n.isRead).length,
      'scheduled': _notifications
          .where(
            (n) => n.status.toLowerCase() == 'scheduled',
          )
          .length,
      'highPriority': _notifications
          .where(
            (n) => n.priority.toLowerCase() == 'high',
          )
          .length,
      'campaigns': _campaigns.length,
      'sentCampaigns': _campaigns
          .where(
            (c) => c.status.toLowerCase() == 'sent',
          )
          .length,
      'scheduledCampaigns': _campaigns
          .where(
            (c) => c.status.toLowerCase() == 'scheduled',
          )
          .length,
      'draftCampaigns': _campaigns
          .where(
            (c) => c.status.toLowerCase() == 'draft',
          )
          .length,
    };
  }

  Future<void> resetToMockData() async {
    await _simulateDelay();

    _notifications = List<AdminNotificationModel>.from(
      AdminNotificationsMockData.notifications,
    );

    _campaigns = List<NotificationCampaignModel>.from(
      AdminNotificationsMockData.campaigns,
    );
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );
  }
}