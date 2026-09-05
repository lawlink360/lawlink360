class AdminLawyerModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String specialization;
  final String city;
  final String status;
  final DateTime joinedAt;
  final bool isVerified;
  final bool isApproved;
  final int totalClients;
  final int activeCases;
  final int completedCases;
  final double rating;
  final int totalReviews;

  const AdminLawyerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.city,
    required this.status,
    required this.joinedAt,
    required this.isVerified,
    required this.isApproved,
    required this.totalClients,
    required this.activeCases,
    required this.completedCases,
    required this.rating,
    required this.totalReviews,
  });

  AdminLawyerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? specialization,
    String? city,
    String? status,
    DateTime? joinedAt,
    bool? isVerified,
    bool? isApproved,
    int? totalClients,
    int? activeCases,
    int? completedCases,
    double? rating,
    int? totalReviews,
  }) {
    return AdminLawyerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      specialization: specialization ?? this.specialization,
      city: city ?? this.city,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      isVerified: isVerified ?? this.isVerified,
      isApproved: isApproved ?? this.isApproved,
      totalClients: totalClients ?? this.totalClients,
      activeCases: activeCases ?? this.activeCases,
      completedCases: completedCases ?? this.completedCases,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  factory AdminLawyerModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AdminLawyerModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      specialization:
          map['specialization'] as String? ?? '',
      city: map['city'] as String? ?? '',
      status: map['status'] as String? ?? 'active',
      joinedAt: map['joinedAt'] is DateTime
          ? map['joinedAt'] as DateTime
          : DateTime.tryParse(
                map['joinedAt'] as String? ?? '',
              ) ??
              DateTime.now(),
      isVerified: map['isVerified'] as bool? ?? false,
      isApproved: map['isApproved'] as bool? ?? false,
      totalClients: map['totalClients'] as int? ?? 0,
      activeCases: map['activeCases'] as int? ?? 0,
      completedCases: map['completedCases'] as int? ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: map['totalReviews'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'specialization': specialization,
      'city': city,
      'status': status,
      'joinedAt': joinedAt.toIso8601String(),
      'isVerified': isVerified,
      'isApproved': isApproved,
      'totalClients': totalClients,
      'activeCases': activeCases,
      'completedCases': completedCases,
      'rating': rating,
      'totalReviews': totalReviews,
    };
  }
}