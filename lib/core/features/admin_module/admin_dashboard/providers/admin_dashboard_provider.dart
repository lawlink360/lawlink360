import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_dashboard/models/admin_state_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/services/admin_dashboard_service.dart';

final adminDashboardServiceProvider = Provider<AdminDashboardService>((ref) {
  return const AdminDashboardService();
});

final adminDashboardProvider =
    NotifierProvider<AdminDashboardNotifier, AdminStateModel>(
  AdminDashboardNotifier.new,
);

class AdminDashboardNotifier extends Notifier<AdminStateModel> {
  late final AdminDashboardService _service;

  @override
  AdminStateModel build() {
    _service = ref.watch(adminDashboardServiceProvider);

    return const AdminStateModel();
  }

  Future<void> loadDashboard() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final dashboard = await _service.fetchDashboard();

      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        dashboard: dashboard,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> refreshDashboard() async {
    if (state.isRefreshing) {
      return;
    }

    state = state.copyWith(
      isRefreshing: true,
      clearError: true,
    );

    try {
      final dashboard = await _service.refreshDashboard();

      state = state.copyWith(
        isRefreshing: false,
        dashboard: dashboard,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: error.toString(),
      );
    }
  }

  void clearError() {
    state = state.clearError();
  }
}