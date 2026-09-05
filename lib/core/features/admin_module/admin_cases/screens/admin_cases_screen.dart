import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/admin_drawer.dart';
import '../models/case_status_model.dart';
import '../providers/admin_cases_provider.dart';
import '../widgets/admin_case_card.dart';
import '../widgets/case_filter_sheet.dart';
import 'admin_case_details_screen.dart';

class AdminCasesScreen extends ConsumerStatefulWidget {
  const AdminCasesScreen({super.key});

  @override
  ConsumerState<AdminCasesScreen> createState() =>
      _AdminCasesScreenState();
}

class _AdminCasesScreenState extends ConsumerState<AdminCasesScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final casesState = ref.watch(adminCasesProvider);
    final notifier = ref.read(adminCasesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Cases'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              notifier.refresh();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 4,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: casesState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _ErrorView(
          onRetry: () {
            notifier.refresh();
          },
        ),
        data: (cases) {
          return RefreshIndicator(
            onRefresh: notifier.refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(
                    context,
                    notifier,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildStats(
                    context,
                    notifier,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildSearchAndFilter(
                    context,
                    notifier,
                  ),
                ),
                if (cases.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyCasesView(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final caseItem = cases[index];

                          return AdminCaseCard(
                            caseItem: caseItem,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AdminCaseDetailsScreen(
                                    caseId: caseItem.id,
                                  ),
                                ),
                              );
                            },
                            onActivate: () {
                              notifier.updateCaseStatus(
                                caseItem.id,
                                CaseStatusModel.active,
                              );
                            },
                            onHold: () {
                              notifier.updateCaseStatus(
                                caseItem.id,
                                CaseStatusModel.onHold,
                              );
                            },
                            onClose: () {
                              notifier.updateCaseStatus(
                                caseItem.id,
                                CaseStatusModel.closed,
                              );
                            },
                            onDismiss: () {
                              notifier.updateCaseStatus(
                                caseItem.id,
                                CaseStatusModel.dismissed,
                              );
                            },
                          );
                        },
                        childCount: cases.length,
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

  Widget _buildHeader(
    BuildContext context,
    AdminCasesNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Case Management',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Monitor and manage all cases registered on LawLink360.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(
    BuildContext context,
    AdminCasesNotifier notifier,
  ) {
    return SizedBox(
      height: 108,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _StatCard(
            title: 'Total',
            value: notifier.totalCount.toString(),
            icon: Icons.folder_copy_outlined,
          ),
          _StatCard(
            title: 'Active',
            value: notifier.activeCount.toString(),
            icon: Icons.play_circle_outline_rounded,
          ),
          _StatCard(
            title: 'Pending',
            value: notifier.pendingCount.toString(),
            icon: Icons.pending_actions_rounded,
          ),
          _StatCard(
            title: 'Closed',
            value: notifier.closedCount.toString(),
            icon: Icons.check_circle_outline_rounded,
          ),
          _StatCard(
            title: 'Pending Fees',
            value:
                'PKR ${notifier.totalPendingAmount.toStringAsFixed(0)}',
            icon: Icons.account_balance_wallet_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(
    BuildContext context,
    AdminCasesNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: notifier.search,
              decoration: InputDecoration(
                hintText: 'Search cases...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          notifier.search('');
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            tooltip: 'Filter',
            style: IconButton.styleFrom(
              backgroundColor:
                  theme.colorScheme.primary.withValues(alpha: 0.10),
            ),
            onPressed: () {
              CaseFilterSheet.show(
                context: context,
                selectedStatus: notifier.selectedStatus,
                selectedCaseType: notifier.selectedCaseType,
                onStatusChanged: notifier.filterByStatus,
                onCaseTypeChanged: notifier.filterByCaseType,
                onClear: notifier.clearFilters,
              );
            },
            icon: Icon(
              Icons.tune_rounded,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
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
    final theme = Theme.of(context);

    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCasesView extends StatelessWidget {
  const _EmptyCasesView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open_rounded,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No cases found',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your search or filters.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
            ),
            const SizedBox(height: 16),
            const Text(
              'Unable to load cases',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}