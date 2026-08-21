class LawyerClientModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String phone;
  final String email;
  final String city;
  final String caseTitle;
  final String caseStatus;
  final String lastActivity;
  final int activeCases;
  final int totalCases;
  final DateTime joinedAt;

  const LawyerClientModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.phone,
    required this.email,
    required this.city,
    required this.caseTitle,
    required this.caseStatus,
    required this.lastActivity,
    required this.activeCases,
    required this.totalCases,
    required this.joinedAt,
  });

  LawyerClientModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? phone,
    String? email,
    String? city,
    String? caseTitle,
    String? caseStatus,
    String? lastActivity,
    int? activeCases,
    int? totalCases,
    DateTime? joinedAt,
  }) {
    return LawyerClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      caseTitle: caseTitle ?? this.caseTitle,
      caseStatus: caseStatus ?? this.caseStatus,
      lastActivity: lastActivity ?? this.lastActivity,
      activeCases: activeCases ?? this.activeCases,
      totalCases: totalCases ?? this.totalCases,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}