import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/providers/admin_verification_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/screen/verification_request_details_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_filter_sheet.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_request_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminVerificationScreen extends ConsumerStatefulWidget {
  const AdminVerificationScreen({
    super.key,
  });

  @override
  ConsumerState<AdminVerificationScreen> createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState
    extends ConsumerState<AdminVerificationScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verificationState = ref.watch(adminVerificationProvider);
    final notifier = ref.read(adminVerificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        centerTitle: false,
      ),
      drawer: AdminDrawer(
        selectedIndex: 5,
        onItemSelected: (index) {
          // Admin navigation will be connected centrally later.
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          notifier.refresh();
          await Future<void>.delayed(
            const Duration(milliseconds: 400),
          );
        },
        child: verificationState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => _ErrorView(
            message: error.toString(),
            onRetry: notifier.refresh,
          ),
          data: (requests) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: _StatisticsSection(
                      pending: notifier.pendingCount,
                      underReview: notifier.underReviewCount,
                      approved: notifier.approvedCount,
                      rejected: notifier.rejectedCount,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: notifier.search,
                            decoration: InputDecoration(
                              hintText: 'Search verification requests...',
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                              ),
                              suffixIcon:
                                  _searchController.text.isNotEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            _searchController.clear();
                                            notifier.search('');
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.clear_rounded,
                                          ),
                                        )
                                      : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            VerificationFilterSheet.show(
                              context: context,
                              selectedStatus: notifier.selectedStatus,
                              onStatusChanged: notifier.filterByStatus,
                              onClear: () {
                                notifier.clearFilters();
                                _searchController.clear();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            );
                          },
                          tooltip: 'Filter',
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(
                            Icons.filter_list_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Verification Requests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${requests.length}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (requests.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No verification requests found.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    sliver: SliverList.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];

                        return VerificationRequestCard(
                          request: request,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    VerificationRequestDetailsScreen(
                                  requestId: request.id,
                                ),
                              ),
                            );
                          },
                          onReview: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    VerificationRequestDetailsScreen(
                                  requestId: request.id,
                                ),
                              ),
                            );
                          },
                          onApprove: () {
                            notifier.updateStatus(
                              request.id,
                              'approved',
                              reviewerName: 'Admin',
                              notes: 'Approved by administrator.',
                            );
                          },
                          onReject: () {
                            notifier.updateStatus(
                              request.id,
                              'rejected',
                              reviewerName: 'Admin',
                              rejectionReason:
                                  'Verification request rejected by administrator.',
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StatisticsSection extends StatelessWidget {
  final int pending;
  final int underReview;
  final int approved;
  final int rejected;

  const _StatisticsSection({
    required this.pending,
    required this.underReview,
    required this.approved,
    required this.rejected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: [
        _StatCard(
          title: 'Pending',
          value: pending.toString(),
          icon: Icons.pending_actions_rounded,
        ),
        _StatCard(
          title: 'Under Review',
          value: underReview.toString(),
          icon: Icons.rate_review_outlined,
        ),
        _StatCard(
          title: 'Approved',
          value: approved.toString(),
          icon: Icons.verified_rounded,
        ),
        _StatCard(
          title: 'Rejected',
          value: rejected.toString(),
          icon: Icons.cancel_outlined,
        ),
      ],
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
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