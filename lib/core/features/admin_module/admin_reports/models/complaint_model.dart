class ComplaintModel {
  final String id;
  final String subject;
  final String description;
  final String category;
  final String complainantId;
  final String complainantName;
  final String? complainantEmail;
  final String? againstId;
  final String? againstName;
  final String? againstType;
  final String status;
  final String priority;
  final String? assignedTo;
  final String? assignedToName;
  final String? resolution;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  const ComplaintModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.category,
    required this.complainantId,
    required this.complainantName,
    this.complainantEmail,
    this.againstId,
    this.againstName,
    this.againstType,
    required this.status,
    required this.priority,
    this.assignedTo,
    this.assignedToName,
    this.resolution,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  ComplaintModel copyWith({
    String? id,
    String? subject,
    String? description,
    String? category,
    String? complainantId,
    String? complainantName,
    String? complainantEmail,
    String? againstId,
    String? againstName,
    String? againstType,
    String? status,
    String? priority,
    String? assignedTo,
    String? assignedToName,
    String? resolution,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      category: category ?? this.category,
      complainantId: complainantId ?? this.complainantId,
      complainantName: complainantName ?? this.complainantName,
      complainantEmail: complainantEmail ?? this.complainantEmail,
      againstId: againstId ?? this.againstId,
      againstName: againstName ?? this.againstName,
      againstType: againstType ?? this.againstType,
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
      'subject': subject,
      'description': description,
      'category': category,
      'complainantId': complainantId,
      'complainantName': complainantName,
      'complainantEmail': complainantEmail,
      'againstId': againstId,
      'againstName': againstName,
      'againstType': againstType,
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

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      id: map['id'] as String? ?? '',
      subject: map['subject'] as String? ?? '',
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      complainantId: map['complainantId'] as String? ?? '',
      complainantName: map['complainantName'] as String? ?? '',
      complainantEmail: map['complainantEmail'] as String?,
      againstId: map['againstId'] as String?,
      againstName: map['againstName'] as String?,
      againstType: map['againstType'] as String?,
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