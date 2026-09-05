import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_analytics_mock_data.dart';
import '../models/analytics_model.dart';
import '../models/appointment_analytics_model.dart';
import '../models/lawyer_analytics_model.dart';
import '../models/revenue_analytics_model.dart';
import '../models/user_analytics_model.dart';

final adminAnalyticsProvider = NotifierProvider<
    AdminAnalyticsNotifier,
    AsyncValue<AnalyticsModel>>(
  AdminAnalyticsNotifier.new,
);

class AdminAnalyticsNotifier
    extends Notifier<AsyncValue<AnalyticsModel>> {
  late AnalyticsModel _summary;
  late List<UserAnalyticsModel> _userAnalytics;
  late List<LawyerAnalyticsModel> _lawyerAnalytics;
  late List<AppointmentAnalyticsModel> _appointmentAnalytics;
  late List<RevenueAnalyticsModel> _revenueAnalytics;

  String _selectedPeriod = '6 Months';

  @override
  AsyncValue<AnalyticsModel> build() {
    _loadMockData();

    return AsyncData(_summary);
  }

  void _loadMockData() {
    _summary = AdminAnalyticsMockData.summary;

    _userAnalytics = List<UserAnalyticsModel>.from(
      AdminAnalyticsMockData.userAnalytics,
    );

    _lawyerAnalytics = List<LawyerAnalyticsModel>.from(
      AdminAnalyticsMockData.lawyerAnalytics,
    );

    _appointmentAnalytics =
        List<AppointmentAnalyticsModel>.from(
      AdminAnalyticsMockData.appointmentAnalytics,
    );

    _revenueAnalytics =
        List<RevenueAnalyticsModel>.from(
      AdminAnalyticsMockData.revenueAnalytics,
    );
  }

  String get selectedPeriod => _selectedPeriod;

  AnalyticsModel get summary => _summary;

  List<UserAnalyticsModel> get userAnalytics =>
      _getPeriodData(_userAnalytics);

  List<LawyerAnalyticsModel> get lawyerAnalytics =>
      _getPeriodData(_lawyerAnalytics);

  List<AppointmentAnalyticsModel> get appointmentAnalytics =>
      _getPeriodData(_appointmentAnalytics);

  List<RevenueAnalyticsModel> get revenueAnalytics =>
      _getPeriodData(_revenueAnalytics);

  int get totalUsers => _summary.totalUsers;

  int get totalLawyers => _summary.totalLawyers;

  int get totalAppointments => _summary.totalAppointments;

  int get completedAppointments =>
      _summary.completedAppointments;

  int get cancelledAppointments =>
      _summary.cancelledAppointments;

  int get totalCases => _summary.totalCases;

  int get activeCases => _summary.activeCases;

  int get totalVerifications =>
      _summary.totalVerifications;

  int get approvedVerifications =>
      _summary.approvedVerifications;

  double get totalRevenue => _summary.totalRevenue;

  double get monthlyRevenue => _summary.monthlyRevenue;

  double get averageAppointmentValue =>
      _summary.averageAppointmentValue;

  double get appointmentCompletionRate {
    if (_summary.totalAppointments == 0) {
      return 0;
    }

    return (_summary.completedAppointments /
            _summary.totalAppointments) *
        100;
  }

  double get verificationApprovalRate {
    if (_summary.totalVerifications == 0) {
      return 0;
    }

    return (_summary.approvedVerifications /
            _summary.totalVerifications) *
        100;
  }

  double get lawyerVerificationRate {
    if (_summary.totalLawyers == 0) {
      return 0;
    }

    final verified = _lawyerAnalytics.isEmpty
        ? 0
        : _lawyerAnalytics.last.verifiedLawyers;

    return (verified / _summary.totalLawyers) * 100;
  }

  int get newUsersThisPeriod {
    if (_userAnalytics.isEmpty) {
      return 0;
    }

    return _userAnalytics.fold(
      0,
      (total, item) => total + item.newUsers,
    );
  }

  int get newLawyersThisPeriod {
    if (_lawyerAnalytics.isEmpty) {
      return 0;
    }

    return _lawyerAnalytics.fold(
      0,
      (total, item) => total + item.newLawyers,
    );
  }

  int get completedAppointmentsThisPeriod {
    if (_appointmentAnalytics.isEmpty) {
      return 0;
    }

    return _appointmentAnalytics.fold(
      0,
      (total, item) => total + item.completed,
    );
  }

  double get revenueThisPeriod {
    if (_revenueAnalytics.isEmpty) {
      return 0;
    }

    return _revenueAnalytics.fold(
      0,
      (total, item) => total + item.revenue,
    );
  }

  double get netRevenueThisPeriod {
    if (_revenueAnalytics.isEmpty) {
      return 0;
    }

    return _revenueAnalytics.fold(
      0,
      (total, item) => total + item.netRevenue,
    );
  }

  void selectPeriod(String period) {
    _selectedPeriod = period;
    state = AsyncData(_summary);
  }

  void refresh() {
    state = const AsyncLoading();

    Future<void>.delayed(
      const Duration(milliseconds: 300),
      () {
        _loadMockData();
        state = AsyncData(_summary);
      },
    );
  }

  void updateSummary(AnalyticsModel summary) {
    _summary = summary;
    state = AsyncData(_summary);
  }

  void updateUserAnalytics(
    List<UserAnalyticsModel> analytics,
  ) {
    _userAnalytics = List<UserAnalyticsModel>.from(analytics);
    state = AsyncData(_summary);
  }

  void updateLawyerAnalytics(
    List<LawyerAnalyticsModel> analytics,
  ) {
    _lawyerAnalytics =
        List<LawyerAnalyticsModel>.from(analytics);
    state = AsyncData(_summary);
  }

  void updateAppointmentAnalytics(
    List<AppointmentAnalyticsModel> analytics,
  ) {
    _appointmentAnalytics =
        List<AppointmentAnalyticsModel>.from(analytics);
    state = AsyncData(_summary);
  }

  void updateRevenueAnalytics(
    List<RevenueAnalyticsModel> analytics,
  ) {
    _revenueAnalytics =
        List<RevenueAnalyticsModel>.from(analytics);
    state = AsyncData(_summary);
  }

  List<T> _getPeriodData<T>(List<T> data) {
    switch (_selectedPeriod) {
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
}