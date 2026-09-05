import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_payments_mock_data.dart';
import '../models/admin_payment_model.dart';

final adminPaymentsProvider =
    NotifierProvider<AdminPaymentsNotifier, AsyncValue<List<AdminPaymentModel>>>(
  AdminPaymentsNotifier.new,
);

class AdminPaymentsNotifier
    extends Notifier<AsyncValue<List<AdminPaymentModel>>> {
  List<AdminPaymentModel> _allPayments = [];

  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedPaymentMethod;
  String? _selectedPaymentGateway;

  @override
  AsyncValue<List<AdminPaymentModel>> build() {
    _allPayments = List<AdminPaymentModel>.from(
      AdminPaymentsMockData.payments,
    );

    return AsyncData(_allPayments);
  }

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  String? get selectedPaymentMethod => _selectedPaymentMethod;

  String? get selectedPaymentGateway => _selectedPaymentGateway;

  List<AdminPaymentModel> get filteredPayments => state.value ?? [];

  int get totalCount => _allPayments.length;

  int get completedCount =>
      _allPayments.where((payment) => payment.status == 'Completed').length;

  int get pendingCount =>
      _allPayments.where((payment) => payment.status == 'Pending').length;

  int get refundedCount =>
      _allPayments.where((payment) => payment.status == 'Refunded').length;

  int get failedCount =>
      _allPayments.where((payment) => payment.status == 'Failed').length;

  double get totalRevenue => _allPayments
      .where((payment) => payment.status == 'Completed')
      .fold(0, (sum, payment) => sum + payment.amount);

  double get totalPlatformFees => _allPayments
      .where((payment) => payment.status == 'Completed')
      .fold(0, (sum, payment) => sum + payment.platformFee);

  double get totalLawyerPayouts => _allPayments
      .where((payment) => payment.status == 'Completed')
      .fold(0, (sum, payment) => sum + payment.lawyerAmount);

  double get totalRefunded =>
      _allPayments.fold(0, (sum, payment) => sum + payment.refundedAmount);

  void search(String query) {
    _searchQuery = query.trim();
    _emitFiltered();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _emitFiltered();
  }

  void filterByPaymentMethod(String? method) {
    _selectedPaymentMethod = method;
    _emitFiltered();
  }

  void filterByPaymentGateway(String? gateway) {
    _selectedPaymentGateway = gateway;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedPaymentMethod = null;
    _selectedPaymentGateway = null;

    _emitFiltered();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    _allPayments = List<AdminPaymentModel>.from(
      AdminPaymentsMockData.payments,
    );

    _emitFiltered();
  }

  Future<void> updatePaymentStatus(
    String paymentId,
    String status,
  ) async {
    final index = _allPayments.indexWhere(
      (payment) => payment.id == paymentId,
    );

    if (index == -1) {
      return;
    }

    _allPayments[index] = _allPayments[index].copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  AdminPaymentModel? getPaymentById(String paymentId) {
    try {
      return _allPayments.firstWhere(
        (payment) => payment.id == paymentId,
      );
    } catch (_) {
      return null;
    }
  }

  List<AdminPaymentModel> getPaymentsByClient(String clientId) {
    return _allPayments
        .where((payment) => payment.clientId == clientId)
        .toList();
  }

  List<AdminPaymentModel> getPaymentsByLawyer(String lawyerId) {
    return _allPayments
        .where((payment) => payment.lawyerId == lawyerId)
        .toList();
  }

  void _emitFiltered() {
    final query = _searchQuery.toLowerCase();

    final filtered = _allPayments.where((payment) {
      final matchesSearch = query.isEmpty ||
          payment.transactionId.toLowerCase().contains(query) ||
          payment.clientName.toLowerCase().contains(query) ||
          payment.clientEmail.toLowerCase().contains(query) ||
          payment.lawyerName.toLowerCase().contains(query) ||
          payment.description.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == null ||
          payment.status == _selectedStatus;

      final matchesMethod = _selectedPaymentMethod == null ||
          payment.paymentMethod == _selectedPaymentMethod;

      final matchesGateway = _selectedPaymentGateway == null ||
          payment.paymentGateway == _selectedPaymentGateway;

      return matchesSearch &&
          matchesStatus &&
          matchesMethod &&
          matchesGateway;
    }).toList();

    state = AsyncData(filtered);
  }
}