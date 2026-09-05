class AdminUserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final DateTime joinedAt;
  final int appointmentsCount;
  final int activeCasesCount;
  final bool isVerified;

  const AdminUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.joinedAt,
    required this.appointmentsCount,
    required this.activeCasesCount,
    required this.isVerified,
  });

  AdminUserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? status,
    DateTime? joinedAt,
    int? appointmentsCount,
    int? activeCasesCount,
    bool? isVerified,
  }) {
    return AdminUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      appointmentsCount:
          appointmentsCount ?? this.appointmentsCount,
      activeCasesCount:
          activeCasesCount ?? this.activeCasesCount,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory AdminUserModel.fromMap(Map<String, dynamic> map) {
    return AdminUserModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      role: map['role'] as String? ?? 'client',
      status: map['status'] as String? ?? 'active',
      joinedAt: map['joinedAt'] is DateTime
          ? map['joinedAt'] as DateTime
          : DateTime.tryParse(
                map['joinedAt'] as String? ?? '',
              ) ??
              DateTime.now(),
      appointmentsCount:
          map['appointmentsCount'] as int? ?? 0,
      activeCasesCount:
          map['activeCasesCount'] as int? ?? 0,
      isVerified: map['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toIso8601String(),
      'appointmentsCount': appointmentsCount,
      'activeCasesCount': activeCasesCount,
      'isVerified': isVerified,
    };
  }
}