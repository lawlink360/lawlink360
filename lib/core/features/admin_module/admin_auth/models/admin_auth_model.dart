class AdminAuthModel {
  final String adminId;
  final String email;
  final String name;
  final String roleId;
  final String roleName;
  final bool isActive;
  final bool isAuthenticated;
  final DateTime? lastLoginAt;
  final DateTime? sessionStartedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminAuthModel({
    required this.adminId,
    required this.email,
    required this.name,
    required this.roleId,
    required this.roleName,
    this.isActive = true,
    this.isAuthenticated = false,
    this.lastLoginAt,
    this.sessionStartedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminAuthModel copyWith({
    String? adminId,
    String? email,
    String? name,
    String? roleId,
    String? roleName,
    bool? isActive,
    bool? isAuthenticated,
    DateTime? lastLoginAt,
    DateTime? sessionStartedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminAuthModel(
      adminId: adminId ?? this.adminId,
      email: email ?? this.email,
      name: name ?? this.name,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      isActive: isActive ?? this.isActive,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      sessionStartedAt: sessionStartedAt ?? this.sessionStartedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'email': email,
      'name': name,
      'roleId': roleId,
      'roleName': roleName,
      'isActive': isActive,
      'isAuthenticated': isAuthenticated,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'sessionStartedAt': sessionStartedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminAuthModel.fromMap(Map<String, dynamic> map) {
    return AdminAuthModel(
      adminId: map['adminId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      roleId: map['roleId'] as String? ?? '',
      roleName: map['roleName'] as String? ?? '',
      isActive: map['isActive'] as bool? ?? true,
      isAuthenticated: map['isAuthenticated'] as bool? ?? false,
      lastLoginAt: _parseDate(map['lastLoginAt']),
      sessionStartedAt: _parseDate(map['sessionStartedAt']),
      createdAt: _parseDate(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDate(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }
}
