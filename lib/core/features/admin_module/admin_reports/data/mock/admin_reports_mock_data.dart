import '../../models/admin_report_model.dart';
import '../../models/complaint_model.dart';

class AdminReportsMockData {
  AdminReportsMockData._();

  // ---------------------------------------------------------------------------
  // REPORTS
  // ---------------------------------------------------------------------------

  static final List<AdminReportModel> reports = [
    AdminReportModel(
      id: 'REP-1001',
      title: 'Inappropriate lawyer communication',
      description:
          'The user reported receiving inappropriate and unprofessional '
          'messages from a lawyer during a consultation.',
      reportType: 'Lawyer Conduct',
      reporterId: 'USR-1042',
      reporterName: 'Ali Raza',
      reporterEmail: 'ali.raza@example.com',
      targetId: 'LAW-0214',
      targetName: 'Adv. Hassan Ahmed',
      targetType: 'Lawyer',
      status: 'Pending',
      priority: 'High',
      createdAt: DateTime(2026, 9, 1, 10, 20),
      updatedAt: DateTime(2026, 9, 1, 10, 20),
    ),
    AdminReportModel(
      id: 'REP-1002',
      title: 'Appointment payment issue',
      description:
          'The reported payment was deducted from the client account, '
          'but the appointment was not confirmed.',
      reportType: 'Payment',
      reporterId: 'USR-1087',
      reporterName: 'Ayesha Khan',
      reporterEmail: 'ayesha.khan@example.com',
      targetId: 'PAY-5821',
      targetName: 'Payment PAY-5821',
      targetType: 'Payment',
      status: 'Under Review',
      priority: 'High',
      assignedTo: 'ADM-001',
      assignedToName: 'Admin Support',
      createdAt: DateTime(2026, 9, 1, 13, 45),
      updatedAt: DateTime(2026, 9, 2, 9, 10),
    ),
    AdminReportModel(
      id: 'REP-1003',
      title: 'Fake lawyer profile suspected',
      description:
          'A client has reported that the information displayed on a '
          'lawyer profile may not match the lawyer credentials.',
      reportType: 'Verification',
      reporterId: 'USR-1112',
      reporterName: 'Usman Tariq',
      reporterEmail: 'usman.tariq@example.com',
      targetId: 'LAW-0348',
      targetName: 'Adv. Muhammad Bilal',
      targetType: 'Lawyer',
      status: 'Investigating',
      priority: 'Critical',
      assignedTo: 'ADM-002',
      assignedToName: 'Verification Team',
      createdAt: DateTime(2026, 8, 29, 11, 30),
      updatedAt: DateTime(2026, 9, 2, 14, 15),
    ),
    AdminReportModel(
      id: 'REP-1004',
      title: 'Offensive content in chat',
      description:
          'A user reported offensive language being used in a consultation '
          'chat and requested administrative review.',
      reportType: 'User Conduct',
      reporterId: 'USR-1164',
      reporterName: 'Sana Malik',
      reporterEmail: 'sana.malik@example.com',
      targetId: 'USR-1190',
      targetName: 'Kashif Mehmood',
      targetType: 'User',
      status: 'Resolved',
      priority: 'Medium',
      assignedTo: 'ADM-001',
      assignedToName: 'Admin Support',
      resolution:
          'The reported content was reviewed and appropriate action was '
          'taken according to platform policy.',
      createdAt: DateTime(2026, 8, 25, 16, 40),
      updatedAt: DateTime(2026, 8, 28, 12, 10),
      resolvedAt: DateTime(2026, 8, 28, 12, 10),
    ),
    AdminReportModel(
      id: 'REP-1005',
      title: 'Incorrect case information',
      description:
          'The client reported incorrect case information displayed in '
          'the case management section.',
      reportType: 'Case Management',
      reporterId: 'USR-1033',
      reporterName: 'Hamza Shah',
      reporterEmail: 'hamza.shah@example.com',
      targetId: 'CASE-2045',
      targetName: 'Civil Case CASE-2045',
      targetType: 'Case',
      status: 'Pending',
      priority: 'Medium',
      createdAt: DateTime(2026, 9, 2, 9, 25),
      updatedAt: DateTime(2026, 9, 2, 9, 25),
    ),
    AdminReportModel(
      id: 'REP-1006',
      title: 'Duplicate account report',
      description:
          'A duplicate account was reported and requires verification '
          'before any account-level action is taken.',
      reportType: 'Account',
      reporterId: 'USR-1056',
      reporterName: 'Fatima Noor',
      reporterEmail: 'fatima.noor@example.com',
      targetId: 'USR-1205',
      targetName: 'Ahmed Hassan',
      targetType: 'User',
      status: 'Closed',
      priority: 'Low',
      assignedTo: 'ADM-003',
      assignedToName: 'Account Team',
      resolution:
          'Duplicate account was confirmed and the appropriate account '
          'was retained.',
      createdAt: DateTime(2026, 8, 18, 10, 15),
      updatedAt: DateTime(2026, 8, 21, 15, 30),
      resolvedAt: DateTime(2026, 8, 21, 15, 30),
    ),
    AdminReportModel(
      id: 'REP-1007',
      title: 'Unauthorized document request',
      description:
          'A client reported that a lawyer requested documents unrelated '
          'to the active legal matter.',
      reportType: 'Privacy',
      reporterId: 'USR-1211',
      reporterName: 'Maham Javed',
      reporterEmail: 'maham.javed@example.com',
      targetId: 'LAW-0189',
      targetName: 'Adv. Saad Ali',
      targetType: 'Lawyer',
      status: 'Under Review',
      priority: 'High',
      assignedTo: 'ADM-002',
      assignedToName: 'Verification Team',
      createdAt: DateTime(2026, 9, 3, 8, 50),
      updatedAt: DateTime(2026, 9, 3, 11, 20),
    ),
    AdminReportModel(
      id: 'REP-1008',
      title: 'Misleading legal service information',
      description:
          'The service description on a lawyer profile was reported as '
          'potentially misleading to clients.',
      reportType: 'Content',
      reporterId: 'USR-1098',
      reporterName: 'Zainab Iqbal',
      reporterEmail: 'zainab.iqbal@example.com',
      targetId: 'LAW-0275',
      targetName: 'Adv. Omar Farooq',
      targetType: 'Lawyer',
      status: 'Rejected',
      priority: 'Low',
      assignedTo: 'ADM-001',
      assignedToName: 'Admin Support',
      resolution:
          'The submitted evidence did not establish a policy violation.',
      createdAt: DateTime(2026, 8, 12, 14, 30),
      updatedAt: DateTime(2026, 8, 15, 10, 45),
      resolvedAt: DateTime(2026, 8, 15, 10, 45),
    ),
  ];

  // ---------------------------------------------------------------------------
  // COMPLAINTS
  // ---------------------------------------------------------------------------

  static final List<ComplaintModel> complaints = [
    ComplaintModel(
      id: 'CMP-2001',
      subject: 'Lawyer did not attend scheduled consultation',
      description:
          'The lawyer did not join the scheduled video consultation and '
          'the client was unable to contact the lawyer.',
      category: 'Appointment',
      complainantId: 'USR-1008',
      complainantName: 'Hira Aslam',
      complainantEmail: 'hira.aslam@example.com',
      againstId: 'LAW-0142',
      againstName: 'Adv. Ahmed Rauf',
      againstType: 'Lawyer',
      status: 'Pending',
      priority: 'High',
      createdAt: DateTime(2026, 9, 1, 9, 40),
      updatedAt: DateTime(2026, 9, 1, 9, 40),
    ),
    ComplaintModel(
      id: 'CMP-2002',
      subject: 'Refund has not been received',
      description:
          'The complainant states that the approved refund has not yet '
          'appeared in the original payment method.',
      category: 'Payment',
      complainantId: 'USR-1075',
      complainantName: 'Bilal Ahmed',
      complainantEmail: 'bilal.ahmed@example.com',
      againstId: 'PAY-5742',
      againstName: 'Payment PAY-5742',
      againstType: 'Payment',
      status: 'Under Review',
      priority: 'High',
      assignedTo: 'ADM-001',
      assignedToName: 'Payment Support',
      createdAt: DateTime(2026, 8, 30, 12, 15),
      updatedAt: DateTime(2026, 9, 2, 10, 25),
    ),
    ComplaintModel(
      id: 'CMP-2003',
      subject: 'Unable to upload verification document',
      description:
          'The lawyer is unable to upload a required verification document '
          'despite multiple attempts.',
      category: 'Verification',
      complainantId: 'LAW-0321',
      complainantName: 'Adv. Maryam Siddiqui',
      complainantEmail: 'maryam.siddiqui@example.com',
      againstId: 'VER-8831',
      againstName: 'Verification VER-8831',
      againstType: 'Verification',
      status: 'Investigating',
      priority: 'Medium',
      assignedTo: 'ADM-002',
      assignedToName: 'Verification Team',
      createdAt: DateTime(2026, 8, 27, 15, 20),
      updatedAt: DateTime(2026, 9, 1, 13, 30),
    ),
    ComplaintModel(
      id: 'CMP-2004',
      subject: 'Account temporarily suspended',
      description:
          'The complainant believes the account was suspended incorrectly '
          'and has requested an administrative review.',
      category: 'Account',
      complainantId: 'USR-1146',
      complainantName: 'Noman Ali',
      complainantEmail: 'noman.ali@example.com',
      againstId: 'USR-1146',
      againstName: 'Noman Ali',
      againstType: 'User',
      status: 'Resolved',
      priority: 'Medium',
      assignedTo: 'ADM-003',
      assignedToName: 'Account Team',
      resolution:
          'The account review was completed and the restriction was removed.',
      createdAt: DateTime(2026, 8, 20, 11, 10),
      updatedAt: DateTime(2026, 8, 23, 16, 20),
      resolvedAt: DateTime(2026, 8, 23, 16, 20),
    ),
    ComplaintModel(
      id: 'CMP-2005',
      subject: 'Incorrect appointment cancellation',
      description:
          'The client reports that an appointment was cancelled without '
          'their request or prior notification.',
      category: 'Appointment',
      complainantId: 'USR-1178',
      complainantName: 'Laiba Tariq',
      complainantEmail: 'laiba.tariq@example.com',
      againstId: 'APT-7612',
      againstName: 'Appointment APT-7612',
      againstType: 'Appointment',
      status: 'Pending',
      priority: 'Medium',
      createdAt: DateTime(2026, 9, 3, 10, 35),
      updatedAt: DateTime(2026, 9, 3, 10, 35),
    ),
    ComplaintModel(
      id: 'CMP-2006',
      subject: 'Repeated promotional messages',
      description:
          'The user complained about receiving repeated promotional '
          'notifications that they did not request.',
      category: 'Notifications',
      complainantId: 'USR-1124',
      complainantName: 'Areeba Khan',
      complainantEmail: 'areeba.khan@example.com',
      againstId: 'SYS-NOTIFICATION',
      againstName: 'Notification System',
      againstType: 'System',
      status: 'Closed',
      priority: 'Low',
      assignedTo: 'ADM-001',
      assignedToName: 'Admin Support',
      resolution:
          'Notification preferences were updated and promotional '
          'notifications were disabled.',
      createdAt: DateTime(2026, 8, 10, 13, 50),
      updatedAt: DateTime(2026, 8, 12, 11, 25),
      resolvedAt: DateTime(2026, 8, 12, 11, 25),
    ),
  ];

  // ---------------------------------------------------------------------------
  // RESET
  // ---------------------------------------------------------------------------

  static List<AdminReportModel> getReports() {
    return List<AdminReportModel>.from(reports);
  }

  static List<ComplaintModel> getComplaints() {
    return List<ComplaintModel>.from(complaints);
  }
}