import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/admin_navigation.dart';
import '../../widgets/admin_drawer.dart';
import '../../widgets/admin_empty_state.dart';
import '../../widgets/admin_error_state.dart';
import '../../widgets/admin_loading_state.dart';
import '../../widgets/admin_page_header.dart';
import '../../widgets/admin_search_bar.dart';
import '../models/complaint_model.dart';
import '../providers/admin_reports_provider.dart';
import '../widgets/complaint_card.dart';
import 'admin_report_details_screen.dart';

class AdminComplaintsScreen extends ConsumerStatefulWidget {
  const AdminComplaintsScreen({super.key});

  @override
  ConsumerState<AdminComplaintsScreen> createState() =>
      _AdminComplaintsScreenState();
}

class _AdminComplaintsScreenState
    extends ConsumerState<AdminComplaintsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final complaintsState =
        ref.watch(adminComplaintsProvider);
    final notifier =
        ref.read(adminComplaintsProvider.notifier);

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
          'Complaints',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF17233C),
        elevation: 0,
      ),
      body: complaintsState.when(
        loading: () => const AdminLoadingState(),
        error: (error, stackTrace) => AdminErrorState(
          message: error.toString(),
        ),
        data: (_) {
          final complaints =
              notifier.filteredComplaints;

          return RefreshIndicator(
            onRefresh: () {
              return notifier.refresh();
            },
            child: CustomScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(),
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
                      title: 'User Complaints',
                      subtitle:
                          'Review and manage complaints submitted to LawLink360.',
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
                    child: _ComplaintSummary(
                      total:
                          notifier.totalComplaints,
                      pending:
                          notifier.pendingComplaints,
                      underReview:
                          notifier.underReviewComplaints,
                      investigating:
                          notifier.investigatingComplaints,
                      resolved:
                          notifier.resolvedComplaints,
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
                                'Search complaints...',
                            onChanged: (value) {
                              notifier.search(value);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        _ComplaintFilterButton(
                          active:
                              notifier.statusFilter !=
                                      'All' ||
                                  notifier.priorityFilter !=
                                      'All' ||
                                  notifier.categoryFilter !=
                                      'All',
                          onTap: () {
                            _showComplaintFilters(
                              context,
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
                            'All Complaints',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF17233C),
                            ),
                          ),
                        ),
                        Text(
                          '${complaints.length} found',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (complaints.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: AdminEmptyState(
                      title:
                          'No Complaints Found',
                      message:
                          'No complaints match your current search or filters.',
                      icon:
                          Icons.feedback_outlined,
                    ),
                  )
                else
                  SliverPadding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      24,
                    ),
                    sliver: SliverList(
                      delegate:
                          SliverChildBuilderDelegate(
                        (context, index) {
                          final complaint =
                              complaints[index];

                          return ComplaintCard(
                            complaint: complaint,
                            onTap: () {
                              AdminNavigation.push(
                                context,
                                AdminReportDetailsScreen(
                                  complaintId:
                                      complaint.id,
                                ),
                              );
                            },
                            onAssign: () {
                              _assignComplaint(
                                complaint,
                              );
                            },
                            onResolve: () {
                              _resolveComplaint(
                                complaint,
                              );
                            },
                            onDelete: () {
                              _deleteComplaint(
                                complaint,
                              );
                            },
                          );
                        },
                        childCount:
                            complaints.length,
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

  void _showComplaintFilters(
    BuildContext context,
  ) {
    final notifier =
        ref.read(adminComplaintsProvider.notifier);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _ComplaintFilterSheet(
          selectedStatus:
              notifier.statusFilter,
          selectedPriority:
              notifier.priorityFilter,
          selectedCategory:
              notifier.categoryFilter,
          categories:
              notifier.complaintCategories,
          onApply: (
            status,
            priority,
            category,
          ) {
            notifier.setStatusFilter(status);
            notifier.setPriorityFilter(priority);
            notifier.setCategoryFilter(category);

            setState(() {});

            Navigator.pop(sheetContext);
          },
          onClear: () {
            notifier.clearFilters();
            _searchController.clear();

            setState(() {});

            Navigator.pop(sheetContext);
          },
        );
      },
    );
  }

  void _assignComplaint(
    ComplaintModel complaint,
  ) {
    ref
        .read(adminComplaintsProvider.notifier)
        .assignComplaint(
          complaint.id,
          'ADM-001',
          'Admin Support',
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Complaint assigned to Admin Support.',
        ),
      ),
    );
  }

  void _resolveComplaint(
    ComplaintModel complaint,
  ) {
    ref
        .read(adminComplaintsProvider.notifier)
        .updateComplaintStatus(
          complaint.id,
          'Resolved',
          resolution:
              'Complaint reviewed and resolved by administration.',
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Complaint marked as resolved.',
        ),
      ),
    );
  }

  Future<void> _deleteComplaint(
    ComplaintModel complaint,
  ) async {
    final shouldDelete =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Complaint?',
          ),
          content: Text(
            'Are you sure you want to delete ${complaint.id}?',
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
        .read(adminComplaintsProvider.notifier)
        .deleteComplaint(complaint.id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Complaint deleted successfully.',
        ),
      ),
    );
  }
}

class _ComplaintSummary extends StatelessWidget {
  final int total;
  final int pending;
  final int underReview;
  final int investigating;
  final int resolved;

  const _ComplaintSummary({
    required this.total,
    required this.pending,
    required this.underReview,
    required this.investigating,
    required this.resolved,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _ComplaintSummaryItem(
        title: 'Total',
        value: total,
        icon: Icons.feedback_outlined,
        color: const Color(0xFFC9A227),
      ),
      _ComplaintSummaryItem(
        title: 'Pending',
        value: pending,
        icon: Icons.pending_actions_rounded,
        color: const Color(0xFFF59E0B),
      ),
      _ComplaintSummaryItem(
        title: 'Review',
        value: underReview,
        icon: Icons.rate_review_outlined,
        color: const Color(0xFF3B82F6),
      ),
      _ComplaintSummaryItem(
        title: 'Investigating',
        value: investigating,
        icon: Icons.search_rounded,
        color: const Color(0xFF8B5CF6),
      ),
      _ComplaintSummaryItem(
        title: 'Resolved',
        value: resolved,
        icon: Icons.check_circle_outline_rounded,
        color: const Color(0xFF16A34A),
      ),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            width: 118,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey
                    .withValues(alpha: 0.12),
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
                  item.value.toString(),
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

class _ComplaintSummaryItem {
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const _ComplaintSummaryItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _ComplaintFilterButton
    extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;

  const _ComplaintFilterButton({
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
      borderRadius:
          BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(12),
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

class _ComplaintFilterSheet
    extends StatefulWidget {
  final String selectedStatus;
  final String selectedPriority;
  final String selectedCategory;
  final List<String> categories;
  final void Function(
    String status,
    String priority,
    String category,
  ) onApply;
  final VoidCallback onClear;

  const _ComplaintFilterSheet({
    required this.selectedStatus,
    required this.selectedPriority,
    required this.selectedCategory,
    required this.categories,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<_ComplaintFilterSheet> createState() =>
      _ComplaintFilterSheetState();
}

class _ComplaintFilterSheetState
    extends State<_ComplaintFilterSheet> {
  late String _status;
  late String _priority;
  late String _category;

  final List<String> _statuses = const [
    'All',
    'Pending',
    'Under Review',
    'Investigating',
    'Resolved',
    'Rejected',
    'Closed',
  ];

  final List<String> _priorities = const [
    'All',
    'Low',
    'Medium',
    'High',
    'Critical',
    'Urgent',
  ];

  @override
  void initState() {
    super.initState();

    _status = widget.selectedStatus;
    _priority = widget.selectedPriority;
    _category = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      ...widget.categories.where(
        (category) => category != 'All',
      ),
    ];

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Filter Complaints',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF17233C),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _section(
                'Status',
                _status,
                _statuses,
                (value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              _section(
                'Priority',
                _priority,
                _priorities,
                (value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              const SizedBox(height: 18),
              _section(
                'Category',
                _category,
                categories,
                (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onClear,
                      style:
                          OutlinedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(48),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApply(
                          _status,
                          _priority,
                          _category,
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(48),
                        backgroundColor:
                            const Color(0xFFC9A227),
                        foregroundColor:
                            Colors.white,
                        elevation: 0,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(
    String title,
    String selected,
    List<String> options,
    ValueChanged<String> onSelected,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF17233C),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected =
                option == selected;

            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) =>
                  onSelected(option),
              selectedColor:
                  const Color(0xFFC9A227)
                      .withValues(alpha: 0.15),
              backgroundColor: Colors.grey
                  .withValues(alpha: 0.06),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFFC9A227)
                    : Colors.grey
                        .withValues(alpha: 0.15),
              ),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF9A7715)
                    : Colors.grey.shade700,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}