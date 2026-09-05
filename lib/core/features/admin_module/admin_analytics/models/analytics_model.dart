class AnalyticsModel {
  final int totalUsers;
  final int totalLawyers;
  final int totalAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int totalCases;
  final int activeCases;
  final int totalVerifications;
  final int approvedVerifications;
  final double totalRevenue;
  final double monthlyRevenue;
  final double averageAppointmentValue;
  final DateTime lastUpdated;

  const AnalyticsModel({
    required this.totalUsers,
    required this.totalLawyers,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.totalCases,
    required this.activeCases,
    required this.totalVerifications,
    required this.approvedVerifications,
    required this.totalRevenue,
    required this.monthlyRevenue,
    required this.averageAppointmentValue,
    required this.lastUpdated,
  });

  AnalyticsModel copyWith({
    int? totalUsers,
    int? totalLawyers,
    int? totalAppointments,
    int? completedAppointments,
    int? cancelledAppointments,
    int? totalCases,
    int? activeCases,
    int? totalVerifications,
    int? approvedVerifications,
    double? totalRevenue,
    double? monthlyRevenue,
    double? averageAppointmentValue,
    DateTime? lastUpdated,
  }) {
    return AnalyticsModel(
      totalUsers: totalUsers ?? this.totalUsers,
      totalLawyers: totalLawyers ?? this.totalLawyers,
      totalAppointments:
          totalAppointments ?? this.totalAppointments,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      cancelledAppointments:
          cancelledAppointments ?? this.cancelledAppointments,
      totalCases: totalCases ?? this.totalCases,
      activeCases: activeCases ?? this.activeCases,
      totalVerifications:
          totalVerifications ?? this.totalVerifications,
      approvedVerifications:
          approvedVerifications ?? this.approvedVerifications,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      averageAppointmentValue:
          averageAppointmentValue ?? this.averageAppointmentValue,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalUsers': totalUsers,
      'totalLawyers': totalLawyers,
      'totalAppointments': totalAppointments,
      'completedAppointments': completedAppointments,
      'cancelledAppointments': cancelledAppointments,
      'totalCases': totalCases,
      'activeCases': activeCases,
      'totalVerifications': totalVerifications,
      'approvedVerifications': approvedVerifications,
      'totalRevenue': totalRevenue,
      'monthlyRevenue': monthlyRevenue,
      'averageAppointmentValue': averageAppointmentValue,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory AnalyticsModel.fromMap(Map<String, dynamic> map) {
    return AnalyticsModel(
      totalUsers: (map['totalUsers'] as num?)?.toInt() ?? 0,
      totalLawyers: (map['totalLawyers'] as num?)?.toInt() ?? 0,
      totalAppointments:
          (map['totalAppointments'] as num?)?.toInt() ?? 0,
      completedAppointments:
          (map['completedAppointments'] as num?)?.toInt() ?? 0,
      cancelledAppointments:
          (map['cancelledAppointments'] as num?)?.toInt() ?? 0,
      totalCases: (map['totalCases'] as num?)?.toInt() ?? 0,
      activeCases: (map['activeCases'] as num?)?.toInt() ?? 0,
      totalVerifications:
          (map['totalVerifications'] as num?)?.toInt() ?? 0,
      approvedVerifications:
          (map['approvedVerifications'] as num?)?.toInt() ?? 0,
      totalRevenue:
          (map['totalRevenue'] as num?)?.toDouble() ?? 0,
      monthlyRevenue:
          (map['monthlyRevenue'] as num?)?.toDouble() ?? 0,
      averageAppointmentValue:
          (map['averageAppointmentValue'] as num?)?.toDouble() ?? 0,
      lastUpdated: _parseDate(map['lastUpdated']) ?? DateTime.now(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}