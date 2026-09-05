import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/admin_navigation.dart';
import '../../widgets/admin_drawer.dart';
import '../providers/admin_notifications_provider.dart';
import '../widgets/admin_notification_card.dart';
import '../widgets/notification_campaign_card.dart';
import 'admin_create_notification_screen.dart';
import 'admin_notification_history_screen.dart';

class AdminNotificationsScreen extends ConsumerStatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  ConsumerState<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends ConsumerState<AdminNotificationsScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedTab = 0;

  String? _selectedType;
  String? _selectedRecipient;
  String? _selectedStatus;
  String? _selectedPriority;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String value) {
    ref.read(adminNotificationsProvider.notifier).search(value);
  }

  void _clearFilters() {
    _searchController.clear();

    setState(() {
      _selectedType = null;
      _selectedRecipient = null;
      _selectedStatus = null;
      _selectedPriority = null;
    });

    ref.read(adminNotificationsProvider.notifier).clearFilters();
  }

  void _showFilterSheet() {
    final notifier =
        ref.read(adminNotificationsProvider.notifier);

    String? type = _selectedType;
    String? recipient = _selectedRecipient;
    String? status = _selectedStatus;
    String? priority = _selectedPriority;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                20 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notification Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'All types',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Appointment',
                          child: Text('Appointment'),
                        ),
                        DropdownMenuItem(
                          value: 'Payment',
                          child: Text('Payment'),
                        ),
                        DropdownMenuItem(
                          value: 'Verification',
                          child: Text('Verification'),
                        ),
                        DropdownMenuItem(
                          value: 'Case',
                          child: Text('Case'),
                        ),
                        DropdownMenuItem(
                          value: 'Account',
                          child: Text('Account'),
                        ),
                        DropdownMenuItem(
                          value: 'System',
                          child: Text('System'),
                        ),
                      ],
                      onChanged: (value) {
                        setSheetState(() {
                          type = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recipient',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: recipient,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'All recipients',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'User',
                          child: Text('Users'),
                        ),
                        DropdownMenuItem(
                          value: 'Lawyer',
                          child: Text('Lawyers'),
                        ),
                        DropdownMenuItem(
                          value: 'All',
                          child: Text('All'),
                        ),
                      ],
                      onChanged: (value) {
                        setSheetState(() {
                          recipient = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'All statuses',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Sent',
                          child: Text('Sent'),
                        ),
                        DropdownMenuItem(
                          value: 'Scheduled',
                          child: Text('Scheduled'),
                        ),
                        DropdownMenuItem(
                          value: 'Draft',
                          child: Text('Draft'),
                        ),
                        DropdownMenuItem(
                          value: 'Failed',
                          child: Text('Failed'),
                        ),
                      ],
                      onChanged: (value) {
                        setSheetState(() {
                          status = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Priority',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'All priorities',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High'),
                        ),
                        DropdownMenuItem(
                          value: 'Normal',
                          child: Text('Normal'),
                        ),
                        DropdownMenuItem(
                          value: 'Low',
                          child: Text('Low'),
                        ),
                      ],
                      onChanged: (value) {
                        setSheetState(() {
                          priority = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _clearFilters();
                            },
                            child: const Text('Clear'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                _selectedType = type;
                                _selectedRecipient = recipient;
                                _selectedStatus = status;
                                _selectedPriority = priority;
                              });

                              notifier.filterByType(type);
                              notifier.filterByRecipientType(
                                recipient,
                              );
                              notifier.filterByStatus(status);
                              notifier.filterByPriority(priority);

                              Navigator.pop(context);
                            },
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteNotificationDialog(String notificationId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Notification'),
          content: const Text(
            'Are you sure you want to delete this notification?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                ref
                    .read(adminNotificationsProvider.notifier)
                    .deleteNotification(notificationId);

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification deleted'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showCampaignActionMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationsState = ref.watch(
      adminNotificationsProvider,
    );

    final notifier = ref.read(
      adminNotificationsProvider.notifier,
    );

    final notifications = notificationsState.valueOrNull ?? [];
    final campaigns = notifier.campaigns;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            tooltip: 'History',
            onPressed: () {
              AdminNavigation.push(
                context,
                const AdminNotificationHistoryScreen(),
              );
            },
            icon: const Icon(Icons.history_outlined),
          ),
          IconButton(
            tooltip: 'Create notification',
            onPressed: () {
              AdminNavigation.push(
                context,
                const AdminCreateNotificationScreen(),
              );
            },
            icon: const Icon(Icons.add_alert_outlined),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 7,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AdminNavigation.push(
            context,
            const AdminCreateNotificationScreen(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create'),
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
                notifier,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSearchAndFilters(),
            ),
            SliverToBoxAdapter(
              child: _buildTabs(),
            ),
            if (notificationsState.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (notificationsState.hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildErrorState(
                  notificationsState.error.toString(),
                ),
              )
            else if (_selectedTab == 0)
              _buildNotificationList(notifications)
            else
              _buildCampaignList(campaigns),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    dynamic notifier,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Manage notifications, campaigns and delivery activity.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 104,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _StatCard(
                  title: 'Total',
                  value: notifier.totalCount.toString(),
                  icon: Icons.notifications_outlined,
                ),
                _StatCard(
                  title: 'Unread',
                  value: notifier.unreadCount.toString(),
                  icon: Icons.mark_email_unread_outlined,
                ),
                _StatCard(
                  title: 'Scheduled',
                  value: notifier.pendingCount.toString(),
                  icon: Icons.schedule_outlined,
                ),
                _StatCard(
                  title: 'High Priority',
                  value: notifier.highPriorityCount.toString(),
                  icon: Icons.priority_high_outlined,
                ),
                _StatCard(
                  title: 'Campaigns',
                  value: notifier.campaignCount.toString(),
                  icon: Icons.campaign_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    final hasFilters =
        _selectedType != null ||
        _selectedRecipient != null ||
        _selectedStatus != null ||
        _selectedPriority != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search notifications...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _search('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              IconButton.filledTonal(
                tooltip: 'Filters',
                onPressed: _showFilterSheet,
                icon: const Icon(Icons.filter_list_outlined),
              ),
              if (hasFilters)
                Positioned(
                  right: 6,
                  top: 5,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: _TabButton(
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
              child: _TabButton(
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

  SliverList _buildNotificationList(
    List notifications,
  ) {
    if (notifications.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          _buildEmptyState(
            icon: Icons.notifications_none_outlined,
            title: 'No notifications found',
            message:
                'Try changing your search or filter criteria.',
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
              index == notifications.length - 1 ? 100 : 0,
            ),
            child: AdminNotificationCard(
              notification: notification,
              onMarkRead: () {
                ref
                    .read(adminNotificationsProvider.notifier)
                    .markAsRead(notification.id);
              },
              onMarkUnread: () {
                ref
                    .read(adminNotificationsProvider.notifier)
                    .markAsUnread(notification.id);
              },
              onDelete: () {
                _showDeleteNotificationDialog(notification.id);
              },
              onTap: () {
                _showNotificationDetails(notification);
              },
            ),
          );
        },
        childCount: notifications.length,
      ),
    );
  }

  SliverList _buildCampaignList(
    List campaigns,
  ) {
    if (campaigns.isEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate([
          _buildEmptyState(
            icon: Icons.campaign_outlined,
            title: 'No campaigns found',
            message: 'Create your first notification campaign.',
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
              index == campaigns.length - 1 ? 100 : 0,
            ),
            child: NotificationCampaignCard(
              campaign: campaign,
              onTap: () {
                _showCampaignDetails(campaign);
              },
              onSend: () {
                ref
                    .read(adminNotificationsProvider.notifier)
                    .updateCampaignStatus(
                      campaign.id,
                      'Sent',
                    );

                _showCampaignActionMessage(
                  'Campaign marked as sent.',
                );
              },
              onCancel: () {
                ref
                    .read(adminNotificationsProvider.notifier)
                    .updateCampaignStatus(
                      campaign.id,
                      'Cancelled',
                    );

                _showCampaignActionMessage(
                  'Campaign cancelled.',
                );
              },
              onDelete: () {
                _showCampaignActionMessage(
                  'Campaign deletion will be handled by the notification service.',
                );
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
      padding: const EdgeInsets.fromLTRB(24, 70, 24, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              'Unable to load notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref
                    .read(adminNotificationsProvider.notifier)
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
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
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
                  value: notification.recipientEmail ?? 'N/A',
                ),
                _DetailRow(
                  label: 'Priority',
                  value: notification.priority,
                ),
                _DetailRow(
                  label: 'Status',
                  value: notification.status,
                ),
                _DetailRow(
                  label: 'Read',
                  value: notification.isRead ? 'Yes' : 'No',
                ),
                if (notification.sentAt != null)
                  _DetailRow(
                    label: 'Sent',
                    value: _formatDateTime(
                      notification.sentAt,
                    ),
                  ),
                if (notification.scheduledAt != null)
                  _DetailRow(
                    label: 'Scheduled',
                    value: _formatDateTime(
                      notification.scheduledAt,
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
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  campaign.title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
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
                if (campaign.scheduledAt != null)
                  _DetailRow(
                    label: 'Scheduled',
                    value: _formatDateTime(
                      campaign.scheduledAt,
                    ),
                  ),
                if (campaign.sentAt != null)
                  _DetailRow(
                    label: 'Sent',
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
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} '
        '$hour:$minute $period';
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      margin: const EdgeInsets.only(right: 10),
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
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
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
        crossAxisAlignment: CrossAxisAlignment.start,
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