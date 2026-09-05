import 'admin_dashboard_model.dart';

class AdminStateModel {
  final bool isLoading;
  final bool isRefreshing;
  final AdminDashboardModel? dashboard;
  final String? errorMessage;

  const AdminStateModel({
    this.isLoading = false,
    this.isRefreshing = false,
    this.dashboard,
    this.errorMessage,
  });

  AdminStateModel copyWith({
    bool? isLoading,
    bool? isRefreshing,
    AdminDashboardModel? dashboard,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AdminStateModel(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      dashboard: dashboard ?? this.dashboard,
      errorMessage:
          clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  AdminStateModel clearError() {
    return AdminStateModel(
      isLoading: isLoading,
      isRefreshing: isRefreshing,
      dashboard: dashboard,
      errorMessage: null,
    );
  }
}