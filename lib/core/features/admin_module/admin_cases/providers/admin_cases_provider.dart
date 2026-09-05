import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_cases_mock_data.dart';
import '../models/admin_case_model.dart';
import '../models/case_status_model.dart';

final adminCasesProvider =
    NotifierProvider<AdminCasesNotifier, AsyncValue<List<AdminCaseModel>>>(
  AdminCasesNotifier.new,
);

class AdminCasesNotifier
    extends Notifier<AsyncValue<List<AdminCaseModel>>> {
  List<AdminCaseModel> _allCases = [];

  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedCaseType;

  @override
  AsyncValue<List<AdminCaseModel>> build() {
    _allCases = List<AdminCaseModel>.from(
      AdminCasesMockData.cases,
    );

    return AsyncData(_allCases);
  }

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  String? get selectedCaseType => _selectedCaseType;

  List<AdminCaseModel> get filteredCases {
    return _applyFilters(_allCases);
  }

  int get totalCount => _allCases.length;

  int get pendingCount => _allCases
      .where((caseItem) => caseItem.status == CaseStatusModel.pending)
      .length;

  int get activeCount => _allCases
      .where((caseItem) => caseItem.status == CaseStatusModel.active)
      .length;

  int get onHoldCount => _allCases
      .where((caseItem) => caseItem.status == CaseStatusModel.onHold)
      .length;

  int get closedCount => _allCases
      .where((caseItem) => caseItem.status == CaseStatusModel.closed)
      .length;

  int get dismissedCount => _allCases
      .where((caseItem) => caseItem.status == CaseStatusModel.dismissed)
      .length;

  double get totalCaseValue {
    return _allCases.fold(
      0,
      (total, caseItem) => total + caseItem.totalFee,
    );
  }

  double get totalPaidAmount {
    return _allCases.fold(
      0,
      (total, caseItem) => total + caseItem.paidAmount,
    );
  }

  double get totalPendingAmount {
    return _allCases.fold(
      0,
      (total, caseItem) => total + caseItem.pendingAmount,
    );
  }

  void search(String query) {
    _searchQuery = query.trim();
    _emitFiltered();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _emitFiltered();
  }

  void filterByCaseType(String? caseType) {
    _selectedCaseType = caseType;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedCaseType = null;
    _emitFiltered();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    _allCases = List<AdminCaseModel>.from(
      AdminCasesMockData.cases,
    );

    _emitFiltered();
  }

  void updateCaseStatus(String caseId, String status) {
    final index = _allCases.indexWhere(
      (caseItem) => caseItem.id == caseId,
    );

    if (index == -1) {
      return;
    }

    final existingCase = _allCases[index];

    _allCases[index] = existingCase.copyWith(
      status: CaseStatusModel.fromValue(status),
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  AdminCaseModel? getCaseById(String caseId) {
    for (final caseItem in _allCases) {
      if (caseItem.id == caseId) {
        return caseItem;
      }
    }

    return null;
  }

  List<AdminCaseModel> _applyFilters(
    List<AdminCaseModel> cases,
  ) {
    final query = _searchQuery.toLowerCase();

    return cases.where((caseItem) {
      final matchesSearch =
          query.isEmpty ||
          caseItem.caseNumber.toLowerCase().contains(query) ||
          caseItem.title.toLowerCase().contains(query) ||
          caseItem.clientName.toLowerCase().contains(query) ||
          caseItem.lawyerName.toLowerCase().contains(query) ||
          caseItem.caseType.toLowerCase().contains(query) ||
          caseItem.courtName.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == null ||
          _selectedStatus == CaseStatusModel.all ||
          caseItem.status == _selectedStatus;

      final matchesCaseType =
          _selectedCaseType == null ||
          _selectedCaseType == 'All' ||
          caseItem.caseType == _selectedCaseType;

      return matchesSearch &&
          matchesStatus &&
          matchesCaseType;
    }).toList();
  }

  void _emitFiltered() {
    state = AsyncData(_applyFilters(_allCases));
  }
}