import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/admin_notifications_provider.dart';
import '../widgets/admin_notification_card.dart';
import '../widgets/notification_campaign_card.dart';

class AdminNotificationHistoryScreen extends ConsumerStatefulWidget {
  const AdminNotificationHistoryScreen({super.key});

  @override
  ConsumerState<AdminNotificationHistoryScreen> createState() =>
      _AdminNotificationHistoryScreenState();
}

class _AdminNotificationHistoryScreenState
    extends ConsumerState<AdminNotificationHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedTab = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<dynamic> _filterNotifications(
    List notifications,
  ) {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return notifications
          .where(
            (notification) =>
                notification.status.toLowerCase() == 'sent',
          )
          .toList();
    }

    return notifications.where((notification) {
      final isSent =
          notification.status.toLowerCase() == 'sent';

      if (!isSent) {
        return false;
      }

      return notification.title.toLowerCase().contains(query) ||
          notification.message.toLowerCase().contains(query) ||
          notification.type.toLowerCase().contains(query) ||
          notification.recipientType
              .toLowerCase()
              .contains(query) ||
          (notification.recipientName
                  ?.toLowerCase()
                  .contains(query) ??
              false) ||
          (notification.recipientEmail
                  ?.toLowerCase()
                  .contains(query) ??
              false);
    }).toList();
  }

  List<dynamic> _filterCampaigns(
    List campaigns,
  ) {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return campaigns
          .where(
            (campaign) =>
                campaign.status.toLowerCase() == 'sent',
          )
          .toList();
    }

    return campaigns.where((campaign) {
      final isSent =
          campaign.status.toLowerCase() == 'sent';

      if (!isSent) {
        return false;
      }

      return campaign.name.toLowerCase().contains(query) ||
          campaign.title.toLowerCase().contains(query) ||
          campaign.message.toLowerCase().contains(query) ||
          campaign.type.toLowerCase().contains(query) ||
          campaign.recipientType
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotificationsProvider);
    final notifier = ref.read(
      adminNotificationsProvider.notifier,
    );

    final allNotifications =
        state.valueOrNull ?? <dynamic>[];

    final allCampaigns = notifier.campaigns;

    final sentNotifications =
        allNotifications.where(
      (notification) =>
          notification.status.toLowerCase() == 'sent',
    );

    final sentCampaigns = allCampaigns.where(
      (campaign) =>
          campaign.status.toLowerCase() == 'sent',
    );

    final filteredNotifications =
        _filterNotifications(allNotifications);

    final filteredCampaigns =
        _filterCampaigns(allCampaigns);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification History'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              ref
                  .read(adminNotificationsProvider.notifier)
                  .refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return notifier.refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(
                sentNotifications.length,
                sentCampaigns.length,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(),
            ),
            if (state.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state.hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildErrorState(
                  state.error.toString(),
                ),
              )
            else if (_selectedTab == 0)
              _buildNotificationHistory(
                filteredNotifications,
              )
            else
              _buildCampaignHistory(
                filteredCampaigns,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    int notificationCount,
    int campaignCount,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification History',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Review previously sent notifications and campaigns.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HistoryStatCard(
                  title: 'Sent Notifications',
                  value: notificationCount.toString(),
                  icon: Icons.notifications_active_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _HistoryStatCard(
                  title: 'Sent Campaigns',
                  value: campaignCount.toString(),
                  icon: Icons.campaign_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        12,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search history...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        12,
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: _HistoryTabButton(
                label: 'Notifications',
                icon: Icons.notifications_outlined,
                selected: _selectedTab == 0,
                onTap: () {
                  setState(() {
                    _selectedTab = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: _HistoryTabButton(
                label: 'Campaigns',
                icon: Icons.campaign_outlined,
                selected: _selectedTab == 1,
                onTap: () {
                  setState(() {
                    _selectedTab = 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverList _buildNotificationHistory(
    List notifications,
  ) {
    if (notifications.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          _buildEmptyState(
            icon: Icons.history_outlined,
            title: 'No notification history',
            message:
                'No sent notifications match your search.',
          ),
        ]),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final notification = notifications[index];

          return Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 4 : 0,
              16,
              index == notifications.length - 1 ? 32 : 0,
            ),
            child: AdminNotificationCard(
              notification: notification,
              onTap: () {
                _showNotificationDetails(
                  notification,
                );
              },
              onMarkRead: () {
                ref
                    .read(
                      adminNotificationsProvider.notifier,
                    )
                    .markAsRead(notification.id);
              },
              onMarkUnread: () {
                ref
                    .read(
                      adminNotificationsProvider.notifier,
                    )
                    .markAsUnread(notification.id);
              },
            ),
          );
        },
        childCount: notifications.length,
      ),
    );
  }

  SliverList _buildCampaignHistory(
    List campaigns,
  ) {
    if (campaigns.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          _buildEmptyState(
            icon: Icons.campaign_outlined,
            title: 'No campaign history',
            message:
                'No sent campaigns match your search.',
          ),
        ]),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final campaign = campaigns[index];

          return Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              index == 0 ? 4 : 0,
              16,
              index == campaigns.length - 1 ? 32 : 0,
            ),
            child: NotificationCampaignCard(
              campaign: campaign,
              onTap: () {
                _showCampaignDetails(campaign);
              },
            ),
          );
        },
        childCount: campaigns.length,
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        70,
        24,
        70,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            const Text(
              'Unable to load history',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref
                    .read(
                      adminNotificationsProvider.notifier,
                    )
                    .refresh();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetails(
    dynamic notification,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            28,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notification Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _DetailRow(
                  label: 'Type',
                  value: notification.type,
                ),
                _DetailRow(
                  label: 'Recipient',
                  value: notification.recipientName ??
                      notification.recipientType,
                ),
                _DetailRow(
                  label: 'Email',
                  value:
                      notification.recipientEmail ?? 'N/A',
                ),
                _DetailRow(
                  label: 'Priority',
                  value: notification.priority,
                ),
                _DetailRow(
                  label: 'Status',
                  value: notification.status,
                ),
                if (notification.sentAt != null)
                  _DetailRow(
                    label: 'Sent At',
                    value: _formatDateTime(
                      notification.sentAt,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCampaignDetails(
    dynamic campaign,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            28,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Campaign Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  campaign.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  campaign.title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  campaign.message,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _DetailRow(
                  label: 'Type',
                  value: campaign.type,
                ),
                _DetailRow(
                  label: 'Recipients',
                  value:
                      '${campaign.recipientCount} (${campaign.recipientType})',
                ),
                _DetailRow(
                  label: 'Priority',
                  value: campaign.priority,
                ),
                _DetailRow(
                  label: 'Status',
                  value: campaign.status,
                ),
                _DetailRow(
                  label: 'Created By',
                  value: campaign.createdBy,
                ),
                if (campaign.sentAt != null)
                  _DetailRow(
                    label: 'Sent At',
                    value: _formatDateTime(
                      campaign.sentAt,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime date) {
    final hour =
        date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute =
        date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} '
        '$hour:$minute $period';
  }
}

class _HistoryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _HistoryStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryTabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _HistoryTabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade700;

    return Material(
      color: selected
          ? Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.12)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: color,
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
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