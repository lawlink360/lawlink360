import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_notifications_mock_data.dart';
import '../models/admin_notification_model.dart';
import '../models/notification_campaign_model.dart';

final adminNotificationsProvider = NotifierProvider<
    AdminNotificationsNotifier,
    AsyncValue<List<AdminNotificationModel>>>(
  AdminNotificationsNotifier.new,
);

class AdminNotificationsNotifier
    extends Notifier<AsyncValue<List<AdminNotificationModel>>> {
  List<AdminNotificationModel> _allNotifications = [];
  List<NotificationCampaignModel> _allCampaigns = [];

  String _searchQuery = '';
  String? _selectedType;
  String? _selectedRecipientType;
  String? _selectedStatus;
  String? _selectedPriority;

  @override
  AsyncValue<List<AdminNotificationModel>> build() {
    _allNotifications = List<AdminNotificationModel>.from(
      AdminNotificationsMockData.notifications,
    );

    _allCampaigns = List<NotificationCampaignModel>.from(
      AdminNotificationsMockData.campaigns,
    );

    return AsyncData(_allNotifications);
  }

  // ---------------------------------------------------------------------------
  // SEARCH
  // ---------------------------------------------------------------------------

  void search(String query) {
    _searchQuery = query.trim();
    _applyFilters();
  }

  // ---------------------------------------------------------------------------
  // FILTERS
  // ---------------------------------------------------------------------------

  void filterByType(String? type) {
    _selectedType = type;
    _applyFilters();
  }

  void filterByRecipientType(String? recipientType) {
    _selectedRecipientType = recipientType;
    _applyFilters();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _applyFilters();
  }

  void filterByPriority(String? priority) {
    _selectedPriority = priority;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedType = null;
    _selectedRecipientType = null;
    _selectedStatus = null;
    _selectedPriority = null;

    state = AsyncData(
      List<AdminNotificationModel>.from(_allNotifications),
    );
  }

  // ---------------------------------------------------------------------------
  // REFRESH
  // ---------------------------------------------------------------------------

  Future<void> refresh() async {
    state = const AsyncLoading();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    _allNotifications = List<AdminNotificationModel>.from(
      AdminNotificationsMockData.notifications,
    );

    _allCampaigns = List<NotificationCampaignModel>.from(
      AdminNotificationsMockData.campaigns,
    );

    _applyFilters();
  }

  // ---------------------------------------------------------------------------
  // NOTIFICATION ACTIONS
  // ---------------------------------------------------------------------------

  void markAsRead(String notificationId) {
    final index = _allNotifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return;
    }

    final now = DateTime.now();

    _allNotifications[index] = _allNotifications[index].copyWith(
      isRead: true,
      readAt: now,
      updatedAt: now,
    );

    _applyFilters();
  }

  void markAsUnread(String notificationId) {
    final index = _allNotifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return;
    }

    _allNotifications[index] = _allNotifications[index].copyWith(
      isRead: false,
      readAt: null,
      updatedAt: DateTime.now(),
    );

    _applyFilters();
  }

  void deleteNotification(String notificationId) {
    _allNotifications.removeWhere(
      (notification) => notification.id == notificationId,
    );

    _applyFilters();
  }

  void updateNotificationStatus(
    String notificationId,
    String status,
  ) {
    final index = _allNotifications.indexWhere(
      (notification) => notification.id == notificationId,
    );

    if (index == -1) {
      return;
    }

    _allNotifications[index] = _allNotifications[index].copyWith(
      status: status,
      sentAt: status == 'Sent'
          ? DateTime.now()
          : _allNotifications[index].sentAt,
      updatedAt: DateTime.now(),
    );

    _applyFilters();
  }

  void addNotification(AdminNotificationModel notification) {
    _allNotifications.insert(0, notification);
    _applyFilters();
  }

  // ---------------------------------------------------------------------------
  // CAMPAIGNS
  // ---------------------------------------------------------------------------

  List<NotificationCampaignModel> get campaigns {
    return List<NotificationCampaignModel>.from(_allCampaigns);
  }

  void addCampaign(NotificationCampaignModel campaign) {
    _allCampaigns.insert(0, campaign);
  }

  void updateCampaignStatus(
    String campaignId,
    String status,
  ) {
    final index = _allCampaigns.indexWhere(
      (campaign) => campaign.id == campaignId,
    );

    if (index == -1) {
      return;
    }

    _allCampaigns[index] = _allCampaigns[index].copyWith(
      status: status,
      sentAt: status == 'Sent'
          ? DateTime.now()
          : _allCampaigns[index].sentAt,
      updatedAt: DateTime.now(),
    );
  }

  // ---------------------------------------------------------------------------
  // GETTERS
  // ---------------------------------------------------------------------------

  List<AdminNotificationModel> get filteredNotifications {
    return state.valueOrNull ?? [];
  }

  int get totalCount => _allNotifications.length;

  int get unreadCount {
    return _allNotifications
        .where((notification) => !notification.isRead)
        .length;
  }

  int get readCount {
    return _allNotifications
        .where((notification) => notification.isRead)
        .length;
  }

  int get pendingCount {
    return _allNotifications
        .where((notification) => notification.status == 'Scheduled')
        .length;
  }

  int get highPriorityCount {
    return _allNotifications
        .where((notification) => notification.priority == 'High')
        .length;
  }

  int get campaignCount => _allCampaigns.length;

  int get sentCampaignCount {
    return _allCampaigns
        .where((campaign) => campaign.status == 'Sent')
        .length;
  }

  int get scheduledCampaignCount {
    return _allCampaigns
        .where((campaign) => campaign.status == 'Scheduled')
        .length;
  }

  int get draftCampaignCount {
    return _allCampaigns
        .where((campaign) => campaign.status == 'Draft')
        .length;
  }

  AdminNotificationModel? getNotificationById(
    String notificationId,
  ) {
    for (final notification in _allNotifications) {
      if (notification.id == notificationId) {
        return notification;
      }
    }

    return null;
  }

  NotificationCampaignModel? getCampaignById(
    String campaignId,
  ) {
    for (final campaign in _allCampaigns) {
      if (campaign.id == campaignId) {
        return campaign;
      }
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // INTERNAL FILTERING
  // ---------------------------------------------------------------------------

  void _applyFilters() {
    final query = _searchQuery.toLowerCase();

    final filtered = _allNotifications.where((notification) {
      final matchesSearch =
          query.isEmpty ||
          notification.title.toLowerCase().contains(query) ||
          notification.message.toLowerCase().contains(query) ||
          notification.type.toLowerCase().contains(query) ||
          notification.recipientType.toLowerCase().contains(query) ||
          (notification.recipientName?.toLowerCase().contains(query) ??
              false) ||
          (notification.recipientEmail?.toLowerCase().contains(query) ??
              false);

      final matchesType =
          _selectedType == null ||
          notification.type.toLowerCase() ==
              _selectedType!.toLowerCase();

      final matchesRecipient =
          _selectedRecipientType == null ||
          notification.recipientType.toLowerCase() ==
              _selectedRecipientType!.toLowerCase();

      final matchesStatus =
          _selectedStatus == null ||
          notification.status.toLowerCase() ==
              _selectedStatus!.toLowerCase();

      final matchesPriority =
          _selectedPriority == null ||
          notification.priority.toLowerCase() ==
              _selectedPriority!.toLowerCase();

      return matchesSearch &&
          matchesType &&
          matchesRecipient &&
          matchesStatus &&
          matchesPriority;
    }).toList();

    state = AsyncData(filtered);
  }
}