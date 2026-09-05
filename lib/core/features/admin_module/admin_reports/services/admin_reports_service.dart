import '../data/mock/admin_reports_mock_data.dart';
import '../models/admin_report_model.dart';
import '../models/complaint_model.dart';

class AdminReportsService {
  AdminReportsService._();

  static final AdminReportsService instance =
      AdminReportsService._();

  // ---------------------------------------------------------------------------
  // REPORTS
  // ---------------------------------------------------------------------------

  Future<List<AdminReportModel>> fetchReports() async {
    await _simulateDelay();

    return AdminReportsMockData.getReports();
  }

  Future<AdminReportModel?> getReportById(String id) async {
    await _simulateDelay();

    try {
      return AdminReportsMockData.reports.firstWhere(
        (report) => report.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<AdminReportModel>> searchReports(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminReportsMockData.getReports();
    }

    return AdminReportsMockData.reports.where((report) {
      return report.id.toLowerCase().contains(normalizedQuery) ||
          report.title.toLowerCase().contains(normalizedQuery) ||
          report.description.toLowerCase().contains(normalizedQuery) ||
          report.reportType.toLowerCase().contains(normalizedQuery) ||
          report.reporterName.toLowerCase().contains(normalizedQuery) ||
          (report.targetName?.toLowerCase().contains(normalizedQuery) ??
              false);
    }).toList();
  }

  Future<List<AdminReportModel>> filterReports({
    String? status,
    String? priority,
    String? reportType,
  }) async {
    await _simulateDelay();

    var reports = AdminReportsMockData.getReports();

    if (status != null && status != 'All') {
      reports = reports.where((report) {
        return report.status == status;
      }).toList();
    }

    if (priority != null && priority != 'All') {
      reports = reports.where((report) {
        return report.priority == priority;
      }).toList();
    }

    if (reportType != null && reportType != 'All') {
      reports = reports.where((report) {
        return report.reportType == reportType;
      }).toList();
    }

    return reports;
  }

  Future<AdminReportModel> createReport(
    AdminReportModel report,
  ) async {
    await _simulateDelay();

    AdminReportsMockData.reports.insert(0, report);

    return report;
  }

  Future<AdminReportModel?> updateReport(
    AdminReportModel updatedReport,
  ) async {
    await _simulateDelay();

    final index = AdminReportsMockData.reports.indexWhere(
      (report) => report.id == updatedReport.id,
    );

    if (index == -1) {
      return null;
    }

    AdminReportsMockData.reports[index] = updatedReport;

    return updatedReport;
  }

  Future<bool> deleteReport(String id) async {
    await _simulateDelay();

    final initialLength = AdminReportsMockData.reports.length;

    AdminReportsMockData.reports.removeWhere(
      (report) => report.id == id,
    );

    return AdminReportsMockData.reports.length != initialLength;
  }

  Future<AdminReportModel?> updateReportStatus({
    required String id,
    required String status,
    String? resolution,
  }) async {
    await _simulateDelay();

    final index = AdminReportsMockData.reports.indexWhere(
      (report) => report.id == id,
    );

    if (index == -1) {
      return null;
    }

    final currentReport = AdminReportsMockData.reports[index];
    final now = DateTime.now();

    final isFinalStatus =
        status == 'Resolved' ||
        status == 'Rejected' ||
        status == 'Closed';

    final updatedReport = currentReport.copyWith(
      status: status,
      resolution: resolution ?? currentReport.resolution,
      updatedAt: now,
      resolvedAt: isFinalStatus
          ? now
          : currentReport.resolvedAt,
    );

    AdminReportsMockData.reports[index] = updatedReport;

    return updatedReport;
  }

  Future<AdminReportModel?> assignReport({
    required String id,
    required String adminId,
    required String adminName,
  }) async {
    await _simulateDelay();

    final index = AdminReportsMockData.reports.indexWhere(
      (report) => report.id == id,
    );

    if (index == -1) {
      return null;
    }

    final currentReport = AdminReportsMockData.reports[index];

    final updatedReport = currentReport.copyWith(
      assignedTo: adminId,
      assignedToName: adminName,
      updatedAt: DateTime.now(),
      status: currentReport.status == 'Pending'
          ? 'Under Review'
          : currentReport.status,
    );

    AdminReportsMockData.reports[index] = updatedReport;

    return updatedReport;
  }

  // ---------------------------------------------------------------------------
  // COMPLAINTS
  // ---------------------------------------------------------------------------

  Future<List<ComplaintModel>> fetchComplaints() async {
    await _simulateDelay();

    return AdminReportsMockData.getComplaints();
  }

  Future<ComplaintModel?> getComplaintById(String id) async {
    await _simulateDelay();

    try {
      return AdminReportsMockData.complaints.firstWhere(
        (complaint) => complaint.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<ComplaintModel>> searchComplaints(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminReportsMockData.getComplaints();
    }

    return AdminReportsMockData.complaints.where((complaint) {
      return complaint.id.toLowerCase().contains(normalizedQuery) ||
          complaint.subject.toLowerCase().contains(normalizedQuery) ||
          complaint.description.toLowerCase().contains(normalizedQuery) ||
          complaint.category.toLowerCase().contains(normalizedQuery) ||
          complaint.complainantName
              .toLowerCase()
              .contains(normalizedQuery) ||
          (complaint.againstName
                  ?.toLowerCase()
                  .contains(normalizedQuery) ??
              false);
    }).toList();
  }

  Future<List<ComplaintModel>> filterComplaints({
    String? status,
    String? priority,
    String? category,
  }) async {
    await _simulateDelay();

    var complaints = AdminReportsMockData.getComplaints();

    if (status != null && status != 'All') {
      complaints = complaints.where((complaint) {
        return complaint.status == status;
      }).toList();
    }

    if (priority != null && priority != 'All') {
      complaints = complaints.where((complaint) {
        return complaint.priority == priority;
      }).toList();
    }

    if (category != null && category != 'All') {
      complaints = complaints.where((complaint) {
        return complaint.category == category;
      }).toList();
    }

    return complaints;
  }

  Future<ComplaintModel> createComplaint(
    ComplaintModel complaint,
  ) async {
    await _simulateDelay();

    AdminReportsMockData.complaints.insert(
      0,
      complaint,
    );

    return complaint;
  }

  Future<ComplaintModel?> updateComplaint(
    ComplaintModel updatedComplaint,
  ) async {
    await _simulateDelay();

    final index = AdminReportsMockData.complaints.indexWhere(
      (complaint) => complaint.id == updatedComplaint.id,
    );

    if (index == -1) {
      return null;
    }

    AdminReportsMockData.complaints[index] = updatedComplaint;

    return updatedComplaint;
  }

  Future<bool> deleteComplaint(String id) async {
    await _simulateDelay();

    final initialLength =
        AdminReportsMockData.complaints.length;

    AdminReportsMockData.complaints.removeWhere(
      (complaint) => complaint.id == id,
    );

    return AdminReportsMockData.complaints.length !=
        initialLength;
  }

  Future<ComplaintModel?> updateComplaintStatus({
    required String id,
    required String status,
    String? resolution,
  }) async {
    await _simulateDelay();

    final index = AdminReportsMockData.complaints.indexWhere(
      (complaint) => complaint.id == id,
    );

    if (index == -1) {
      return null;
    }

    final currentComplaint =
        AdminReportsMockData.complaints[index];

    final now = DateTime.now();

    final isFinalStatus =
        status == 'Resolved' ||
        status == 'Rejected' ||
        status == 'Closed';

    final updatedComplaint = currentComplaint.copyWith(
      status: status,
      resolution:
          resolution ?? currentComplaint.resolution,
      updatedAt: now,
      resolvedAt: isFinalStatus
          ? now
          : currentComplaint.resolvedAt,
    );

    AdminReportsMockData.complaints[index] =
        updatedComplaint;

    return updatedComplaint;
  }

  Future<ComplaintModel?> assignComplaint({
    required String id,
    required String adminId,
    required String adminName,
  }) async {
    await _simulateDelay();

    final index = AdminReportsMockData.complaints.indexWhere(
      (complaint) => complaint.id == id,
    );

    if (index == -1) {
      return null;
    }

    final currentComplaint =
        AdminReportsMockData.complaints[index];

    final updatedComplaint = currentComplaint.copyWith(
      assignedTo: adminId,
      assignedToName: adminName,
      updatedAt: DateTime.now(),
      status: currentComplaint.status == 'Pending'
          ? 'Under Review'
          : currentComplaint.status,
    );

    AdminReportsMockData.complaints[index] =
        updatedComplaint;

    return updatedComplaint;
  }

  // ---------------------------------------------------------------------------
  // SUMMARY
  // ---------------------------------------------------------------------------

  Future<Map<String, int>> getReportSummary() async {
    await _simulateDelay();

    final reports = AdminReportsMockData.reports;

    return {
      'total': reports.length,
      'pending':
          reports.where((report) => report.status == 'Pending').length,
      'underReview': reports
          .where((report) => report.status == 'Under Review')
          .length,
      'investigating': reports
          .where((report) => report.status == 'Investigating')
          .length,
      'resolved':
          reports.where((report) => report.status == 'Resolved').length,
      'rejected':
          reports.where((report) => report.status == 'Rejected').length,
      'closed':
          reports.where((report) => report.status == 'Closed').length,
      'highPriority': reports.where((report) {
        return report.priority == 'High' ||
            report.priority == 'Critical' ||
            report.priority == 'Urgent';
      }).length,
    };
  }

  Future<Map<String, int>> getComplaintSummary() async {
    await _simulateDelay();

    final complaints = AdminReportsMockData.complaints;

    return {
      'total': complaints.length,
      'pending': complaints
          .where((complaint) => complaint.status == 'Pending')
          .length,
      'underReview': complaints
          .where((complaint) => complaint.status == 'Under Review')
          .length,
      'investigating': complaints
          .where((complaint) => complaint.status == 'Investigating')
          .length,
      'resolved': complaints
          .where((complaint) => complaint.status == 'Resolved')
          .length,
      'rejected': complaints
          .where((complaint) => complaint.status == 'Rejected')
          .length,
      'closed': complaints
          .where((complaint) => complaint.status == 'Closed')
          .length,
    };
  }

  Future<void> resetMockData() async {
  await _simulateDelay();

  // The current mock lists are the working in-memory lists.
  // A true reset source will be introduced when we connect
  // Firestore/backend data.
}

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );
  }
}