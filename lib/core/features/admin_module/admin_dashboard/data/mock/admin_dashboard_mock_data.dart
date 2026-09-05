import 'package:lawlink360/core/features/admin_module/admin_dashboard/models/admin_activity_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_dashboard/models/admin_dashboard_model.dart';

class AdminDashboardMockData {
  AdminDashboardMockData._();

  static AdminDashboardModel get dashboard {
    final now = DateTime.now();

    return AdminDashboardModel(
      totalUsers: 2486,
      totalLawyers: 384,
      pendingVerifications: 27,
      todayAppointments: 42,
      activeCases: 176,
      totalRevenue: 1847500.00,
      recentActivities: [
        AdminActivityModel(
          id: 'activity_001',
          title: 'Lawyer Verification Submitted',
          description:
              'A new lawyer verification request has been submitted for review.',
          type: 'verification',
          timestamp: now.subtract(const Duration(minutes: 12)),
          actorName: 'Muhammad Ahmed',
        ),
        AdminActivityModel(
          id: 'activity_002',
          title: 'New User Registered',
          description:
              'A new client account has been successfully registered.',
          type: 'user',
          timestamp: now.subtract(const Duration(minutes: 28)),
          actorName: 'Ali Raza',
        ),
        AdminActivityModel(
          id: 'activity_003',
          title: 'Appointment Completed',
          description:
              'A scheduled lawyer consultation has been marked as completed.',
          type: 'appointment',
          timestamp: now.subtract(const Duration(hours: 1)),
          actorName: 'Sara Khan',
        ),
        AdminActivityModel(
          id: 'activity_004',
          title: 'Payment Received',
          description:
              'A consultation payment has been successfully processed.',
          type: 'payment',
          timestamp: now.subtract(const Duration(hours: 2)),
          actorName: 'Usman Tariq',
        ),
        AdminActivityModel(
          id: 'activity_005',
          title: 'Case Updated',
          description:
              'Case information has been updated by the assigned lawyer.',
          type: 'case',
          timestamp: now.subtract(const Duration(hours: 3)),
          actorName: 'Hassan Malik',
        ),
        AdminActivityModel(
          id: 'activity_006',
          title: 'Lawyer Approved',
          description:
              'A lawyer verification request has been approved by admin.',
          type: 'verification',
          timestamp: now.subtract(const Duration(hours: 5)),
          actorName: 'Admin',
        ),
        AdminActivityModel(
          id: 'activity_007',
          title: 'User Account Suspended',
          description:
              'A user account has been temporarily suspended by admin.',
          type: 'user',
          timestamp: now.subtract(const Duration(hours: 7)),
          actorName: 'Admin',
        ),
        AdminActivityModel(
          id: 'activity_008',
          title: 'Refund Processed',
          description:
              'A consultation payment refund has been successfully processed.',
          type: 'payment',
          timestamp: now.subtract(const Duration(hours: 9)),
          actorName: 'Admin',
        ),
      ],
    );
  }
}