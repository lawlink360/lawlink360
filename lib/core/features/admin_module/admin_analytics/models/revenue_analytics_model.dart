class RevenueAnalyticsModel {
  final String period;
  final DateTime date;
  final double revenue;
  final double refunds;
  final double commissions;
  final double netRevenue;
  final int transactions;
  final double averageTransaction;

  const RevenueAnalyticsModel({
    required this.period,
    required this.date,
    required this.revenue,
    required this.refunds,
    required this.commissions,
    required this.netRevenue,
    required this.transactions,
    required this.averageTransaction,
  });

  RevenueAnalyticsModel copyWith({
    String? period,
    DateTime? date,
    double? revenue,
    double? refunds,
    double? commissions,
    double? netRevenue,
    int? transactions,
    double? averageTransaction,
  }) {
    return RevenueAnalyticsModel(
      period: period ?? this.period,
      date: date ?? this.date,
      revenue: revenue ?? this.revenue,
      refunds: refunds ?? this.refunds,
      commissions: commissions ?? this.commissions,
      netRevenue: netRevenue ?? this.netRevenue,
      transactions: transactions ?? this.transactions,
      averageTransaction:
          averageTransaction ?? this.averageTransaction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'period': period,
      'date': date.toIso8601String(),
      'revenue': revenue,
      'refunds': refunds,
      'commissions': commissions,
      'netRevenue': netRevenue,
      'transactions': transactions,
      'averageTransaction': averageTransaction,
    };
  }

  factory RevenueAnalyticsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return RevenueAnalyticsModel(
      period: map['period'] as String? ?? '',
      date: _parseDate(map['date']) ?? DateTime.now(),
      revenue: (map['revenue'] as num?)?.toDouble() ?? 0,
      refunds: (map['refunds'] as num?)?.toDouble() ?? 0,
      commissions:
          (map['commissions'] as num?)?.toDouble() ?? 0,
      netRevenue:
          (map['netRevenue'] as num?)?.toDouble() ?? 0,
      transactions:
          (map['transactions'] as num?)?.toInt() ?? 0,
      averageTransaction:
          (map['averageTransaction'] as num?)?.toDouble() ?? 0,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}