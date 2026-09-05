class LawyerAnalyticsModel {
  final String period;
  final DateTime date;
  final int totalLawyers;
  final int newLawyers;
  final int verifiedLawyers;
  final int activeLawyers;
  final int suspendedLawyers;
  final double averageRating;

  const LawyerAnalyticsModel({
    required this.period,
    required this.date,
    required this.totalLawyers,
    required this.newLawyers,
    required this.verifiedLawyers,
    required this.activeLawyers,
    required this.suspendedLawyers,
    required this.averageRating,
  });

  LawyerAnalyticsModel copyWith({
    String? period,
    DateTime? date,
    int? totalLawyers,
    int? newLawyers,
    int? verifiedLawyers,
    int? activeLawyers,
    int? suspendedLawyers,
    double? averageRating,
  }) {
    return LawyerAnalyticsModel(
      period: period ?? this.period,
      date: date ?? this.date,
      totalLawyers: totalLawyers ?? this.totalLawyers,
      newLawyers: newLawyers ?? this.newLawyers,
      verifiedLawyers:
          verifiedLawyers ?? this.verifiedLawyers,
      activeLawyers: activeLawyers ?? this.activeLawyers,
      suspendedLawyers:
          suspendedLawyers ?? this.suspendedLawyers,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'period': period,
      'date': date.toIso8601String(),
      'totalLawyers': totalLawyers,
      'newLawyers': newLawyers,
      'verifiedLawyers': verifiedLawyers,
      'activeLawyers': activeLawyers,
      'suspendedLawyers': suspendedLawyers,
      'averageRating': averageRating,
    };
  }

  factory LawyerAnalyticsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LawyerAnalyticsModel(
      period: map['period'] as String? ?? '',
      date: _parseDate(map['date']) ?? DateTime.now(),
      totalLawyers:
          (map['totalLawyers'] as num?)?.toInt() ?? 0,
      newLawyers:
          (map['newLawyers'] as num?)?.toInt() ?? 0,
      verifiedLawyers:
          (map['verifiedLawyers'] as num?)?.toInt() ?? 0,
      activeLawyers:
          (map['activeLawyers'] as num?)?.toInt() ?? 0,
      suspendedLawyers:
          (map['suspendedLawyers'] as num?)?.toInt() ?? 0,
      averageRating:
          (map['averageRating'] as num?)?.toDouble() ?? 0,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}