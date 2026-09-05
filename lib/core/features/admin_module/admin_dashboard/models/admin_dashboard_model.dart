import 'admin_activity_model.dart';

class AdminDashboardModel {
  final int totalUsers;
  final int totalLawyers;
  final int pendingVerifications;
  final int todayAppointments;
  final int activeCases;
  final double totalRevenue;
  final List<AdminActivityModel> recentActivities;

  const AdminDashboardModel({
    required this.totalUsers,
    required this.totalLawyers,
    required this.pendingVerifications,
    required this.todayAppointments,
    required this.activeCases,
    required this.totalRevenue,
    required this.recentActivities,
  });

  AdminDashboardModel copyWith({
    int? totalUsers,
    int? totalLawyers,
    int? pendingVerifications,
    int? todayAppointments,
    int? activeCases,
    double? totalRevenue,
    List<AdminActivityModel>? recentActivities,
  }) {
    return AdminDashboardModel(
      totalUsers: totalUsers ?? this.totalUsers,
      totalLawyers: totalLawyers ?? this.totalLawyers,
      pendingVerifications:
          pendingVerifications ?? this.pendingVerifications,
      todayAppointments: todayAppointments ?? this.todayAppointments,
      activeCases: activeCases ?? this.activeCases,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      recentActivities:
          recentActivities ?? this.recentActivities,
    );
  }

  factory AdminDashboardModel.fromMap(Map<String, dynamic> map) {
    return AdminDashboardModel(
      totalUsers: map['totalUsers'] as int? ?? 0,
      totalLawyers: map['totalLawyers'] as int? ?? 0,
      pendingVerifications:
          map['pendingVerifications'] as int? ?? 0,
      todayAppointments:
          map['todayAppointments'] as int? ?? 0,
      activeCases: map['activeCases'] as int? ?? 0,
      totalRevenue: (map['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      recentActivities:
          (map['recentActivities'] as List<dynamic>? ?? [])
              .map(
                (item) => AdminActivityModel.fromMap(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalUsers': totalUsers,
      'totalLawyers': totalLawyers,
      'pendingVerifications': pendingVerifications,
      'todayAppointments': todayAppointments,
      'activeCases': activeCases,
      'totalRevenue': totalRevenue,
      'recentActivities':
          recentActivities.map((activity) => activity.toMap()).toList(),
    };
  }
}