import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_activity_mock_data.dart';
import '../models/admin_activity_model.dart';
import '../models/audit_log_model.dart';

final adminActivityProvider = NotifierProvider<AdminActivityNotifier,
    AsyncValue<List<AdminActivityModel>>>(
  AdminActivityNotifier.new,
);

final adminAuditLogProvider = NotifierProvider<AdminAuditLogNotifier,
    AsyncValue<List<AuditLogModel>>>(
  AdminAuditLogNotifier.new,
);

class AdminActivityNotifier
    extends Notifier<AsyncValue<List<AdminActivityModel>>> {
  List<AdminActivityModel> _activities = [];
  String _searchQuery = '';
  String _categoryFilter = 'All';

  @override
  AsyncValue<List<AdminActivityModel>> build() {
    _activities = AdminActivityMockData.getActivities();

    return AsyncValue.data(_activities);
  }

  String get searchQuery => _searchQuery;

  String get categoryFilter => _categoryFilter;

  List<AdminActivityModel> get activities =>
      List<AdminActivityModel>.unmodifiable(_activities);

  List<AdminActivityModel> get filteredActivities {
    final query = _searchQuery.trim().toLowerCase();

    return _activities.where((activity) {
      final matchesSearch = query.isEmpty ||
          activity.action.toLowerCase().contains(query) ||
          activity.description.toLowerCase().contains(query) ||
          activity.adminName.toLowerCase().contains(query) ||
          activity.category.toLowerCase().contains(query) ||
          (activity.targetName?.toLowerCase().contains(query) ?? false);

      final matchesCategory = _categoryFilter == 'All' ||
          activity.category == _categoryFilter;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<String> get categories {
    final values = _activities
        .map((activity) => activity.category)
        .where((category) => category.trim().isNotEmpty)
        .toSet()
        .toList();

    values.sort();
    return ['All', ...values];
  }

  int get totalActivities => _activities.length;

  int get todayActivities {
    final now = DateTime.now();

    return _activities.where((activity) {
      return activity.createdAt.year == now.year &&
          activity.createdAt.month == now.month &&
          activity.createdAt.day == now.day;
    }).length;
  }

  int get authenticationActivities {
    return _activities
        .where((activity) => activity.category == 'Authentication')
        .length;
  }

  int get paymentActivities {
    return _activities
        .where((activity) => activity.category == 'Payments')
        .length;
  }

  int get verificationActivities {
    return _activities
        .where((activity) => activity.category == 'Verification')
        .length;
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _categoryFilter = 'All';
    _emitFiltered();
  }

  AdminActivityModel? getActivityById(String id) {
    try {
      return _activities.firstWhere(
        (activity) => activity.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    _activities = AdminActivityMockData.getActivities();
    _emitFiltered();
  }

  void _emitFiltered() {
    state = AsyncValue.data(filteredActivities);
  }
}

class AdminAuditLogNotifier
    extends Notifier<AsyncValue<List<AuditLogModel>>> {
  List<AuditLogModel> _auditLogs = [];
  String _searchQuery = '';
  String _categoryFilter = 'All';

  @override
  AsyncValue<List<AuditLogModel>> build() {
    _auditLogs = AdminActivityMockData.getAuditLogs();

    return AsyncValue.data(_auditLogs);
  }

  String get searchQuery => _searchQuery;

  String get categoryFilter => _categoryFilter;

  List<AuditLogModel> get auditLogs =>
      List<AuditLogModel>.unmodifiable(_auditLogs);

  List<AuditLogModel> get filteredAuditLogs {
    final query = _searchQuery.trim().toLowerCase();

    return _auditLogs.where((log) {
      final matchesSearch = query.isEmpty ||
          log.action.toLowerCase().contains(query) ||
          log.category.toLowerCase().contains(query) ||
          log.actorName.toLowerCase().contains(query) ||
          (log.targetName?.toLowerCase().contains(query) ?? false) ||
          (log.metadata?.toLowerCase().contains(query) ?? false);

      final matchesCategory =
          _categoryFilter == 'All' || log.category == _categoryFilter;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<String> get categories {
    final values = _auditLogs
        .map((log) => log.category)
        .where((category) => category.trim().isNotEmpty)
        .toSet()
        .toList();

    values.sort();
    return ['All', ...values];
  }

  int get totalAuditLogs => _auditLogs.length;

  int get statusChanges {
    return _auditLogs
        .where(
          (log) => log.action.toLowerCase().contains('status'),
        )
        .length;
  }

  int get authenticationLogs {
    return _auditLogs
        .where((log) => log.category == 'Authentication')
        .length;
  }

  int get paymentLogs {
    return _auditLogs
        .where((log) => log.category == 'Payments')
        .length;
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _categoryFilter = 'All';
    _emitFiltered();
  }

  AuditLogModel? getAuditLogById(String id) {
    try {
      return _auditLogs.firstWhere(
        (log) => log.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    _auditLogs = AdminActivityMockData.getAuditLogs();
    _emitFiltered();
  }

  void _emitFiltered() {
    state = AsyncValue.data(filteredAuditLogs);
  }
}