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

import '../models/audit_log_model.dart';
import '../providers/admin_activity_provider.dart';
import '../widgets/audit_log_card.dart';

class AdminAuditLogScreen extends ConsumerStatefulWidget {
  const AdminAuditLogScreen({super.key});

  @override
  ConsumerState<AdminAuditLogScreen> createState() =>
      _AdminAuditLogScreenState();
}

class _AdminAuditLogScreenState
    extends ConsumerState<AdminAuditLogScreen> {
  @override
  Widget build(BuildContext context) {
    final auditState = ref.watch(adminAuditLogProvider);

    return Scaffold(
      appBar: AdminAppBar(
  title: 'Audit Logs',
  onNotificationPressed: () {},
  onProfilePressed: () {},
),
      drawer: AdminDrawer(
        selectedIndex: 11,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: auditState.when(
        loading: () => const AdminLoadingState(),
        error: (error, stackTrace) => AdminErrorState(
          message: error.toString(),
        ),
        data: (logs) => _buildAuditLogs(logs),
      ),
    );
  }

  Widget _buildAuditLogs(List<AuditLogModel> logs) {
    final notifier = ref.read(adminAuditLogProvider.notifier);
    final filteredLogs = notifier.filteredAuditLogs;

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.refresh();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const AdminPageHeader(
            title: 'Audit Logs',
            subtitle:
                'Review important administrative changes and events.',
          ),
          const SizedBox(height: 18),
          _buildSummary(notifier),
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
            title: 'Audit History',
            trailing: Text(
              '${filteredLogs.length}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFC9A227),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (filteredLogs.isEmpty)
            const AdminEmptyState(
              title: 'No Audit Logs Found',
              message:
                  'There are no audit logs matching your search.',
              icon: Icons.fact_check_outlined,
            )
          else
            ...filteredLogs.map(
              (log) => AuditLogCard(
                log: log,
                onTap: () {
                  _showLogDetails(log);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummary(AdminAuditLogNotifier notifier) {
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

  void _showLogDetails(AuditLogModel log) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
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
                const SizedBox(height: 6),
                Text(
                  log.category,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFC9A227),
                  ),
                ),
                const SizedBox(height: 18),
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
                if (log.targetType != null)
                  _DetailRow(
                    label: 'Target Type',
                    value: log.targetType!,
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
                if (log.deviceInfo != null)
                  _DetailRow(
                    label: 'Device',
                    value: log.deviceInfo!,
                  ),
                _DetailRow(
                  label: 'Created',
                  value: _formatDate(log.createdAt),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
            ? 12
            : date.hour;

    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} • '
        '$hour:$minute $period';
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
      padding: const EdgeInsets.only(bottom: 11),
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