import 'package:lawlink360/core/features/admin_module/admin_dashboard/data/mock/admin_dashboard_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/models/admin_dashboard_model.dart';

class AdminDashboardService {
  const AdminDashboardService();

  Future<AdminDashboardModel> fetchDashboard() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    return AdminDashboardMockData.dashboard;
  }

  Future<AdminDashboardModel> refreshDashboard() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return AdminDashboardMockData.dashboard;
  }
}