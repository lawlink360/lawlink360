class NotificationCampaignModel {
  final String id;
  final String name;
  final String title;
  final String message;
  final String type;
  final String recipientType;
  final int recipientCount;
  final String status;
  final String priority;
  final DateTime? scheduledAt;
  final DateTime? sentAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  const NotificationCampaignModel({
    required this.id,
    required this.name,
    required this.title,
    required this.message,
    required this.type,
    required this.recipientType,
    required this.recipientCount,
    required this.status,
    required this.priority,
    this.scheduledAt,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  NotificationCampaignModel copyWith({
    String? id,
    String? name,
    String? title,
    String? message,
    String? type,
    String? recipientType,
    int? recipientCount,
    String? status,
    String? priority,
    DateTime? scheduledAt,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
  }) {
    return NotificationCampaignModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      recipientType: recipientType ?? this.recipientType,
      recipientCount: recipientCount ?? this.recipientCount,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'message': message,
      'type': type,
      'recipientType': recipientType,
      'recipientCount': recipientCount,
      'status': status,
      'priority': priority,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }

  factory NotificationCampaignModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return NotificationCampaignModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      title: map['title'] as String? ?? '',
      message: map['message'] as String? ?? '',
      type: map['type'] as String? ?? '',
      recipientType: map['recipientType'] as String? ?? '',
      recipientCount:
          (map['recipientCount'] as num?)?.toInt() ?? 0,
      status: map['status'] as String? ?? 'Draft',
      priority: map['priority'] as String? ?? 'Normal',
      scheduledAt: _parseDate(map['scheduledAt']),
      sentAt: _parseDate(map['sentAt']),
      createdAt: _parseDate(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDate(map['updatedAt']) ?? DateTime.now(),
      createdBy: map['createdBy'] as String? ?? '',
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(value.toString());
  }
}