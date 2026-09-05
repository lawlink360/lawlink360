import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/admin_navigation.dart';
import '../../widgets/admin_drawer.dart';
import '../../widgets/admin_empty_state.dart';
import '../../widgets/admin_error_state.dart';
import '../../widgets/admin_loading_state.dart';
import '../../widgets/admin_page_header.dart';
import '../../widgets/admin_search_bar.dart';
import '../models/admin_report_model.dart';
import '../providers/admin_reports_provider.dart';
import '../widgets/admin_report_card.dart';
import '../widgets/report_filter_sheet.dart';
import 'admin_report_details_screen.dart';

class AdminReportsScreen extends ConsumerStatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  ConsumerState<AdminReportsScreen> createState() =>
      _AdminReportsScreenState();
}

class _AdminReportsScreenState
    extends ConsumerState<AdminReportsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportsState = ref.watch(adminReportsProvider);
    final notifier = ref.read(adminReportsProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      drawer: AdminDrawer(
        selectedIndex: 9,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17233C),
        elevation: 0,
      ),
      body: reportsState.when(
        loading: () => const AdminLoadingState(),
        error: (error, stackTrace) => Scaffold(
          backgroundColor: Colors.white,
          body: AdminErrorState(
            message: error.toString(),
          ),
        ),
        data: (_) {
          final reports = notifier.filteredReports;

          return RefreshIndicator(
            onRefresh: () {
              return notifier.refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: AdminPageHeader(
                      title: 'Reports & Complaints',
                      subtitle:
                          'Review and manage reports submitted by users.',
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _SummarySection(
                      total: notifier.totalReports,
                      pending: notifier.pendingReports,
                      underReview:
                          notifier.underReviewReports,
                      investigating:
                          notifier.investigatingReports,
                      resolved: notifier.resolvedReports,
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: AdminSearchBar(
                            controller:
                                _searchController,
                            hintText:
                                'Search reports...',
                            onChanged: (value) {
                              notifier.search(value);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        _FilterButton(
                          active:
                              notifier.statusFilter !=
                                      'All' ||
                                  notifier.priorityFilter !=
                                      'All' ||
                                  notifier.typeFilter !=
                                      'All',
                          onTap: () {
                            ReportFilterSheet.show(
                              context: context,
                              selectedStatus:
                                  notifier.statusFilter,
                              selectedPriority:
                                  notifier.priorityFilter,
                              selectedType:
                                  notifier.typeFilter,
                              reportTypes:
                                  notifier.reportTypes,
                              onStatusChanged:
                                  notifier.setStatusFilter,
                              onPriorityChanged:
                                  notifier.setPriorityFilter,
                              onTypeChanged:
                                  notifier.setTypeFilter,
                              onClear: () {
                                notifier.clearFilters();
                                _searchController.clear();
                                setState(() {});
                              },
                              onApply: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    18,
                    16,
                    0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'All Reports',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF17233C),
                            ),
                          ),
                        ),
                        Text(
                          '${reports.length} found',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (reports.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: AdminEmptyState(
                      title: 'No Reports Found',
                      message:
                          'No reports match your current search or filters.',
                      icon: Icons.report_off_outlined,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final report = reports[index];

                          return AdminReportCard(
                            report: report,
                            onTap: () {
                              AdminNavigation.push(
                                context,
                                AdminReportDetailsScreen(
                                  reportId: report.id,
                                ),
                              );
                            },
                            onAssign: () {
                              _assignReport(report);
                            },
                            onResolve: () {
                              _resolveReport(report);
                            },
                            onDelete: () {
                              _deleteReport(report);
                            },
                          );
                        },
                        childCount: reports.length,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _assignReport(
    AdminReportModel report,
  ) async {
    ref.read(adminReportsProvider.notifier).assignReport(
          report.id,
          'ADM-001',
          'Admin Support',
        );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Report assigned to Admin Support.',
        ),
      ),
    );
  }

  Future<void> _resolveReport(
    AdminReportModel report,
  ) async {
    ref
        .read(adminReportsProvider.notifier)
        .updateReportStatus(
          report.id,
          'Resolved',
          resolution:
              'Report reviewed and resolved by administration.',
        );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Report marked as resolved.',
        ),
      ),
    );
  }

  Future<void> _deleteReport(
    AdminReportModel report,
  ) async {
    final shouldDelete =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Report?',
          ),
          content: Text(
            'Are you sure you want to delete ${report.id}?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    ref
        .read(adminReportsProvider.notifier)
        .deleteReport(report.id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Report deleted successfully.',
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final int total;
  final int pending;
  final int underReview;
  final int investigating;
  final int resolved;

  const _SummarySection({
    required this.total,
    required this.pending,
    required this.underReview,
    required this.investigating,
    required this.resolved,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      _SummaryItem(
        title: 'Total',
        value: total.toString(),
        icon: Icons.report_outlined,
        color: const Color(0xFFC9A227),
      ),
      _SummaryItem(
        title: 'Pending',
        value: pending.toString(),
        icon: Icons.pending_actions_rounded,
        color: const Color(0xFFF59E0B),
      ),
      _SummaryItem(
        title: 'Review',
        value: underReview.toString(),
        icon: Icons.rate_review_outlined,
        color: const Color(0xFF3B82F6),
      ),
      _SummaryItem(
        title: 'Investigating',
        value: investigating.toString(),
        icon: Icons.search_rounded,
        color: const Color(0xFF8B5CF6),
      ),
      _SummaryItem(
        title: 'Resolved',
        value: resolved.toString(),
        icon: Icons.check_circle_outline_rounded,
        color: const Color(0xFF16A34A),
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = cards[index];

          return Container(
            width: 118,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    Colors.grey.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  item.icon,
                  size: 19,
                  color: item.color,
                ),
                const Spacer(),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17233C),
                  ),
                ),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _FilterButton extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;

  const _FilterButton({
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active
          ? const Color(0xFFC9A227)
              .withValues(alpha: 0.12)
          : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active
                  ? const Color(0xFFC9A227)
                  : Colors.grey
                      .withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            Icons.tune_rounded,
            color: active
                ? const Color(0xFFC9A227)
                : const Color(0xFF17233C),
          ),
        ),
      ),
    );
  }
}