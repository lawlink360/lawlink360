import '../data/mock/admin_cases_mock_data.dart';
import '../models/admin_case_model.dart';
import '../models/case_status_model.dart';

class AdminCasesService {
  AdminCasesService._();

  static final AdminCasesService instance = AdminCasesService._();

  List<AdminCaseModel> _cases = List<AdminCaseModel>.from(
    AdminCasesMockData.cases,
  );

  /// Fetch all cases.
  Future<List<AdminCaseModel>> fetchCases() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return List<AdminCaseModel>.from(_cases);
  }

  /// Refresh cases from the current data source.
  Future<List<AdminCaseModel>> refreshCases() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    _cases = List<AdminCaseModel>.from(AdminCasesMockData.cases);

    return List<AdminCaseModel>.from(_cases);
  }

  /// Get a single case by ID.
  Future<AdminCaseModel?> getCaseById(String caseId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    try {
      return _cases.firstWhere((caseItem) => caseItem.id == caseId);
    } catch (_) {
      return null;
    }
  }

  /// Search cases by number, title, client, lawyer,
  /// case type, or court.
  Future<List<AdminCaseModel>> searchCases(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<AdminCaseModel>.from(_cases);
    }

    return _cases.where((caseItem) {
      return caseItem.caseNumber.toLowerCase().contains(normalizedQuery) ||
          caseItem.title.toLowerCase().contains(normalizedQuery) ||
          caseItem.clientName.toLowerCase().contains(normalizedQuery) ||
          caseItem.lawyerName.toLowerCase().contains(normalizedQuery) ||
          caseItem.caseType.toLowerCase().contains(normalizedQuery) ||
          caseItem.courtName.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  /// Filter cases by status.
  Future<List<AdminCaseModel>> filterByStatus(String status) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    if (status == CaseStatusModel.all) {
      return List<AdminCaseModel>.from(_cases);
    }

    return _cases
        .where((caseItem) => caseItem.status == status)
        .toList();
  }

  /// Filter cases by case type.
  Future<List<AdminCaseModel>> filterByCaseType(String caseType) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    if (caseType.isEmpty || caseType == 'All') {
      return List<AdminCaseModel>.from(_cases);
    }

    return _cases
        .where((caseItem) => caseItem.caseType == caseType)
        .toList();
  }

  /// Update the status of a case.
  Future<AdminCaseModel?> updateCaseStatus(
    String caseId,
    String status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final index = _cases.indexWhere(
      (caseItem) => caseItem.id == caseId,
    );

    if (index == -1) {
      return null;
    }

    final updatedCase = _cases[index].copyWith(
      status: CaseStatusModel.fromValue(status),
      updatedAt: DateTime.now(),
    );

    _cases[index] = updatedCase;

    return updatedCase;
  }

  /// Get all cases belonging to a specific client.
  Future<List<AdminCaseModel>> getCasesByClient(
    String clientId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return _cases
        .where((caseItem) => caseItem.clientId == clientId)
        .toList();
  }

  /// Get all cases assigned to a specific lawyer.
  Future<List<AdminCaseModel>> getCasesByLawyer(
    String lawyerId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return _cases
        .where((caseItem) => caseItem.lawyerId == lawyerId)
        .toList();
  }

  /// Get all cases registered in a specific court.
  Future<List<AdminCaseModel>> getCasesByCourt(
    String courtName,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    return _cases
        .where((caseItem) => caseItem.courtName == courtName)
        .toList();
  }

  /// Get cases with upcoming hearings.
  Future<List<AdminCaseModel>> getUpcomingHearings() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final now = DateTime.now();

    return _cases
        .where(
          (caseItem) =>
              caseItem.nextHearingDate != null &&
              caseItem.nextHearingDate!.isAfter(now),
        )
        .toList()
      ..sort(
        (a, b) => a.nextHearingDate!.compareTo(b.nextHearingDate!),
      );
  }
}