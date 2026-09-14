enum NotificationType {
  appointment,
  caseUpdate,
  message,
  document,
  payment,
  verification,
  system,
  actionRequired,
}

extension NotificationTypeExtension on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.appointment:
        return 'Appointment';
      case NotificationType.caseUpdate:
        return 'Case Update';
      case NotificationType.message:
        return 'Message';
      case NotificationType.document:
        return 'Document';
      case NotificationType.payment:
        return 'Payment';
      case NotificationType.verification:
        return 'Verification';
      case NotificationType.system:
        return 'System';
      case NotificationType.actionRequired:
        return 'Action Required';
    }
  }

  String get iconName {
    switch (this) {
      case NotificationType.appointment:
        return 'calendar';
      case NotificationType.caseUpdate:
        return 'case';
      case NotificationType.message:
        return 'message';
      case NotificationType.document:
        return 'document';
      case NotificationType.payment:
        return 'payment';
      case NotificationType.verification:
        return 'verification';
      case NotificationType.system:
        return 'system';
      case NotificationType.actionRequired:
        return 'actionRequired';
    }
  }
}