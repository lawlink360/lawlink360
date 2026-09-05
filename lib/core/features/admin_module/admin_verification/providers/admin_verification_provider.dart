import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/data/mock/admin_verification_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_request_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_status_model.dart';

final adminVerificationProvider = NotifierProvider<
    AdminVerificationNotifier,
    AsyncValue<List<VerificationRequestModel>>>(
  AdminVerificationNotifier.new,
);

class AdminVerificationNotifier
    extends Notifier<AsyncValue<List<VerificationRequestModel>>> {
  List<VerificationRequestModel> _allRequests = [];
  String _searchQuery = '';
  String? _selectedStatus;

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  @override
  AsyncValue<List<VerificationRequestModel>> build() {
    _allRequests = List<VerificationRequestModel>.from(
      AdminVerificationMockData.requests,
    );

    return AsyncValue.data(List<VerificationRequestModel>.from(_allRequests));
  }

  void search(String query) {
    _searchQuery = query.trim();
    _applyFilters();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _applyFilters();
  }

  void refresh() {
    state = const AsyncValue.loading();

    Future<void>.delayed(
      const Duration(milliseconds: 300),
      () {
        _allRequests = List<VerificationRequestModel>.from(
          AdminVerificationMockData.requests,
        );

        _applyFilters();
      },
    );
  }

  void updateStatus(
    String requestId,
    String status, {
    String? rejectionReason,
    String? reviewerName,
    String? notes,
  }) {
    final index = _allRequests.indexWhere(
      (request) => request.id == requestId,
    );

    if (index == -1) {
      return;
    }

    final request = _allRequests[index];

    _allRequests[index] = request.copyWith(
      status: status,
      reviewedAt: status == VerificationStatusModel.pending.value
          ? null
          : DateTime.now(),
      reviewerName: reviewerName,
      rejectionReason: rejectionReason,
      notes: notes,
    );

    _applyFilters();
  }

  List<VerificationRequestModel> get filteredRequests {
    return _getFilteredRequests();
  }

  int get pendingCount => _allRequests
      .where(
        (request) => request.status == VerificationStatusModel.pending.value,
      )
      .length;

  int get underReviewCount => _allRequests
      .where(
        (request) =>
            request.status == VerificationStatusModel.underReview.value,
      )
      .length;

  int get approvedCount => _allRequests
      .where(
        (request) => request.status == VerificationStatusModel.approved.value,
      )
      .length;

  int get rejectedCount => _allRequests
      .where(
        (request) => request.status == VerificationStatusModel.rejected.value,
      )
      .length;

  List<VerificationRequestModel> _getFilteredRequests() {
    Iterable<VerificationRequestModel> results = _allRequests;

    if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
      results = results.where(
        (request) => request.status == _selectedStatus,
      );
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      results = results.where(
        (request) =>
            request.applicantName.toLowerCase().contains(query) ||
            request.email.toLowerCase().contains(query) ||
            request.phone.toLowerCase().contains(query) ||
            request.applicantId.toLowerCase().contains(query),
      );
    }

    return List<VerificationRequestModel>.from(results);
  }

  void _applyFilters() {
    state = AsyncValue.data(_getFilteredRequests());
  }
}