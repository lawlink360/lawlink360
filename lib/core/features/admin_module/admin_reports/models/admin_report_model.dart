class AdminReportModel {
  final String id;
  final String title;
  final String description;
  final String reportType;
  final String reporterId;
  final String reporterName;
  final String? reporterEmail;
  final String? targetId;
  final String? targetName;
  final String? targetType;
  final String status;
  final String priority;
  final String? assignedTo;
  final String? assignedToName;
  final String? resolution;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  const AdminReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.reportType,
    required this.reporterId,
    required this.reporterName,
    this.reporterEmail,
    this.targetId,
    this.targetName,
    this.targetType,
    required this.status,
    required this.priority,
    this.assignedTo,
    this.assignedToName,
    this.resolution,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  AdminReportModel copyWith({
    String? id,
    String? title,
    String? description,
    String? reportType,
    String? reporterId,
    String? reporterName,
    String? reporterEmail,
    String? targetId,
    String? targetName,
    String? targetType,
    String? status,
    String? priority,
    String? assignedTo,
    String? assignedToName,
    String? resolution,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) {
    return AdminReportModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      reportType: reportType ?? this.reportType,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      reporterEmail: reporterEmail ?? this.reporterEmail,
      targetId: targetId ?? this.targetId,
      targetName: targetName ?? this.targetName,
      targetType: targetType ?? this.targetType,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      resolution: resolution ?? this.resolution,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reportType': reportType,
      'reporterId': reporterId,
      'reporterName': reporterName,
      'reporterEmail': reporterEmail,
      'targetId': targetId,
      'targetName': targetName,
      'targetType': targetType,
      'status': status,
      'priority': priority,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'resolution': resolution,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
    };
  }

  factory AdminReportModel.fromMap(Map<String, dynamic> map) {
    return AdminReportModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      reportType: map['reportType'] as String? ?? '',
      reporterId: map['reporterId'] as String? ?? '',
      reporterName: map['reporterName'] as String? ?? '',
      reporterEmail: map['reporterEmail'] as String?,
      targetId: map['targetId'] as String?,
      targetName: map['targetName'] as String?,
      targetType: map['targetType'] as String?,
      status: map['status'] as String? ?? 'Pending',
      priority: map['priority'] as String? ?? 'Medium',
      assignedTo: map['assignedTo'] as String?,
      assignedToName: map['assignedToName'] as String?,
      resolution: map['resolution'] as String?,
      createdAt: _parseDate(map['createdAt']),
      updatedAt: _parseDate(map['updatedAt']),
      resolvedAt: _parseNullableDate(map['resolvedAt']),
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

  static DateTime? _parseNullableDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }
}