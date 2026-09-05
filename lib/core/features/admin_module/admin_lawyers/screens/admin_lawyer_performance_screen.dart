import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/providers/admin_lawyer_details_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/lawyer_performance_model.dart';

class AdminLawyerPerformanceScreen
    extends ConsumerWidget {
  final String lawyerId;

  const AdminLawyerPerformanceScreen({
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
        ref.read(
          adminLawyerDetailsProvider(lawyerId).notifier,
        );

    final performance = notifier.getPerformance();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lawyer Performance',
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
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Unable to load lawyer.\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (lawyer) {
          if (lawyer == null) {
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

          if (performance == null) {
            return const Center(
              child: Text(
                'Performance data not available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: notifier.refreshLawyer,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildLawyerHeader(
                  lawyer.name,
                  lawyer.specialization,
                  lawyer.city,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Appointments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Total',
                        value: performance
                            .totalAppointments
                            .toString(),
                        icon: Icons.calendar_month_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Completed',
                        value: performance
                            .completedAppointments
                            .toString(),
                        icon: Icons.check_circle_outline,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Cancelled',
                        value: performance
                            .cancelledAppointments
                            .toString(),
                        icon: Icons.cancel_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Completion',
                        value:
                            '${_completionRate(performance).toStringAsFixed(1)}%',
                        icon: Icons.trending_up_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Clients & Cases',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Clients',
                        value: performance
                            .totalClients
                            .toString(),
                        icon: Icons.people_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Active Cases',
                        value: performance
                            .activeCases
                            .toString(),
                        icon: Icons.folder_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _PerformanceCard(
                  title: 'Completed Cases',
                  value: performance
                      .completedCases
                      .toString(),
                  icon: Icons.task_alt_outlined,
                ),

                const SizedBox(height: 24),

                const Text(
                  'Ratings & Reviews',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Average Rating',
                        value: performance
                            .averageRating
                            .toStringAsFixed(1),
                        icon: Icons.star_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PerformanceCard(
                        title: 'Reviews',
                        value: performance
                            .totalReviews
                            .toString(),
                        icon:
                            Icons.rate_review_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Revenue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                _RevenueCard(
                  title: 'Total Revenue',
                  amount: performance.totalRevenue,
                  icon: Icons.account_balance_wallet_outlined,
                ),

                const SizedBox(height: 12),

                _RevenueCard(
                  title: 'Monthly Revenue',
                  amount: performance.monthlyRevenue,
                  icon: Icons.trending_up_outlined,
                ),

                const SizedBox(height: 24),

                _buildPerformanceSummary(
                  performance,
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLawyerHeader(
    String name,
    String specialization,
    String city,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(
              _initials(name),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialization,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  city,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary(
    LawyerPerformanceModel performance,
  ) {
    final rate = _completionRate(performance);

    String message;

    if (rate >= 90) {
      message = 'Excellent appointment completion rate.';
    } else if (rate >= 75) {
      message = 'Good appointment completion rate.';
    } else if (rate >= 50) {
      message = 'Moderate appointment completion rate.';
    } else {
      message = 'Appointment completion rate needs attention.';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.withValues(alpha: 0.08),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.insights_outlined,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Performance Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _completionRate(
    LawyerPerformanceModel performance,
  ) {
    if (performance.totalAppointments == 0) {
      return 0;
    }

    return performance.completedAppointments /
            performance.totalAppointments *
        100;
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
}

class _PerformanceCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _PerformanceCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
          ),
          const SizedBox(width: 12),
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
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
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

class _RevenueCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;

  const _RevenueCard({
    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            'Rs. ${amount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}