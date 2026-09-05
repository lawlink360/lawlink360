/// Represents an administrator within LawLink360.
class AdminModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profileImageUrl;
  final bool isActive;
  final DateTime? lastLoginAt;

  const AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImageUrl,
    this.isActive = true,
    this.lastLoginAt,
  });

  AdminModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? profileImageUrl,
    bool? isActive,
    DateTime? lastLoginAt,
  }) {
    return AdminModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}