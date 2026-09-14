import '../models/notification_model.dart';
import '../models/notification_type.dart';

class NotificationData {
  NotificationData._();

  static final List<NotificationModel> notifications = [
    NotificationModel(
      notificationId: 'notification_001',
      title: 'Upcoming Consultation',
      message:
          'Your video consultation with Advocate Ahmed Khan is scheduled for today at 4:00 PM.',
      timestamp: DateTime(2026, 9, 9, 10, 15),
      type: NotificationType.appointment,
      isRead: false,
      actionKey: 'appointments',
      relatedId: 'appointment_001',
    ),

    NotificationModel(
      notificationId: 'notification_002',
      title: 'Case Update',
      message:
          'A new update has been added to your property dispute case.',
      timestamp: DateTime(2026, 9, 8, 18, 30),
      type: NotificationType.caseUpdate,
      isRead: false,
      actionKey: 'myCases',
      relatedId: 'CASE-2026-001',
    ),

    NotificationModel(
      notificationId: 'notification_003',
      title: 'New Message',
      message:
          'Advocate Ahmed Khan sent you a new message regarding your case.',
      timestamp: DateTime(2026, 9, 8, 15, 45),
      type: NotificationType.message,
      isRead: false,
      actionKey: 'messages',
      relatedId: 'conversation_001',
    ),

    NotificationModel(
      notificationId: 'notification_004',
      title: 'Document Ready',
      message:
          'Your requested legal document has been prepared and is ready to view.',
      timestamp: DateTime(2026, 9, 7, 12, 20),
      type: NotificationType.document,
      isRead: true,
      actionKey: 'documents',
      relatedId: 'document_001',
    ),

    NotificationModel(
      notificationId: 'notification_005',
      title: 'Payment Successful',
      message:
          'Your payment of PKR 3,500 for the legal consultation was successful.',
      timestamp: DateTime(2026, 9, 6, 17, 10),
      type: NotificationType.payment,
      isRead: true,
      actionKey: 'payments',
      relatedId: 'payment_001',
    ),

    NotificationModel(
      notificationId: 'notification_006',
      title: 'Verification Approved',
      message:
          'Your identity verification has been successfully completed.',
      timestamp: DateTime(2026, 9, 5, 11, 35),
      type: NotificationType.verification,
      isRead: true,
      actionKey: 'verification',
      relatedId: 'verification_001',
    ),

    NotificationModel(
      notificationId: 'notification_007',
      title: 'Profile Reminder',
      message:
          'Complete your profile to get a more personalized LawLink360 experience.',
      timestamp: DateTime(2026, 9, 4, 9, 00),
      type: NotificationType.actionRequired,
      isRead: true,
      actionKey: 'profile',
    ),

    NotificationModel(
      notificationId: 'notification_008',
      title: 'LawLink360 Update',
      message:
          'New improvements have been added to the LawLink360 client experience.',
      timestamp: DateTime(2026, 9, 3, 14, 25),
      type: NotificationType.system,
      isRead: true,
    ),
  ];
}