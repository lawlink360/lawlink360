import '../data/mock/admin_analytics_mock_data.dart';
import '../models/analytics_model.dart';
import '../models/appointment_analytics_model.dart';
import '../models/lawyer_analytics_model.dart';
import '../models/revenue_analytics_model.dart';
import '../models/user_analytics_model.dart';

class AdminAnalyticsService {
  AdminAnalyticsService._();

  static final AdminAnalyticsService instance =
      AdminAnalyticsService._();

  Future<AnalyticsModel> fetchSummary() async {
    await _simulateDelay();

    return AdminAnalyticsMockData.summary;
  }

  Future<List<UserAnalyticsModel>> fetchUserAnalytics() async {
    await _simulateDelay();

    return List<UserAnalyticsModel>.from(
      AdminAnalyticsMockData.userAnalytics,
    );
  }

  Future<List<LawyerAnalyticsModel>> fetchLawyerAnalytics() async {
    await _simulateDelay();

    return List<LawyerAnalyticsModel>.from(
      AdminAnalyticsMockData.lawyerAnalytics,
    );
  }

  Future<List<AppointmentAnalyticsModel>>
      fetchAppointmentAnalytics() async {
    await _simulateDelay();

    return List<AppointmentAnalyticsModel>.from(
      AdminAnalyticsMockData.appointmentAnalytics,
    );
  }

  Future<List<RevenueAnalyticsModel>> fetchRevenueAnalytics() async {
    await _simulateDelay();

    return List<RevenueAnalyticsModel>.from(
      AdminAnalyticsMockData.revenueAnalytics,
    );
  }

  Future<Map<String, dynamic>> fetchCompleteAnalytics() async {
    await _simulateDelay();

    return {
      'summary': AdminAnalyticsMockData.summary,
      'users': List<UserAnalyticsModel>.from(
        AdminAnalyticsMockData.userAnalytics,
      ),
      'lawyers': List<LawyerAnalyticsModel>.from(
        AdminAnalyticsMockData.lawyerAnalytics,
      ),
      'appointments': List<AppointmentAnalyticsModel>.from(
        AdminAnalyticsMockData.appointmentAnalytics,
      ),
      'revenue': List<RevenueAnalyticsModel>.from(
        AdminAnalyticsMockData.revenueAnalytics,
      ),
    };
  }

  Future<Map<String, dynamic>> fetchPeriodSummary(
    String period,
  ) async {
    await _simulateDelay();

    final users = _filterByPeriod(
      AdminAnalyticsMockData.userAnalytics,
      period,
    );

    final lawyers = _filterByPeriod(
      AdminAnalyticsMockData.lawyerAnalytics,
      period,
    );

    final appointments = _filterByPeriod(
      AdminAnalyticsMockData.appointmentAnalytics,
      period,
    );

    final revenue = _filterByPeriod(
      AdminAnalyticsMockData.revenueAnalytics,
      period,
    );

    return {
      'period': period,
      'users': users,
      'lawyers': lawyers,
      'appointments': appointments,
      'revenue': revenue,
    };
  }

  Future<double> calculateTotalRevenue() async {
  await _simulateDelay();

  return AdminAnalyticsMockData.revenueAnalytics.fold<double>(
    0.0,
    (total, item) => total + item.revenue,
  );
}

Future<double> calculateNetRevenue() async {
  await _simulateDelay();

  return AdminAnalyticsMockData.revenueAnalytics.fold<double>(
    0.0,
    (total, item) => total + item.netRevenue,
  );
}

Future<int> calculateTotalNewUsers() async {
  await _simulateDelay();

  return AdminAnalyticsMockData.userAnalytics.fold<int>(
    0,
    (total, item) => total + item.newUsers,
  );
}

Future<int> calculateTotalNewLawyers() async {
  await _simulateDelay();

  return AdminAnalyticsMockData.lawyerAnalytics.fold<int>(
    0,
    (total, item) => total + item.newLawyers,
  );
}

Future<int> calculateCompletedAppointments() async {
  await _simulateDelay();

  return AdminAnalyticsMockData.appointmentAnalytics.fold<int>(
    0,
    (total, item) => total + item.completed,
  );
}

  List<T> _filterByPeriod<T>(
    List<T> data,
    String period,
  ) {
    switch (period) {
      case '1 Month':
        return data.isEmpty
            ? <T>[]
            : data.sublist(
                data.length > 1 ? data.length - 1 : 0,
              );

      case '3 Months':
        return data.length <= 3
            ? List<T>.from(data)
            : data.sublist(data.length - 3);

      case '6 Months':
        return List<T>.from(data);

      case '1 Year':
        return List<T>.from(data);

      default:
        return List<T>.from(data);
    }
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );
  }
}