
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_dashboard/providers/admin_dashboard_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/widgets/admin_dashboard_chart.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/widgets/admin_dashboard_section.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/widgets/admin_quick_action_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/widgets/admin_recent_activity_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/widgets/admin_stat_card.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/screens/admin_users_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/screens/admin_lawyers_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/screen/admin_verification_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/screens/admin_appointments_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_cases/screens/admin_cases_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_payments/screens/admin_payments_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_notification/screens/admin_notifications_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/screens/admin_content_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_analytics/screens/admin_analytics_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_reports/screens/admin_reports_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_activity/screens/admin_activity_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/screens/admin_settings_screen.dart';

import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_empty_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_error_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_loading_state.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_page_header.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({
    super.key,
  });

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends ConsumerState<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(adminDashboardProvider.notifier).loadDashboard();
    });
  }

  void _openScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  void _handleDrawerSelection(int index) {
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;

      case 1:
        Navigator.pop(context);
        _openScreen(const AdminUsersScreen());
        break;

      case 2:
        Navigator.pop(context);
        _openScreen(const AdminLawyersScreen());
        break;

      case 3:
        Navigator.pop(context);
        _openScreen(const AdminAppointmentsScreen());
        break;

      case 4:
        Navigator.pop(context);
        _openScreen(const AdminCasesScreen());
        break;

      case 5:
        Navigator.pop(context);
        _openScreen(const AdminVerificationScreen());
        break;

      case 6:
        Navigator.pop(context);
        _openScreen(const AdminPaymentsScreen());
        break;

      case 7:
        Navigator.pop(context);
        _openScreen(const AdminNotificationsScreen());
        break;

      case 8:
        Navigator.pop(context);
        _openScreen(const AdminAnalyticsScreen());
        break;

      case 9:
        Navigator.pop(context);
        _openScreen(const AdminReportsScreen());
        break;

      case 10:
        Navigator.pop(context);
        _openScreen(const AdminContentScreen());
        break;

      case 11:
        Navigator.pop(context);
        _openScreen(const AdminActivityScreen());
        break;

      case 12:
        Navigator.pop(context);
        _openScreen(const AdminSettingsScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminDashboardProvider);

    return Scaffold(
      drawer: AdminDrawer(
        selectedIndex: 0,
        onItemSelected: _handleDrawerSelection,
      ),
      body: SafeArea(
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(dynamic state) {
    if (state.isLoading && state.dashboard == null) {
      return const AdminLoadingState(
        message: 'Loading admin dashboard...',
      );
    }

    if (state.errorMessage != null && state.dashboard == null) {
      return AdminErrorState(
        message: state.errorMessage!,
        onAction: () {
          ref.read(adminDashboardProvider.notifier).loadDashboard();
        },
      );
    }

    if (state.dashboard == null) {
      return const AdminEmptyState(
        icon: Icons.dashboard_outlined,
        title: 'No Dashboard Data',
        message:
            'There is currently no dashboard information available.',
      );
    }

    final dashboard = state.dashboard!;

    return RefreshIndicator(
      onRefresh: () {
        return ref
            .read(adminDashboardProvider.notifier)
            .refreshDashboard();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            sliver: SliverToBoxAdapter(
              child: AdminPageHeader(
                title: 'Admin Dashboard',
                subtitle:
                    'Monitor and manage your LawLink360 platform.',
                actions: [
                  if (state.isRefreshing)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  else
                    Builder(
                      builder: (context) {
                        return IconButton(
                          tooltip: 'Menu',
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        );
                      },
                    ),
                  IconButton(
                    tooltip: 'Refresh',
                    onPressed: () {
                      ref
                          .read(
                            adminDashboardProvider.notifier,
                          )
                          .refreshDashboard();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: _buildStats(dashboard),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            sliver: SliverToBoxAdapter(
              child: AdminDashboardSection(
                title: 'Platform Overview',
                subtitle: 'Current activity across LawLink360.',
                child: AdminDashboardChart(
                  title: 'Daily Activity',
                  subtitle: 'Sample activity data',
                  values: const [
                    32,
                    48,
                    41,
                    65,
                    54,
                    78,
                    62,
                  ],
                  labels: const [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            sliver: SliverToBoxAdapter(
              child: AdminDashboardSection(
                title: 'Quick Actions',
                subtitle:
                    'Frequently used administration tools.',
                child: _buildQuickActions(),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            sliver: SliverToBoxAdapter(
              child: AdminDashboardSection(
                title: 'Recent Activity',
                subtitle:
                    'Latest actions across the platform.',
                actionLabel: 'View All',
                onAction: () {
                  _openScreen(const AdminActivityScreen());
                },
                child: _buildRecentActivity(dashboard),
              ),
            ),
          ),

          if (state.errorMessage != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Material(
                  color: Theme.of(context)
                      .colorScheme
                      .errorContainer,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onErrorContainer,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(
                                  adminDashboardProvider
                                      .notifier,
                                )
                                .clearError();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          const SliverPadding(
            padding: EdgeInsets.only(bottom: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(dynamic dashboard) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final crossAxisCount = isWide ? 3 : 2;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,

          // More vertical room prevents the revenue/stat card
          // from overflowing on smaller screens.
          childAspectRatio: isWide ? 1.35 : 0.95,

          children: [
            AdminStatCard(
              title: 'Total Users',
              value: _formatNumber(dashboard.totalUsers),
              icon: Icons.people_outline,
            ),
            AdminStatCard(
              title: 'Total Lawyers',
              value: _formatNumber(dashboard.totalLawyers),
              icon: Icons.gavel_outlined,
            ),
            AdminStatCard(
              title: 'Pending Verifications',
              value: _formatNumber(
                dashboard.pendingVerifications,
              ),
              icon: Icons.verified_outlined,
            ),
            AdminStatCard(
              title: "Today's Appointments",
              value: _formatNumber(
                dashboard.todayAppointments,
              ),
              icon: Icons.event_outlined,
            ),
            AdminStatCard(
              title: 'Active Cases',
              value: _formatNumber(dashboard.activeCases),
              icon: Icons.folder_outlined,
            ),
            AdminStatCard(
              title: 'Total Revenue',
              value:
                  'Rs. ${_formatCurrency(dashboard.totalRevenue)}',
              icon: Icons.payments_outlined,
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;

        final actions = [
          AdminQuickActionCard(
            title: 'Manage Users',
            subtitle: 'View and manage platform users.',
            icon: Icons.people_outline,
            onTap: () {
              _openScreen(const AdminUsersScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Manage Lawyers',
            subtitle: 'View registered lawyers.',
            icon: Icons.gavel_outlined,
            onTap: () {
              _openScreen(const AdminLawyersScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Verify Lawyers',
            subtitle:
                'Review pending verification requests.',
            icon: Icons.verified_outlined,
            onTap: () {
              _openScreen(const AdminVerificationScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Appointments',
            subtitle:
                'Monitor platform appointments.',
            icon: Icons.event_outlined,
            onTap: () {
              _openScreen(const AdminAppointmentsScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Cases',
            subtitle:
                'Monitor and manage platform cases.',
            icon: Icons.folder_outlined,
            onTap: () {
              _openScreen(const AdminCasesScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Payments',
            subtitle:
                'Monitor payments and transactions.',
            icon: Icons.payments_outlined,
            onTap: () {
              _openScreen(const AdminPaymentsScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Notifications',
            subtitle:
                'Manage platform notifications.',
            icon: Icons.notifications_outlined,
            onTap: () {
              _openScreen(
                const AdminNotificationsScreen(),
              );
            },
          ),
          AdminQuickActionCard(
            title: 'Content',
            subtitle:
                'Manage laws, judgments and procedures.',
            icon: Icons.library_books_outlined,
            onTap: () {
              _openScreen(const AdminContentScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Analytics',
            subtitle:
                'Review platform analytics and trends.',
            icon: Icons.analytics_outlined,
            onTap: () {
              _openScreen(const AdminAnalyticsScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Reports',
            subtitle:
                'View administrative reports.',
            icon: Icons.description_outlined,
            onTap: () {
              _openScreen(const AdminReportsScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Activity',
            subtitle:
                'Review administrative activity logs.',
            icon: Icons.history_outlined,
            onTap: () {
              _openScreen(const AdminActivityScreen());
            },
          ),
          AdminQuickActionCard(
            title: 'Settings',
            subtitle:
                'Configure administrator settings.',
            icon: Icons.settings_outlined,
            onTap: () {
              _openScreen(const AdminSettingsScreen());
            },
          ),
        ];

        if (isWide) {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.8,
            children: actions,
          );
        }

        return Column(
          children: [
            for (int index = 0;
                index < actions.length;
                index++) ...[
              actions[index],
              if (index != actions.length - 1)
                const SizedBox(height: 12),
            ],
          ],
        );
      },
    );
  }

  Widget _buildRecentActivity(dynamic dashboard) {
    if (dashboard.recentActivities.isEmpty) {
      return const AdminEmptyState(
        icon: Icons.history,
        title: 'No Recent Activity',
        message:
            'There are no recent administrative activities '
            'to display.',
      );
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            for (int index = 0;
                index < dashboard.recentActivities.length;
                index++) ...[
              AdminRecentActivityCard(
                activity:
                    dashboard.recentActivities[index],
              ),
              if (index !=
                  dashboard.recentActivities.length - 1)
                const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)},',
        );
  }

  String _formatCurrency(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)},',
        );
  }
}
