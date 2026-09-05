class AdminActivityModel {
  final String id;
  final String action;
  final String description;
  final String category;
  final String adminId;
  final String adminName;
  final String? adminEmail;
  final String? targetId;
  final String? targetName;
  final String? targetType;
  final String? ipAddress;
  final String? deviceInfo;
  final DateTime createdAt;

  const AdminActivityModel({
    required this.id,
    required this.action,
    required this.description,
    required this.category,
    required this.adminId,
    required this.adminName,
    this.adminEmail,
    this.targetId,
    this.targetName,
    this.targetType,
    this.ipAddress,
    this.deviceInfo,
    required this.createdAt,
  });

  AdminActivityModel copyWith({
    String? id,
    String? action,
    String? description,
    String? category,
    String? adminId,
    String? adminName,
    String? adminEmail,
    String? targetId,
    String? targetName,
    String? targetType,
    String? ipAddress,
    String? deviceInfo,
    DateTime? createdAt,
  }) {
    return AdminActivityModel(
      id: id ?? this.id,
      action: action ?? this.action,
      description: description ?? this.description,
      category: category ?? this.category,
      adminId: adminId ?? this.adminId,
      adminName: adminName ?? this.adminName,
      adminEmail: adminEmail ?? this.adminEmail,
      targetId: targetId ?? this.targetId,
      targetName: targetName ?? this.targetName,
      targetType: targetType ?? this.targetType,
      ipAddress: ipAddress ?? this.ipAddress,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'description': description,
      'category': category,
      'adminId': adminId,
      'adminName': adminName,
      'adminEmail': adminEmail,
      'targetId': targetId,
      'targetName': targetName,
      'targetType': targetType,
      'ipAddress': ipAddress,
      'deviceInfo': deviceInfo,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AdminActivityModel.fromMap(Map<String, dynamic> map) {
    return AdminActivityModel(
      id: map['id']?.toString() ?? '',
      action: map['action']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      adminId: map['adminId']?.toString() ?? '',
      adminName: map['adminName']?.toString() ?? '',
      adminEmail: map['adminEmail']?.toString(),
      targetId: map['targetId']?.toString(),
      targetName: map['targetName']?.toString(),
      targetType: map['targetType']?.toString(),
      ipAddress: map['ipAddress']?.toString(),
      deviceInfo: map['deviceInfo']?.toString(),
      createdAt: _parseDate(map['createdAt']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    return DateTime.now();
  }
}