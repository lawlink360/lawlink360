import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock/admin_payments_mock_data.dart';
import '../models/transaction_model.dart';

final adminTransactionsProvider = NotifierProvider<
    AdminTransactionsNotifier,
    AsyncValue<List<TransactionModel>>>(
  AdminTransactionsNotifier.new,
);

class AdminTransactionsNotifier
    extends Notifier<AsyncValue<List<TransactionModel>>> {
  List<TransactionModel> _allTransactions = [];

  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedType;
  String? _selectedPaymentMethod;

  @override
  AsyncValue<List<TransactionModel>> build() {
    _allTransactions = List<TransactionModel>.from(
      AdminPaymentsMockData.transactions,
    );

    return AsyncData(_allTransactions);
  }

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  String? get selectedType => _selectedType;

  String? get selectedPaymentMethod => _selectedPaymentMethod;

  List<TransactionModel> get filteredTransactions =>
      state.value ?? [];

  int get totalCount => _allTransactions.length;

  int get completedCount =>
      _allTransactions.where((item) => item.status == 'Completed').length;

  int get pendingCount =>
      _allTransactions.where((item) => item.status == 'Pending').length;

  int get failedCount =>
      _allTransactions.where((item) => item.status == 'Failed').length;

  int get refundedCount =>
      _allTransactions.where((item) => item.type == 'Refund').length;

  double get totalTransactionAmount => _allTransactions
      .where((item) => item.status == 'Completed')
      .fold(0, (sum, item) => sum + item.amount);

  void search(String query) {
    _searchQuery = query.trim();
    _emitFiltered();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _emitFiltered();
  }

  void filterByType(String? type) {
    _selectedType = type;
    _emitFiltered();
  }

  void filterByPaymentMethod(String? method) {
    _selectedPaymentMethod = method;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedType = null;
    _selectedPaymentMethod = null;

    _emitFiltered();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    _allTransactions = List<TransactionModel>.from(
      AdminPaymentsMockData.transactions,
    );

    _emitFiltered();
  }

  TransactionModel? getTransactionById(String transactionId) {
    try {
      return _allTransactions.firstWhere(
        (transaction) => transaction.id == transactionId,
      );
    } catch (_) {
      return null;
    }
  }

  List<TransactionModel> getTransactionsByUser(String userId) {
    return _allTransactions
        .where((transaction) => transaction.userId == userId)
        .toList();
  }

  List<TransactionModel> getTransactionsByLawyer(String lawyerId) {
    return _allTransactions
        .where((transaction) => transaction.lawyerId == lawyerId)
        .toList();
  }

  void _emitFiltered() {
    final query = _searchQuery.toLowerCase();

    final filtered = _allTransactions.where((transaction) {
      final matchesSearch = query.isEmpty ||
          transaction.transactionId.toLowerCase().contains(query) ||
          transaction.userName.toLowerCase().contains(query) ||
          transaction.userEmail.toLowerCase().contains(query) ||
          (transaction.lawyerName?.toLowerCase().contains(query) ??
              false) ||
          transaction.description.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == null ||
          transaction.status == _selectedStatus;

      final matchesType =
          _selectedType == null || transaction.type == _selectedType;

      final matchesMethod = _selectedPaymentMethod == null ||
          transaction.paymentMethod == _selectedPaymentMethod;

      return matchesSearch &&
          matchesStatus &&
          matchesType &&
          matchesMethod;
    }).toList();

    state = AsyncData(filtered);
  }
}