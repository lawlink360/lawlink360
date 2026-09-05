class AuditLogModel {
  final String id;
  final String action;
  final String category;
  final String actorId;
  final String actorName;
  final String? actorEmail;
  final String? targetId;
  final String? targetName;
  final String? targetType;
  final String? oldValue;
  final String? newValue;
  final String? metadata;
  final String? ipAddress;
  final String? deviceInfo;
  final DateTime createdAt;

  const AuditLogModel({
    required this.id,
    required this.action,
    required this.category,
    required this.actorId,
    required this.actorName,
    this.actorEmail,
    this.targetId,
    this.targetName,
    this.targetType,
    this.oldValue,
    this.newValue,
    this.metadata,
    this.ipAddress,
    this.deviceInfo,
    required this.createdAt,
  });

  AuditLogModel copyWith({
    String? id,
    String? action,
    String? category,
    String? actorId,
    String? actorName,
    String? actorEmail,
    String? targetId,
    String? targetName,
    String? targetType,
    String? oldValue,
    String? newValue,
    String? metadata,
    String? ipAddress,
    String? deviceInfo,
    DateTime? createdAt,
  }) {
    return AuditLogModel(
      id: id ?? this.id,
      action: action ?? this.action,
      category: category ?? this.category,
      actorId: actorId ?? this.actorId,
      actorName: actorName ?? this.actorName,
      actorEmail: actorEmail ?? this.actorEmail,
      targetId: targetId ?? this.targetId,
      targetName: targetName ?? this.targetName,
      targetType: targetType ?? this.targetType,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      metadata: metadata ?? this.metadata,
      ipAddress: ipAddress ?? this.ipAddress,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'category': category,
      'actorId': actorId,
      'actorName': actorName,
      'actorEmail': actorEmail,
      'targetId': targetId,
      'targetName': targetName,
      'targetType': targetType,
      'oldValue': oldValue,
      'newValue': newValue,
      'metadata': metadata,
      'ipAddress': ipAddress,
      'deviceInfo': deviceInfo,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AuditLogModel.fromMap(Map<String, dynamic> map) {
    return AuditLogModel(
      id: map['id']?.toString() ?? '',
      action: map['action']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      actorId: map['actorId']?.toString() ?? '',
      actorName: map['actorName']?.toString() ?? '',
      actorEmail: map['actorEmail']?.toString(),
      targetId: map['targetId']?.toString(),
      targetName: map['targetName']?.toString(),
      targetType: map['targetType']?.toString(),
      oldValue: map['oldValue']?.toString(),
      newValue: map['newValue']?.toString(),
      metadata: map['metadata']?.toString(),
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