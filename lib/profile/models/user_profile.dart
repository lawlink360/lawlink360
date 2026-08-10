class UserProfile {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String profileImage;
  final bool profileCompleted;
  final bool isPremium;
  final bool isVerified;

  const UserProfile({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.profileImage,
    required this.profileCompleted,
    required this.isPremium,
    required this.isVerified,
  });

  factory UserProfile.empty() {
    return const UserProfile(
      uid: '',
      fullName: '',
      email: '',
      phone: '',
      role: '',
      profileImage: '',
      profileCompleted: false,
      isPremium: false,
      isVerified: false,
    );
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      profileImage: map['profileImage'] ?? '',
      profileCompleted: map['profileCompleted'] ?? false,
      isPremium: map['isPremium'] ?? false,
      isVerified: map['isVerified'] ?? false,
    );
  }

  UserProfile copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? role,
    String? profileImage,
    bool? profileCompleted,
    bool? isPremium,
    bool? isVerified,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      profileCompleted:
          profileCompleted ?? this.profileCompleted,
      isPremium: isPremium ?? this.isPremium,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}