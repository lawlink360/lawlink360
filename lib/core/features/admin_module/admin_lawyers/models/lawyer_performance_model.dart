class LawyerPerformanceModel {
  final String lawyerId;
  final int totalAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int totalClients;
  final int activeCases;
  final int completedCases;
  final double averageRating;
  final int totalReviews;
  final double totalRevenue;
  final double monthlyRevenue;

  const LawyerPerformanceModel({
    required this.lawyerId,
    required this.totalAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.totalClients,
    required this.activeCases,
    required this.completedCases,
    required this.averageRating,
    required this.totalReviews,
    required this.totalRevenue,
    required this.monthlyRevenue,
  });

  LawyerPerformanceModel copyWith({
    String? lawyerId,
    int? totalAppointments,
    int? completedAppointments,
    int? cancelledAppointments,
    int? totalClients,
    int? activeCases,
    int? completedCases,
    double? averageRating,
    int? totalReviews,
    double? totalRevenue,
    double? monthlyRevenue,
  }) {
    return LawyerPerformanceModel(
      lawyerId: lawyerId ?? this.lawyerId,
      totalAppointments:
          totalAppointments ?? this.totalAppointments,
      completedAppointments:
          completedAppointments ?? this.completedAppointments,
      cancelledAppointments:
          cancelledAppointments ?? this.cancelledAppointments,
      totalClients: totalClients ?? this.totalClients,
      activeCases: activeCases ?? this.activeCases,
      completedCases: completedCases ?? this.completedCases,
      averageRating:
          averageRating ?? this.averageRating,
      totalReviews:
          totalReviews ?? this.totalReviews,
      totalRevenue:
          totalRevenue ?? this.totalRevenue,
      monthlyRevenue:
          monthlyRevenue ?? this.monthlyRevenue,
    );
  }

  factory LawyerPerformanceModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LawyerPerformanceModel(
      lawyerId: map['lawyerId'] as String? ?? '',
      totalAppointments:
          map['totalAppointments'] as int? ?? 0,
      completedAppointments:
          map['completedAppointments'] as int? ?? 0,
      cancelledAppointments:
          map['cancelledAppointments'] as int? ?? 0,
      totalClients:
          map['totalClients'] as int? ?? 0,
      activeCases:
          map['activeCases'] as int? ?? 0,
      completedCases:
          map['completedCases'] as int? ?? 0,
      averageRating:
          (map['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalReviews:
          map['totalReviews'] as int? ?? 0,
      totalRevenue:
          (map['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      monthlyRevenue:
          (map['monthlyRevenue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lawyerId': lawyerId,
      'totalAppointments': totalAppointments,
      'completedAppointments': completedAppointments,
      'cancelledAppointments': cancelledAppointments,
      'totalClients': totalClients,
      'activeCases': activeCases,
      'completedCases': completedCases,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'totalRevenue': totalRevenue,
      'monthlyRevenue': monthlyRevenue,
    };
  }
}