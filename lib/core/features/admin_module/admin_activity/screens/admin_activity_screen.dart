import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_empty_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_error_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_loading_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_page_header.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_search_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_section_header.dart';

import '../models/admin_activity_model.dart';
import '../models/audit_log_model.dart';
import '../providers/admin_activity_provider.dart';
import '../widgets/admin_activity_card.dart';
import '../widgets/audit_log_card.dart';

class AdminActivityScreen extends ConsumerStatefulWidget {
  const AdminActivityScreen({super.key});

  @override
  ConsumerState<AdminActivityScreen> createState() =>
      _AdminActivityScreenState();
}

class _AdminActivityScreenState
    extends ConsumerState<AdminActivityScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final activityState = ref.watch(adminActivityProvider);
    final auditState = ref.watch(adminAuditLogProvider);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Activity',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 11,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: _selectedTab == 0
                ? _buildActivityTab(activityState)
                : _buildAuditLogTab(auditState),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'Activities',
              icon: Icons.timeline_rounded,
              selected: _selectedTab == 0,
              onTap: () {
                setState(() => _selectedTab = 0);
              },
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'Audit Logs',
              icon: Icons.fact_check_outlined,
              selected: _selectedTab == 1,
              onTap: () {
                setState(() => _selectedTab = 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(
    AsyncValue<List<AdminActivityModel>> state,
  ) {
    return state.when(
      loading: () => const AdminLoadingState(),
      error: (error, stackTrace) => AdminErrorState(
        message: error.toString(),
      ),
      data: (_) {
        final notifier = ref.read(adminActivityProvider.notifier);
        final activities = notifier.filteredActivities;

        return RefreshIndicator(
          onRefresh: () async {
            await notifier.refresh();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const AdminPageHeader(
                title: 'Admin Activity',
                subtitle:
                    'Monitor actions performed across LawLink360.',
              ),
              const SizedBox(height: 16),
              _buildActivitySummary(notifier),
              const SizedBox(height: 18),
              AdminSearchBar(
                hintText: 'Search activities...',
                onChanged: (value) {
                  ref
                      .read(adminActivityProvider.notifier)
                      .search(value);
                },
              ),
              const SizedBox(height: 18),
              AdminSectionHeader(
                title: 'Recent Activities',
                trailing: Text(
                  '${activities.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC9A227),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (activities.isEmpty)
                const AdminEmptyState(
                  title: 'No Activities Found',
                  message:
                      'There are no activities matching your search.',
                  icon: Icons.timeline_rounded,
                )
              else
                ...activities.map(
                  (activity) => AdminActivityCard(
                    activity: activity,
                    onTap: () {
                      _showActivityDetails(activity);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAuditLogTab(
    AsyncValue<List<AuditLogModel>> state,
  ) {
    return state.when(
      loading: () => const AdminLoadingState(),
      error: (error, stackTrace) => AdminErrorState(
        message: error.toString(),
      ),
      data: (_) {
        final notifier = ref.read(adminAuditLogProvider.notifier);

        final logs = notifier.filteredAuditLogs;

        return RefreshIndicator(
          onRefresh: () async {
            await notifier.refresh();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              const AdminPageHeader(
                title: 'Audit Logs',
                subtitle:
                    'Track important changes and administrative events.',
              ),
              const SizedBox(height: 16),
              _buildAuditSummary(notifier),
              const SizedBox(height: 18),
              AdminSearchBar(
                hintText: 'Search audit logs...',
                onChanged: (value) {
                  ref
                      .read(adminAuditLogProvider.notifier)
                      .search(value);
                },
              ),
              const SizedBox(height: 18),
              AdminSectionHeader(
                title: 'Recent Audit Logs',
                trailing: Text(
                  '${logs.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC9A227),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (logs.isEmpty)
                const AdminEmptyState(
                  title: 'No Audit Logs Found',
                  message:
                      'There are no audit logs matching your search.',
                  icon: Icons.fact_check_outlined,
                )
              else
                ...logs.map(
                  (log) => AuditLogCard(
                    log: log,
                    onTap: () {
                      _showAuditLogDetails(log);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivitySummary(AdminActivityNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Total',
            value: '${notifier.totalActivities}',
            icon: Icons.timeline_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Today',
            value: '${notifier.todayActivities}',
            icon: Icons.today_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Auth',
            value: '${notifier.authenticationActivities}',
            icon: Icons.login_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildAuditSummary(AdminAuditLogNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Total',
            value: '${notifier.totalAuditLogs}',
            icon: Icons.fact_check_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Status',
            value: '${notifier.statusChanges}',
            icon: Icons.swap_vert_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Auth',
            value: '${notifier.authenticationLogs}',
            icon: Icons.login_rounded,
          ),
        ),
      ],
    );
  }

  void _showActivityDetails(AdminActivityModel activity) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.action,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  activity.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Category',
                  value: activity.category,
                ),
                _DetailRow(
                  label: 'Admin',
                  value: activity.adminName,
                ),
                if (activity.adminEmail != null)
                  _DetailRow(
                    label: 'Email',
                    value: activity.adminEmail!,
                  ),
                if (activity.targetName != null)
                  _DetailRow(
                    label: 'Target',
                    value: activity.targetName!,
                  ),
                if (activity.targetType != null)
                  _DetailRow(
                    label: 'Target Type',
                    value: activity.targetType!,
                  ),
                if (activity.ipAddress != null)
                  _DetailRow(
                    label: 'IP Address',
                    value: activity.ipAddress!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAuditLogDetails(AuditLogModel log) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.action,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17233C),
                  ),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Category',
                  value: log.category,
                ),
                _DetailRow(
                  label: 'Actor',
                  value: log.actorName,
                ),
                if (log.actorEmail != null)
                  _DetailRow(
                    label: 'Email',
                    value: log.actorEmail!,
                  ),
                if (log.targetName != null)
                  _DetailRow(
                    label: 'Target',
                    value: log.targetName!,
                  ),
                if (log.oldValue != null)
                  _DetailRow(
                    label: 'Old Value',
                    value: log.oldValue!,
                  ),
                if (log.newValue != null)
                  _DetailRow(
                    label: 'New Value',
                    value: log.newValue!,
                  ),
                if (log.ipAddress != null)
                  _DetailRow(
                    label: 'IP Address',
                    value: log.ipAddress!,
                  ),
              ],
            ),
          ),
        );
      },
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF17233C)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected
                    ? Colors.white
                    : const Color(0xFF17233C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFFC9A227),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17233C),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF17233C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}