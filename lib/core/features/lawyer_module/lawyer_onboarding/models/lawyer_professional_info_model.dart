class LawyerProfessionalInfoModel {
  final List<String> practiceAreas;
  final int yearsOfExperience;
  final String licenseNumber;
  final List<String> courts;
  final String about;

  const LawyerProfessionalInfoModel({
    this.practiceAreas = const [],
    this.yearsOfExperience = 0,
    this.licenseNumber = '',
    this.courts = const [],
    this.about = '',
  });

  LawyerProfessionalInfoModel copyWith({
    List<String>? practiceAreas,
    int? yearsOfExperience,
    String? licenseNumber,
    List<String>? courts,
    String? about,
  }) {
    return LawyerProfessionalInfoModel(
      practiceAreas: practiceAreas ?? this.practiceAreas,
      yearsOfExperience:
          yearsOfExperience ?? this.yearsOfExperience,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      courts: courts ?? this.courts,
      about: about ?? this.about,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'practiceAreas': practiceAreas,
      'yearsOfExperience': yearsOfExperience,
      'licenseNumber': licenseNumber,
      'courts': courts,
      'about': about,
    };
  }

  factory LawyerProfessionalInfoModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LawyerProfessionalInfoModel(
      practiceAreas: List<String>.from(
        map['practiceAreas'] ?? [],
      ),
      yearsOfExperience:
          (map['yearsOfExperience'] ?? 0) as int,
      licenseNumber:
          map['licenseNumber'] as String? ?? '',
      courts: List<String>.from(
        map['courts'] ?? [],
      ),
      about: map['about'] as String? ?? '',
    );
  }
}