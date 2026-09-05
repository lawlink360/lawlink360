/// Central route names for the LawLink360 Admin Module.
class AdminRoutes {
  AdminRoutes._();

  static const String dashboard = '/admin/dashboard';
  static const String users = '/admin/users';
  static const String userDetails = '/admin/users/details';

  static const String lawyers = '/admin/lawyers';
  static const String lawyerDetails = '/admin/lawyers/details';

  static const String verification = '/admin/verification';

  static const String appointments = '/admin/appointments';
  static const String appointmentDetails =
      '/admin/appointments/details';

  static const String cases = '/admin/cases';
  static const String caseDetails = '/admin/cases/details';

  static const String payments = '/admin/payments';
  static const String transactionDetails =
      '/admin/payments/transaction-details';
  static const String commissions = '/admin/payments/commissions';
  static const String refunds = '/admin/payments/refunds';

  static const String content = '/admin/content';
  static const String lawsContent = '/admin/content/laws';
  static const String judgmentsContent = '/admin/content/judgments';
  static const String proceduresContent = '/admin/content/procedures';
  static const String draftingContent = '/admin/content/drafting';

  static const String reports = '/admin/reports';
  static const String reportDetails = '/admin/reports/details';
  static const String complaints = '/admin/reports/complaints';

  static const String notifications = '/admin/notifications';
  static const String createNotification =
      '/admin/notifications/create';
  static const String notificationHistory =
      '/admin/notifications/history';

  static const String analytics = '/admin/analytics';

  static const String activity = '/admin/activity';
  static const String auditLogs = '/admin/activity/audit-logs';

  static const String settings = '/admin/settings';
  static const String profileSettings =
      '/admin/settings/profile';
  static const String systemSettings =
      '/admin/settings/system';
  static const String roles = '/admin/settings/roles';
  static const String permissions =
      '/admin/settings/permissions';

  static const String login = '/admin/login';
  static const String accessDenied = '/admin/access-denied';
}