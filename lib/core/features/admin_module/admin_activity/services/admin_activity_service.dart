import '../data/mock/admin_activity_mock_data.dart';
import '../models/admin_activity_model.dart';
import '../models/audit_log_model.dart';

class AdminActivityService {
  AdminActivityService._();

  static final AdminActivityService instance =
      AdminActivityService._();

  Future<List<AdminActivityModel>> fetchActivities() async {
    await _simulateDelay();

    return AdminActivityMockData.getActivities();
  }

  Future<List<AuditLogModel>> fetchAuditLogs() async {
    await _simulateDelay();

    return AdminActivityMockData.getAuditLogs();
  }

  Future<AdminActivityModel?> getActivityById(String id) async {
    await _simulateDelay();

    try {
      return AdminActivityMockData.activities.firstWhere(
        (activity) => activity.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<AuditLogModel?> getAuditLogById(String id) async {
    await _simulateDelay();

    try {
      return AdminActivityMockData.auditLogs.firstWhere(
        (log) => log.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<AdminActivityModel>> searchActivities(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminActivityMockData.getActivities();
    }

    return AdminActivityMockData.activities.where((activity) {
      return activity.action.toLowerCase().contains(normalizedQuery) ||
          activity.description
              .toLowerCase()
              .contains(normalizedQuery) ||
          activity.adminName.toLowerCase().contains(normalizedQuery) ||
          activity.category.toLowerCase().contains(normalizedQuery) ||
          (activity.targetName
                  ?.toLowerCase()
                  .contains(normalizedQuery) ??
              false);
    }).toList();
  }

  Future<List<AuditLogModel>> searchAuditLogs(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminActivityMockData.getAuditLogs();
    }

    return AdminActivityMockData.auditLogs.where((log) {
      return log.action.toLowerCase().contains(normalizedQuery) ||
          log.category.toLowerCase().contains(normalizedQuery) ||
          log.actorName.toLowerCase().contains(normalizedQuery) ||
          (log.targetName
                  ?.toLowerCase()
                  .contains(normalizedQuery) ??
              false) ||
          (log.metadata
                  ?.toLowerCase()
                  .contains(normalizedQuery) ??
              false);
    }).toList();
  }

  Future<List<AdminActivityModel>> filterActivitiesByCategory(
    String category,
  ) async {
    await _simulateDelay();

    if (category == 'All') {
      return AdminActivityMockData.getActivities();
    }

    return AdminActivityMockData.activities
        .where(
          (activity) => activity.category == category,
        )
        .toList();
  }

  Future<List<AuditLogModel>> filterAuditLogsByCategory(
    String category,
  ) async {
    await _simulateDelay();

    if (category == 'All') {
      return AdminActivityMockData.getAuditLogs();
    }

    return AdminActivityMockData.auditLogs
        .where(
          (log) => log.category == category,
        )
        .toList();
  }

  Future<List<AdminActivityModel>> getActivitiesByAdmin(
    String adminId,
  ) async {
    await _simulateDelay();

    return AdminActivityMockData.activities
        .where(
          (activity) => activity.adminId == adminId,
        )
        .toList();
  }

  Future<List<AuditLogModel>> getAuditLogsByActor(
    String actorId,
  ) async {
    await _simulateDelay();

    return AdminActivityMockData.auditLogs
        .where(
          (log) => log.actorId == actorId,
        )
        .toList();
  }

  Future<List<AdminActivityModel>> getActivitiesByTarget(
    String targetId,
  ) async {
    await _simulateDelay();

    return AdminActivityMockData.activities
        .where(
          (activity) => activity.targetId == targetId,
        )
        .toList();
  }

  Future<List<AuditLogModel>> getAuditLogsByTarget(
    String targetId,
  ) async {
    await _simulateDelay();

    return AdminActivityMockData.auditLogs
        .where(
          (log) => log.targetId == targetId,
        )
        .toList();
  }

  Future<int> getTotalActivities() async {
    await _simulateDelay();

    return AdminActivityMockData.activities.length;
  }

  Future<int> getTotalAuditLogs() async {
    await _simulateDelay();

    return AdminActivityMockData.auditLogs.length;
  }

  Future<Map<String, int>> getActivitySummary() async {
    await _simulateDelay();

    final activities = AdminActivityMockData.activities;

    return {
      'total': activities.length,
      'authentication': activities
          .where((activity) => activity.category == 'Authentication')
          .length,
      'users': activities
          .where((activity) => activity.category == 'Users')
          .length,
      'lawyers': activities
          .where((activity) => activity.category == 'Lawyers')
          .length,
      'verification': activities
          .where((activity) => activity.category == 'Verification')
          .length,
      'appointments': activities
          .where((activity) => activity.category == 'Appointments')
          .length,
      'cases': activities
          .where((activity) => activity.category == 'Cases')
          .length,
      'payments': activities
          .where((activity) => activity.category == 'Payments')
          .length,
      'reports': activities
          .where((activity) => activity.category == 'Reports')
          .length,
      'notifications': activities
          .where((activity) => activity.category == 'Notifications')
          .length,
      'settings': activities
          .where((activity) => activity.category == 'Settings')
          .length,
    };
  }

  Future<void> resetMockData() async {
    await _simulateDelay();

    // The current mock lists are the working in-memory source.
    // A true reset source will be introduced when Firestore
    // becomes the backend data source.
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );
  }
}