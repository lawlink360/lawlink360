class LawyerBasicInfoModel {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String city;
  final String professionalIntroduction;
  final String? profileImagePath;

  const LawyerBasicInfoModel({
    this.fullName = '',
    this.phoneNumber = '',
    this.email = '',
    this.gender = '',
    this.city = '',
    this.professionalIntroduction = '',
    this.profileImagePath,
  });

  LawyerBasicInfoModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    String? city,
    String? professionalIntroduction,
    String? profileImagePath,
  }) {
    return LawyerBasicInfoModel(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      professionalIntroduction:
          professionalIntroduction ?? this.professionalIntroduction,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'city': city,
      'professionalIntroduction': professionalIntroduction,
      'profileImagePath': profileImagePath,
    };
  }

  factory LawyerBasicInfoModel.fromMap(Map<String, dynamic> map) {
    return LawyerBasicInfoModel(
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      city: map['city'] ?? '',
      professionalIntroduction:
          map['professionalIntroduction'] ?? '',
      profileImagePath: map['profileImagePath'],
    );
  }
}