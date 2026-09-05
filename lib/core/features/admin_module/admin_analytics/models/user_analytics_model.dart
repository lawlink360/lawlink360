class UserAnalyticsModel {
  final String period;
  final DateTime date;
  final int totalUsers;
  final int newUsers;
  final int activeUsers;
  final int verifiedUsers;
  final int suspendedUsers;
  final double growthRate;

  const UserAnalyticsModel({
    required this.period,
    required this.date,
    required this.totalUsers,
    required this.newUsers,
    required this.activeUsers,
    required this.verifiedUsers,
    required this.suspendedUsers,
    required this.growthRate,
  });

  UserAnalyticsModel copyWith({
    String? period,
    DateTime? date,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? verifiedUsers,
    int? suspendedUsers,
    double? growthRate,
  }) {
    return UserAnalyticsModel(
      period: period ?? this.period,
      date: date ?? this.date,
      totalUsers: totalUsers ?? this.totalUsers,
      newUsers: newUsers ?? this.newUsers,
      activeUsers: activeUsers ?? this.activeUsers,
      verifiedUsers:
          verifiedUsers ?? this.verifiedUsers,
      suspendedUsers:
          suspendedUsers ?? this.suspendedUsers,
      growthRate: growthRate ?? this.growthRate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'period': period,
      'date': date.toIso8601String(),
      'totalUsers': totalUsers,
      'newUsers': newUsers,
      'activeUsers': activeUsers,
      'verifiedUsers': verifiedUsers,
      'suspendedUsers': suspendedUsers,
      'growthRate': growthRate,
    };
  }

  factory UserAnalyticsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserAnalyticsModel(
      period: map['period'] as String? ?? '',
      date: _parseDate(map['date']) ?? DateTime.now(),
      totalUsers:
          (map['totalUsers'] as num?)?.toInt() ?? 0,
      newUsers:
          (map['newUsers'] as num?)?.toInt() ?? 0,
      activeUsers:
          (map['activeUsers'] as num?)?.toInt() ?? 0,
      verifiedUsers:
          (map['verifiedUsers'] as num?)?.toInt() ?? 0,
      suspendedUsers:
          (map['suspendedUsers'] as num?)?.toInt() ?? 0,
      growthRate:
          (map['growthRate'] as num?)?.toDouble() ?? 0,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}