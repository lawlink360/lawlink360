import 'notification_type.dart';

class NotificationModel {
  final String notificationId;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  /// A lightweight action identifier that can later be mapped
  /// to an actual LawLink360 destination.
  ///
  /// Examples:
  /// appointments
  /// myCases
  /// messages
  /// documents
  /// payments
  /// verification
  final String? actionKey;

  /// Optional identifier of the related record.
  ///
  /// Examples:
  /// appointment ID
  /// case number
  /// document ID
  /// payment ID
  final String? relatedId;

  const NotificationModel({
    required this.notificationId,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.isRead,
    this.actionKey,
    this.relatedId,
  });

  NotificationModel copyWith({
    String? notificationId,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    String? actionKey,
    String? relatedId,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      actionKey: actionKey ?? this.actionKey,
      relatedId: relatedId ?? this.relatedId,
    );
  }
}