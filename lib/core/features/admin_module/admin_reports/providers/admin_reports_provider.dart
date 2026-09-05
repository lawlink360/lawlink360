import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_reports_mock_data.dart';
import '../models/admin_report_model.dart';
import '../models/complaint_model.dart';
import '../models/report_status_model.dart';

final adminReportsProvider =
    NotifierProvider<AdminReportsNotifier, AsyncValue<List<AdminReportModel>>>(
  AdminReportsNotifier.new,
);

final adminComplaintsProvider =
    NotifierProvider<AdminComplaintsNotifier, AsyncValue<List<ComplaintModel>>>(
  AdminComplaintsNotifier.new,
);

class AdminReportsNotifier
    extends Notifier<AsyncValue<List<AdminReportModel>>> {
  String _searchQuery = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _typeFilter = 'All';

  @override
  AsyncValue<List<AdminReportModel>> build() {
    return AsyncValue.data(
      List<AdminReportModel>.from(
        AdminReportsMockData.reports,
      ),
    );
  }

  String get searchQuery => _searchQuery;

  String get statusFilter => _statusFilter;

  String get priorityFilter => _priorityFilter;

  String get typeFilter => _typeFilter;

  List<AdminReportModel> get reports {
    final currentState = state;

    if (currentState is! AsyncData<List<AdminReportModel>>) {
      return [];
    }

    return currentState.value;
  }

  List<AdminReportModel> get filteredReports {
    var result = List<AdminReportModel>.from(reports);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();

      result = result.where((report) {
        return report.id.toLowerCase().contains(query) ||
            report.title.toLowerCase().contains(query) ||
            report.description.toLowerCase().contains(query) ||
            report.reportType.toLowerCase().contains(query) ||
            report.reporterName.toLowerCase().contains(query) ||
            (report.targetName?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (_statusFilter != 'All') {
      result = result.where((report) {
        return report.status == _statusFilter;
      }).toList();
    }

    if (_priorityFilter != 'All') {
      result = result.where((report) {
        return report.priority == _priorityFilter;
      }).toList();
    }

    if (_typeFilter != 'All') {
      result = result.where((report) {
        return report.reportType == _typeFilter;
      }).toList();
    }

    return result;
  }

  int get totalReports => reports.length;

  int get pendingReports => reports.where((report) {
        return report.status == ReportStatus.pending.label;
      }).length;

  int get underReviewReports => reports.where((report) {
        return report.status == ReportStatus.underReview.label;
      }).length;

  int get investigatingReports => reports.where((report) {
        return report.status == ReportStatus.investigating.label;
      }).length;

  int get resolvedReports => reports.where((report) {
        return report.status == ReportStatus.resolved.label;
      }).length;

  int get rejectedReports => reports.where((report) {
        return report.status == ReportStatus.rejected.label;
      }).length;

  int get closedReports => reports.where((report) {
        return report.status == ReportStatus.closed.label;
      }).length;

  int get highPriorityReports => reports.where((report) {
        return report.priority == 'High' ||
            report.priority == 'Critical' ||
            report.priority == 'Urgent';
      }).length;

  List<String> get reportTypes {
    final types = reports
        .map((report) => report.reportType)
        .where((type) => type.trim().isNotEmpty)
        .toSet()
        .toList();

    types.sort();

    return types;
  }

  void search(String query) {
    _searchQuery = query;
    _refreshState();
  }

  void setStatusFilter(String status) {
    _statusFilter = status;
    _refreshState();
  }

  void setPriorityFilter(String priority) {
    _priorityFilter = priority;
    _refreshState();
  }

  void setTypeFilter(String type) {
    _typeFilter = type;
    _refreshState();
  }

  void clearFilters() {
    _searchQuery = '';
    _statusFilter = 'All';
    _priorityFilter = 'All';
    _typeFilter = 'All';
    _refreshState();
  }

  AdminReportModel? getReportById(String id) {
    for (final report in reports) {
      if (report.id == id) {
        return report;
      }
    }

    return null;
  }

  void updateReportStatus(
    String id,
    String status, {
    String? resolution,
  }) {
    final index = reports.indexWhere(
      (report) => report.id == id,
    );

    if (index == -1) {
      return;
    }

    final report = reports[index];
    final now = DateTime.now();

    final updatedReport = report.copyWith(
      status: status,
      resolution: resolution ?? report.resolution,
      updatedAt: now,
      resolvedAt: status == ReportStatus.resolved.label ||
              status == ReportStatus.rejected.label ||
              status == ReportStatus.closed.label
          ? now
          : report.resolvedAt,
    );

    final updatedReports = List<AdminReportModel>.from(reports);
    updatedReports[index] = updatedReport;

    state = AsyncValue.data(updatedReports);
  }

  void assignReport(
    String id,
    String adminId,
    String adminName,
  ) {
    final index = reports.indexWhere(
      (report) => report.id == id,
    );

    if (index == -1) {
      return;
    }

    final report = reports[index];

    final updatedReport = report.copyWith(
      assignedTo: adminId,
      assignedToName: adminName,
      updatedAt: DateTime.now(),
      status: report.status == ReportStatus.pending.label
          ? ReportStatus.underReview.label
          : report.status,
    );

    final updatedReports = List<AdminReportModel>.from(reports);
    updatedReports[index] = updatedReport;

    state = AsyncValue.data(updatedReports);
  }

  void deleteReport(String id) {
    final updatedReports = reports
        .where((report) => report.id != id)
        .toList();

    state = AsyncValue.data(updatedReports);
  }

  void addReport(AdminReportModel report) {
    final updatedReports = [
      report,
      ...reports,
    ];

    state = AsyncValue.data(updatedReports);
  }

  void updateReport(AdminReportModel updatedReport) {
    final index = reports.indexWhere(
      (report) => report.id == updatedReport.id,
    );

    if (index == -1) {
      return;
    }

    final updatedReports = List<AdminReportModel>.from(reports);
    updatedReports[index] = updatedReport;

    state = AsyncValue.data(updatedReports);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    state = AsyncValue.data(
      List<AdminReportModel>.from(
        AdminReportsMockData.reports,
      ),
    );
  }

  void _refreshState() {
    final currentReports = reports;

    state = AsyncValue.data(
      List<AdminReportModel>.from(currentReports),
    );
  }
}

class AdminComplaintsNotifier
    extends Notifier<AsyncValue<List<ComplaintModel>>> {
  String _searchQuery = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _categoryFilter = 'All';

  @override
  AsyncValue<List<ComplaintModel>> build() {
    return AsyncValue.data(
      List<ComplaintModel>.from(
        AdminReportsMockData.complaints,
      ),
    );
  }

  String get searchQuery => _searchQuery;

  String get statusFilter => _statusFilter;

  String get priorityFilter => _priorityFilter;

  String get categoryFilter => _categoryFilter;

  List<ComplaintModel> get complaints {
    final currentState = state;

    if (currentState is! AsyncData<List<ComplaintModel>>) {
      return [];
    }

    return currentState.value;
  }

  List<ComplaintModel> get filteredComplaints {
    var result = List<ComplaintModel>.from(complaints);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();

      result = result.where((complaint) {
        return complaint.id.toLowerCase().contains(query) ||
            complaint.subject.toLowerCase().contains(query) ||
            complaint.description.toLowerCase().contains(query) ||
            complaint.category.toLowerCase().contains(query) ||
            complaint.complainantName.toLowerCase().contains(query) ||
            (complaint.againstName?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    if (_statusFilter != 'All') {
      result = result.where((complaint) {
        return complaint.status == _statusFilter;
      }).toList();
    }

    if (_priorityFilter != 'All') {
      result = result.where((complaint) {
        return complaint.priority == _priorityFilter;
      }).toList();
    }

    if (_categoryFilter != 'All') {
      result = result.where((complaint) {
        return complaint.category == _categoryFilter;
      }).toList();
    }

    return result;
  }

  int get totalComplaints => complaints.length;

  int get pendingComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.pending.label;
      }).length;

  int get underReviewComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.underReview.label;
      }).length;

  int get investigatingComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.investigating.label;
      }).length;

  int get resolvedComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.resolved.label;
      }).length;

  int get rejectedComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.rejected.label;
      }).length;

  int get closedComplaints => complaints.where((complaint) {
        return complaint.status == ReportStatus.closed.label;
      }).length;

  List<String> get complaintCategories {
    final categories = complaints
        .map((complaint) => complaint.category)
        .where((category) => category.trim().isNotEmpty)
        .toSet()
        .toList();

    categories.sort();

    return categories;
  }

  void search(String query) {
    _searchQuery = query;
    _refreshState();
  }

  void setStatusFilter(String status) {
    _statusFilter = status;
    _refreshState();
  }

  void setPriorityFilter(String priority) {
    _priorityFilter = priority;
    _refreshState();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    _refreshState();
  }

  void clearFilters() {
    _searchQuery = '';
    _statusFilter = 'All';
    _priorityFilter = 'All';
    _categoryFilter = 'All';
    _refreshState();
  }

  ComplaintModel? getComplaintById(String id) {
    for (final complaint in complaints) {
      if (complaint.id == id) {
        return complaint;
      }
    }

    return null;
  }

  void updateComplaintStatus(
    String id,
    String status, {
    String? resolution,
  }) {
    final index = complaints.indexWhere(
      (complaint) => complaint.id == id,
    );

    if (index == -1) {
      return;
    }

    final complaint = complaints[index];
    final now = DateTime.now();

    final updatedComplaint = complaint.copyWith(
      status: status,
      resolution: resolution ?? complaint.resolution,
      updatedAt: now,
      resolvedAt: status == ReportStatus.resolved.label ||
              status == ReportStatus.rejected.label ||
              status == ReportStatus.closed.label
          ? now
          : complaint.resolvedAt,
    );

    final updatedComplaints = List<ComplaintModel>.from(
      complaints,
    );

    updatedComplaints[index] = updatedComplaint;

    state = AsyncValue.data(updatedComplaints);
  }

  void assignComplaint(
    String id,
    String adminId,
    String adminName,
  ) {
    final index = complaints.indexWhere(
      (complaint) => complaint.id == id,
    );

    if (index == -1) {
      return;
    }

    final complaint = complaints[index];

    final updatedComplaint = complaint.copyWith(
      assignedTo: adminId,
      assignedToName: adminName,
      updatedAt: DateTime.now(),
      status: complaint.status == ReportStatus.pending.label
          ? ReportStatus.underReview.label
          : complaint.status,
    );

    final updatedComplaints = List<ComplaintModel>.from(
      complaints,
    );

    updatedComplaints[index] = updatedComplaint;

    state = AsyncValue.data(updatedComplaints);
  }

  void deleteComplaint(String id) {
    final updatedComplaints = complaints
        .where((complaint) => complaint.id != id)
        .toList();

    state = AsyncValue.data(updatedComplaints);
  }

  void addComplaint(ComplaintModel complaint) {
    final updatedComplaints = [
      complaint,
      ...complaints,
    ];

    state = AsyncValue.data(updatedComplaints);
  }

  void updateComplaint(ComplaintModel updatedComplaint) {
    final index = complaints.indexWhere(
      (complaint) => complaint.id == updatedComplaint.id,
    );

    if (index == -1) {
      return;
    }

    final updatedComplaints = List<ComplaintModel>.from(
      complaints,
    );

    updatedComplaints[index] = updatedComplaint;

    state = AsyncValue.data(updatedComplaints);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    state = AsyncValue.data(
      List<ComplaintModel>.from(
        AdminReportsMockData.complaints,
      ),
    );
  }

  void _refreshState() {
    final currentComplaints = complaints;

    state = AsyncValue.data(
      List<ComplaintModel>.from(currentComplaints),
    );
  }
}