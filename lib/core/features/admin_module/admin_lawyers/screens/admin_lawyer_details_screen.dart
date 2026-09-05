import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/providers/admin_lawyer_details_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_status_chip.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/screens/admin_lawyer_performance_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_module.dart';

class AdminLawyerDetailsScreen
    extends ConsumerWidget {
  final String lawyerId;

  const AdminLawyerDetailsScreen({
    super.key,
    required this.lawyerId,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final lawyerState =
        ref.watch(adminLawyerDetailsProvider(lawyerId));

    final notifier =
        ref.read(adminLawyerDetailsProvider(lawyerId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lawyer Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: notifier.refreshLawyer,
            icon: const Icon(
              Icons.refresh,
            ),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: lawyerState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _buildError(
          context,
          notifier,
          error,
        ),
        data: (lawyer) {
          if (lawyer == null) {
            return _buildNotFound();
          }

          return RefreshIndicator(
            onRefresh: notifier.refreshLawyer,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileHeader(
                  context,
                  lawyer,
                ),

                const SizedBox(height: 20),

                _buildSection(
                  title: 'Account Status',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          AdminLawyerStatusChip(
                            status: lawyer.status,
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _StatusRow(
                        title: 'Verified',
                        value: lawyer.isVerified,
                      ),
                      const SizedBox(height: 12),
                      _StatusRow(
                        title: 'Approved',
                        value: lawyer.isApproved,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _buildSection(
                  title: 'Contact Information',
                  child: Column(
                    children: [
                      _DetailRow(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: lawyer.email,
                      ),
                      const SizedBox(height: 14),
                      _DetailRow(
                        icon: Icons.phone_outlined,
                        title: 'Phone',
                        value: lawyer.phone,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _buildSection(
                  title: 'Professional Information',
                  child: Column(
                    children: [
                      _DetailRow(
                        icon: Icons.gavel_outlined,
                        title: 'Specialization',
                        value: lawyer.specialization,
                      ),
                      const SizedBox(height: 14),
                      _DetailRow(
                        icon: Icons.location_on_outlined,
                        title: 'City',
                        value: lawyer.city,
                      ),
                      const SizedBox(height: 14),
                      _DetailRow(
                        icon: Icons.calendar_today_outlined,
                        title: 'Joined',
                        value: _formatDate(
                          lawyer.joinedAt,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _buildSection(
                  title: 'Performance Overview',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _MetricCard(
                              title: 'Clients',
                              value:
                                  lawyer.totalClients.toString(),
                              icon:
                                  Icons.people_outline,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MetricCard(
                              title: 'Active Cases',
                              value:
                                  lawyer.activeCases.toString(),
                              icon:
                                  Icons.folder_outlined,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _MetricCard(
                              title: 'Completed Cases',
                              value: lawyer
                                  .completedCases
                                  .toString(),
                              icon:
                                  Icons.task_alt_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MetricCard(
                              title: 'Rating',
                              value: lawyer.rating
                                  .toStringAsFixed(1),
                              icon:
                                  Icons.star_outline,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _MetricCard(
                        title: 'Total Reviews',
                        value:
                            lawyer.totalReviews.toString(),
                        icon:
                            Icons.rate_review_outlined,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      AdminNavigation.push(
                        context,
                        AdminLawyerPerformanceScreen(
                          lawyerId: lawyer.id,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.analytics_outlined,
                    ),
                    label: const Text(
                      'View Full Performance',
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                _buildActions(
                  context,
                  ref,
                  lawyer,
                  notifier,
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    dynamic lawyer,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            child: Text(
              _initials(lawyer.name),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  lawyer.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (lawyer.isVerified) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.verified,
                  size: 20,
                ),
              ],
            ],
          ),

          const SizedBox(height: 6),

          Text(
            lawyer.specialization,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            lawyer.city,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildActions(
    BuildContext context,
    WidgetRef ref,
    dynamic lawyer,
    dynamic notifier,
  ) {
    return _buildSection(
      title: 'Admin Actions',
      child: Column(
        children: [
          if (!lawyer.isApproved)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  notifier.updateApproval(true);
                },
                icon: const Icon(
                  Icons.verified_outlined,
                ),
                label: const Text(
                  'Approve Lawyer',
                ),
              ),
            ),

          if (!lawyer.isApproved)
            const SizedBox(height: 10),

          if (lawyer.status != 'active')
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  notifier.updateStatus('active');
                },
                icon: const Icon(
                  Icons.play_circle_outline,
                ),
                label: const Text(
                  'Activate Lawyer',
                ),
              ),
            ),

          if (lawyer.status != 'suspended')
            const SizedBox(height: 10),

          if (lawyer.status != 'suspended')
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  notifier.updateStatus('suspended');
                },
                icon: const Icon(
                  Icons.block_outlined,
                ),
                label: const Text(
                  'Suspend Lawyer',
                ),
              ),
            ),

          if (lawyer.status != 'inactive')
            const SizedBox(height: 10),

          if (lawyer.status != 'inactive')
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  notifier.updateStatus('inactive');
                },
                icon: const Icon(
                  Icons.pause_circle_outline,
                ),
                label: const Text(
                  'Deactivate Lawyer',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    dynamic notifier,
    Object error,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Unable to load lawyer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: notifier.loadLawyer,
              icon: const Icon(
                Icons.refresh,
              ),
              label: const Text(
                'Try Again',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return const Center(
      child: Text(
        'Lawyer not found',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first.isNotEmpty
          ? parts.first[0].toUpperCase()
          : '?';
    }

    return '${parts.first[0]}${parts.last[0]}'
        .toUpperCase();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String title;
  final bool value;

  const _StatusRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Icon(
          value
              ? Icons.check_circle
              : Icons.cancel_outlined,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          value ? 'Yes' : 'No',
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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