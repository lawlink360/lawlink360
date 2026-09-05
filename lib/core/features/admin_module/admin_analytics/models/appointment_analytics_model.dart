class AppointmentAnalyticsModel {
  final String period;
  final DateTime date;
  final int total;
  final int completed;
  final int cancelled;
  final int pending;
  final int scheduled;
  final double completionRate;

  const AppointmentAnalyticsModel({
    required this.period,
    required this.date,
    required this.total,
    required this.completed,
    required this.cancelled,
    required this.pending,
    required this.scheduled,
    required this.completionRate,
  });

  AppointmentAnalyticsModel copyWith({
    String? period,
    DateTime? date,
    int? total,
    int? completed,
    int? cancelled,
    int? pending,
    int? scheduled,
    double? completionRate,
  }) {
    return AppointmentAnalyticsModel(
      period: period ?? this.period,
      date: date ?? this.date,
      total: total ?? this.total,
      completed: completed ?? this.completed,
      cancelled: cancelled ?? this.cancelled,
      pending: pending ?? this.pending,
      scheduled: scheduled ?? this.scheduled,
      completionRate:
          completionRate ?? this.completionRate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'period': period,
      'date': date.toIso8601String(),
      'total': total,
      'completed': completed,
      'cancelled': cancelled,
      'pending': pending,
      'scheduled': scheduled,
      'completionRate': completionRate,
    };
  }

  factory AppointmentAnalyticsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppointmentAnalyticsModel(
      period: map['period'] as String? ?? '',
      date: _parseDate(map['date']) ?? DateTime.now(),
      total: (map['total'] as num?)?.toInt() ?? 0,
      completed: (map['completed'] as num?)?.toInt() ?? 0,
      cancelled: (map['cancelled'] as num?)?.toInt() ?? 0,
      pending: (map['pending'] as num?)?.toInt() ?? 0,
      scheduled: (map['scheduled'] as num?)?.toInt() ?? 0,
      completionRate:
          (map['completionRate'] as num?)?.toDouble() ?? 0,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}