import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_analytics/providers/admin_analytics_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/widgets/analytics_summary_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/widgets/appointment_chart.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/widgets/lawyer_growth_chart.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/widgets/revenue_chart.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/widgets/user_growth_chart.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminAnalyticsScreen extends ConsumerStatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  ConsumerState<AdminAnalyticsScreen> createState() =>
      _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState
    extends ConsumerState<AdminAnalyticsScreen> {
  Future<void> _refreshAnalytics() async {
    ref.read(adminAnalyticsProvider.notifier).refresh();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final analyticsState = ref.watch(adminAnalyticsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      drawer: AdminDrawer(
        selectedIndex: 8,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xFF17233C),
        ),
        title: const Text(
          'Analytics',
          style: TextStyle(
            color: Color(0xFF17233C),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refreshAnalytics,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFFC9A227),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: analyticsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFC9A227),
          ),
        ),
        error: (error, stackTrace) => _AnalyticsErrorState(
          message: error.toString(),
          onRetry: _refreshAnalytics,
        ),
        data: (_) => RefreshIndicator(
          color: const Color(0xFFC9A227),
          onRefresh: _refreshAnalytics,
          child: const _AnalyticsContent(),
        ),
      ),
    );
  }
}

class _AnalyticsContent extends ConsumerWidget {
  const _AnalyticsContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminAnalyticsProvider.notifier);

    final summary = notifier.summary;
    final userData = notifier.userAnalytics;
    final lawyerData = notifier.lawyerAnalytics;
    final appointmentData = notifier.appointmentAnalytics;
    final revenueData = notifier.revenueAnalytics;

    final totalNewUsers = userData.fold<int>(
  0,
  (sum, item) => sum + item.newUsers,
);

final totalNewLawyers = lawyerData.fold<int>(
  0,
  (sum, item) => sum + item.newLawyers,
);

final netRevenue = revenueData.fold<double>(
  0,
  (sum, item) => sum + item.netRevenue,
);

final completedAppointments = appointmentData.fold<int>(
  0,
  (sum, item) => sum + item.completed,
);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final horizontalPadding = isWide ? 24.0 : 16.0;

        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            20,
            horizontalPadding,
            32,
          ),
          children: [
            const _AnalyticsHeader(),
            const SizedBox(height: 20),

            _PeriodSelector(
              selectedPeriod: notifier.selectedPeriod,
              onChanged: (period) {
                notifier.selectPeriod(period);
              },
            ),

            const SizedBox(height: 20),

            _buildSectionTitle(
              context,
              title: 'Overview',
              icon: Icons.dashboard_rounded,
            ),

            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: isWide ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 1.35 : 1.05,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AnalyticsSummaryCard(
                  title: 'Total Users',
                  value: _formatNumber(summary.totalUsers),
                  subtitle: 'Registered users',
                  icon: Icons.people_alt_rounded,
                  color: const Color(0xFF3B5CCC),
                ),
                AnalyticsSummaryCard(
                  title: 'Total Lawyers',
                  value: _formatNumber(summary.totalLawyers),
                  subtitle: 'Registered lawyers',
                  icon: Icons.gavel_rounded,
                  color: const Color(0xFFC9A227),
                ),
                AnalyticsSummaryCard(
                  title: 'Appointments',
                  value: _formatNumber(summary.totalAppointments),
                  subtitle:
                      '${summary.completedAppointments} completed',
                  icon: Icons.calendar_month_rounded,
                  color: const Color(0xFF238636),
                ),
                AnalyticsSummaryCard(
                  title: 'Active Cases',
                  value: _formatNumber(summary.activeCases),
                  subtitle:
                      '${summary.totalCases} total cases',
                  icon: Icons.folder_open_rounded,
                  color: const Color(0xFF8B5CF6),
                ),
                AnalyticsSummaryCard(
                  title: 'Verifications',
                  value: _formatNumber(summary.totalVerifications),
                  subtitle:
                      '${summary.approvedVerifications} approved',
                  icon: Icons.verified_user_rounded,
                  color: const Color(0xFF0891B2),
                ),
                AnalyticsSummaryCard(
                  title: 'Revenue',
                  value: _formatCurrency(summary.totalRevenue),
                  subtitle: 'Total revenue',
                  icon: Icons.payments_rounded,
                  color: const Color(0xFF16A34A),
                ),
                AnalyticsSummaryCard(
                  title: 'Monthly Revenue',
                  value: _formatCurrency(summary.monthlyRevenue),
                  subtitle: 'Current month',
                  icon: Icons.trending_up_rounded,
                  color: const Color(0xFFEA580C),
                ),
                AnalyticsSummaryCard(
                  title: 'Avg. Appointment',
                  value: _formatCurrency(
                    summary.averageAppointmentValue,
                  ),
                  subtitle: 'Average value',
                  icon: Icons.analytics_rounded,
                  color: const Color(0xFFDB2777),
                ),
              ],
            ),

            const SizedBox(height: 28),

            _buildSectionTitle(
              context,
              title: 'User Growth',
              icon: Icons.people_alt_rounded,
            ),

            const SizedBox(height: 12),

            _AnalyticsChartCard(
              child: UserGrowthChart(
                data: userData,
                height: 240,
              ),
            ),

            const SizedBox(height: 28),

            _buildSectionTitle(
              context,
              title: 'Lawyer Growth',
              icon: Icons.gavel_rounded,
            ),

            const SizedBox(height: 12),

            _AnalyticsChartCard(
              child: LawyerGrowthChart(
                data: lawyerData,
                height: 240,
              ),
            ),

            const SizedBox(height: 28),

            _buildSectionTitle(
              context,
              title: 'Appointments',
              icon: Icons.calendar_month_rounded,
            ),

            const SizedBox(height: 12),

            _AnalyticsChartCard(
              child: AppointmentChart(
                data: appointmentData,
                height: 250,
              ),
            ),

            const SizedBox(height: 28),

            _buildSectionTitle(
              context,
              title: 'Revenue',
              icon: Icons.payments_rounded,
            ),

            const SizedBox(height: 12),

            _AnalyticsChartCard(
              child: RevenueChart(
                data: revenueData,
                height: 250,
              ),
            ),

            const SizedBox(height: 28),

            _buildSectionTitle(
              context,
              title: 'Performance',
              icon: Icons.insights_rounded,
            ),

            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: isWide ? 3 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 1.8 : 1.35,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AnalyticsSummaryCard(
                  title: 'Completion Rate',
                  value: '${notifier.appointmentCompletionRate.toStringAsFixed(1)}%',
                  subtitle: 'Appointments completed',
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF238636),
                  percentage: notifier.appointmentCompletionRate,
                ),
                AnalyticsSummaryCard(
                  title: 'Verification Rate',
                  value: '${notifier.verificationApprovalRate.toStringAsFixed(1)}%',
                  subtitle: 'Requests approved',
                  icon: Icons.verified_rounded,
                  color: const Color(0xFF0891B2),
                  percentage: notifier.verificationApprovalRate,
                ),
                AnalyticsSummaryCard(
                  title: 'Net Revenue',
                  value: _formatCurrency(
                    netRevenue,
                  ),
                  subtitle: 'After refunds',
                  icon: Icons.account_balance_wallet_rounded,
                  color: const Color(0xFFC9A227),
                ),
                AnalyticsSummaryCard(
                  title: 'New Users',
                  value: _formatNumber(
                    totalNewUsers,
                  ),
                  subtitle: 'Selected period',
                  icon: Icons.person_add_alt_1_rounded,
                  color: const Color(0xFF3B5CCC),
                ),
                AnalyticsSummaryCard(
                  title: 'New Lawyers',
                  value: _formatNumber(
                    totalNewLawyers,
                  ),
                  subtitle: 'Selected period',
                  icon: Icons.person_add_rounded,
                  color: const Color(0xFF8B5CF6),
                ),
                AnalyticsSummaryCard(
                  title: 'Completed',
                  value: _formatNumber(
                    completedAppointments,
                  ),
                  subtitle: 'Selected period',
                  icon: Icons.task_alt_rounded,
                  color: const Color(0xFF16A34A),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _LastUpdatedCard(
              lastUpdated: summary.lastUpdated,
            ),
          ],
        );
      },
    );
  }

  static Widget _buildSectionTitle(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFC9A227).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.insights_rounded,
            size: 20,
            color: Color(0xFFC9A227),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF17233C),
          ),
        ),
      ],
    );
  }

  static String _formatNumber(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toString();
  }

  static String _formatCurrency(double value) {
    if (value >= 1000000) {
      return 'Rs ${(value / 1000000).toStringAsFixed(2)}M';
    }

    if (value >= 1000) {
      return 'Rs ${(value / 1000).toStringAsFixed(1)}K';
    }

    return 'Rs ${value.toStringAsFixed(0)}';
  }
}

class _AnalyticsHeader extends StatelessWidget {
  const _AnalyticsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF17233C),
            Color(0xFF243452),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17233C).withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFC9A227).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.analytics_rounded,
              color: Color(0xFFC9A227),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Analytics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Monitor LawLink360 performance and growth',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
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

class _PeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String> onChanged;

  const _PeriodSelector({
    required this.selectedPeriod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const periods = [
      '1 Month',
      '3 Months',
      '6 Months',
      '1 Year',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E5EA),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.date_range_rounded,
            color: Color(0xFFC9A227),
            size: 21,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Analytics Period',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF17233C),
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedPeriod,
              borderRadius: BorderRadius.circular(12),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFFC9A227),
              ),
              items: periods.map(
                (period) {
                  return DropdownMenuItem<String>(
                    value: period,
                    child: Text(
                      period,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF17233C),
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsChartCard extends StatelessWidget {
  final Widget child;

  const _AnalyticsChartCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12,
        16,
        12,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7E9ED),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _LastUpdatedCard extends StatelessWidget {
  final DateTime lastUpdated;

  const _LastUpdatedCard({
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final date =
        '${lastUpdated.day.toString().padLeft(2, '0')}/'
        '${lastUpdated.month.toString().padLeft(2, '0')}/'
        '${lastUpdated.year}';

    final time =
        '${lastUpdated.hour.toString().padLeft(2, '0')}:'
        '${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFC9A227).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC9A227).withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.update_rounded,
            size: 19,
            color: Color(0xFFC9A227),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Last updated: $date at $time',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF5F6673),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AnalyticsErrorState({
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
              size: 52,
              color: Color(0xFFD64545),
            ),
            const SizedBox(height: 12),
            const Text(
              'Unable to load analytics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17233C),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17233C),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}