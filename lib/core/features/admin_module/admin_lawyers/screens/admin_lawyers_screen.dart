import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/providers/admin_lawyers_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/screens/admin_lawyer_details_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/screens/admin_lawyer_performance_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_filter_sheet.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_search_bar.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_stats_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_module.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminLawyersScreen extends ConsumerStatefulWidget {
  const AdminLawyersScreen({super.key});

  @override
  ConsumerState<AdminLawyersScreen> createState() => _AdminLawyersScreenState();
}

class _AdminLawyersScreenState extends ConsumerState<AdminLawyersScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    Future.microtask(() {
      ref.read(adminLawyersProvider.notifier).loadLawyers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lawyersNotifier = ref.read(adminLawyersProvider.notifier);

    final lawyers = ref.watch(adminLawyersProvider);

    final filteredLawyers = lawyersNotifier.filteredLawyers;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lawyers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              lawyersNotifier.refreshLawyers();
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 2,
        onItemSelected: (index) {
          // Admin navigation will be connected here.
        },
      ),
      body: RefreshIndicator(
        onRefresh: lawyersNotifier.refreshLawyers,
        child: lawyersNotifier.isLoading && lawyers.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : lawyersNotifier.hasError && lawyers.isEmpty
            ? _buildErrorState(context, lawyersNotifier)
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStats(lawyersNotifier),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: AdminLawyerSearchBar(
                          controller: _searchController,
                          onChanged: lawyersNotifier.searchLawyers,
                          onClear: () {
                            _searchController.clear();
                            lawyersNotifier.searchLawyers('');
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          _showFilters(context, lawyersNotifier);
                        },
                        tooltip: 'Filter',
                        icon: const Icon(Icons.tune),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${filteredLawyers.length} Lawyers',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_hasActiveFilters(lawyersNotifier))
                        TextButton(
                          onPressed: () {
                            _searchController.clear();

                            lawyersNotifier.clearFilters();

                            setState(() {});
                          },
                          child: const Text('Clear Filters'),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  if (filteredLawyers.isEmpty)
                    _buildEmptyState()
                  else
                    ...filteredLawyers.map((lawyer) {
                      return AdminLawyerCard(
                        lawyer: lawyer,
                        onViewDetails: () {
                          AdminNavigation.push(
                            context,
                            AdminLawyerDetailsScreen(lawyerId: lawyer.id),
                          );
                        },
                        onViewPerformance: () {
                          AdminNavigation.push(
                            context,
                            AdminLawyerPerformanceScreen(lawyerId: lawyer.id),
                          );
                        },
                        onApprove: () {
                          lawyersNotifier.updateApprovalStatus(lawyer.id, true);
                        },
                        onActivate: () {
                          lawyersNotifier.updateLawyerStatus(
                            lawyer.id,
                            'active',
                          );
                        },
                        onSuspend: () {
                          lawyersNotifier.updateLawyerStatus(
                            lawyer.id,
                            'suspended',
                          );
                        },
                        onDeactivate: () {
                          lawyersNotifier.updateLawyerStatus(
                            lawyer.id,
                            'inactive',
                          );
                        },
                      );
                    }),
                ],
              ),
      ),
    );
  }

  Widget _buildStats(AdminLawyersNotifier notifier) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminLawyerStatsCard(
                title: 'Total Lawyers',
                value: notifier.totalLawyers.toString(),
                icon: Icons.people_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AdminLawyerStatsCard(
                title: 'Active',
                value: notifier.activeLawyers.toString(),
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: AdminLawyerStatsCard(
                title: 'Pending',
                value: notifier.pendingLawyers.toString(),
                icon: Icons.pending_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AdminLawyerStatsCard(
                title: 'Suspended',
                value: notifier.suspendedLawyers.toString(),
                icon: Icons.block_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showFilters(
    BuildContext context,
    AdminLawyersNotifier notifier,
  ) async {
    await AdminLawyerFilterSheet.show(
      context: context,
      selectedStatus: notifier.selectedStatus,
      selectedSpecialization: notifier.selectedSpecialization,
      selectedCity: notifier.selectedCity,
      onStatusChanged: notifier.filterByStatus,
      onSpecializationChanged: notifier.filterBySpecialization,
      onCityChanged: notifier.filterByCity,
      onClear: () {
        notifier.clearFilters();
        _searchController.clear();
        Navigator.pop(context);
        setState(() {});
      },
    );

    if (mounted) {
      setState(() {});
    }
  }

  bool _hasActiveFilters(AdminLawyersNotifier notifier) {
    return notifier.searchQuery.isNotEmpty ||
        notifier.selectedStatus != null ||
        notifier.selectedSpecialization != null ||
        notifier.selectedCity != null;
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No lawyers found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, AdminLawyersNotifier notifier) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: Colors.red.shade400),
            const SizedBox(height: 16),
            const Text(
              'Unable to load lawyers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              notifier.error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: notifier.loadLawyers,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
