class AdminNotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final String recipientType;
  final String? recipientId;
  final String? recipientName;
  final String? recipientEmail;
  final String priority;
  final String status;
  final bool isRead;
  final DateTime? scheduledAt;
  final DateTime? sentAt;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminNotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.recipientType,
    this.recipientId,
    this.recipientName,
    this.recipientEmail,
    required this.priority,
    required this.status,
    required this.isRead,
    this.scheduledAt,
    this.sentAt,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminNotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    String? recipientType,
    String? recipientId,
    String? recipientName,
    String? recipientEmail,
    String? priority,
    String? status,
    bool? isRead,
    DateTime? scheduledAt,
    DateTime? sentAt,
    DateTime? readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminNotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      recipientType: recipientType ?? this.recipientType,
      recipientId: recipientId ?? this.recipientId,
      recipientName: recipientName ?? this.recipientName,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      isRead: isRead ?? this.isRead,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'recipientType': recipientType,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'recipientEmail': recipientEmail,
      'priority': priority,
      'status': status,
      'isRead': isRead,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminNotificationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AdminNotificationModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      message: map['message'] as String? ?? '',
      type: map['type'] as String? ?? '',
      recipientType: map['recipientType'] as String? ?? '',
      recipientId: map['recipientId'] as String?,
      recipientName: map['recipientName'] as String?,
      recipientEmail: map['recipientEmail'] as String?,
      priority: map['priority'] as String? ?? 'Normal',
      status: map['status'] as String? ?? 'Sent',
      isRead: map['isRead'] as bool? ?? false,
      scheduledAt: _parseDate(map['scheduledAt']),
      sentAt: _parseDate(map['sentAt']),
      readAt: _parseDate(map['readAt']),
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

    return DateTime.tryParse(value.toString());
  }
}