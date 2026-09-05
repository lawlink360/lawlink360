import '../data/mock/admin_payments_mock_data.dart';
import '../models/admin_payment_model.dart';
import '../models/commission_model.dart';
import '../models/refund_model.dart';
import '../models/transaction_model.dart';

class AdminPaymentsService {
  AdminPaymentsService._();

  static final AdminPaymentsService instance =
      AdminPaymentsService._();

  List<AdminPaymentModel> _payments = List<AdminPaymentModel>.from(
    AdminPaymentsMockData.payments,
  );

  List<CommissionModel> _commissions = List<CommissionModel>.from(
    AdminPaymentsMockData.commissions,
  );

  List<RefundModel> _refunds = List<RefundModel>.from(
    AdminPaymentsMockData.refunds,
  );

  List<TransactionModel> _transactions =
      List<TransactionModel>.from(
    AdminPaymentsMockData.transactions,
  );

  // ---------------------------------------------------------------------------
  // PAYMENTS
  // ---------------------------------------------------------------------------

  Future<List<AdminPaymentModel>> fetchPayments() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List<AdminPaymentModel>.from(_payments);
  }

  Future<List<AdminPaymentModel>> refreshPayments() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _payments = List<AdminPaymentModel>.from(
      AdminPaymentsMockData.payments,
    );

    return List<AdminPaymentModel>.from(_payments);
  }

  Future<AdminPaymentModel?> getPaymentById(String paymentId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    for (final payment in _payments) {
      if (payment.id == paymentId) {
        return payment;
      }
    }

    return null;
  }

  Future<List<AdminPaymentModel>> searchPayments(
    String query,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<AdminPaymentModel>.from(_payments);
    }

    return _payments.where((payment) {
      return payment.id.toLowerCase().contains(normalizedQuery) ||
          payment.transactionId
              .toLowerCase()
              .contains(normalizedQuery) ||
          payment.clientName
              .toLowerCase()
              .contains(normalizedQuery) ||
          payment.clientEmail
              .toLowerCase()
              .contains(normalizedQuery) ||
          payment.lawyerName
              .toLowerCase()
              .contains(normalizedQuery) ||
          payment.description
              .toLowerCase()
              .contains(normalizedQuery);
    }).toList();
  }

  Future<List<AdminPaymentModel>> filterByStatus(
    String status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _payments
        .where(
          (payment) =>
              payment.status.toLowerCase() ==
              status.toLowerCase(),
        )
        .toList();
  }

  Future<List<AdminPaymentModel>> filterByPaymentMethod(
    String paymentMethod,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _payments
        .where(
          (payment) =>
              payment.paymentMethod.toLowerCase() ==
              paymentMethod.toLowerCase(),
        )
        .toList();
  }

  Future<List<AdminPaymentModel>> filterByPaymentGateway(
    String gateway,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _payments
        .where(
          (payment) =>
              payment.paymentGateway.toLowerCase() ==
              gateway.toLowerCase(),
        )
        .toList();
  }

  Future<bool> updatePaymentStatus(
    String paymentId,
    String status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final index = _payments.indexWhere(
      (payment) => payment.id == paymentId,
    );

    if (index == -1) {
      return false;
    }

    _payments[index] = _payments[index].copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );

    return true;
  }

  Future<List<AdminPaymentModel>> getPaymentsByClient(
    String clientId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _payments
        .where((payment) => payment.clientId == clientId)
        .toList();
  }

  Future<List<AdminPaymentModel>> getPaymentsByLawyer(
    String lawyerId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _payments
        .where((payment) => payment.lawyerId == lawyerId)
        .toList();
  }

  // ---------------------------------------------------------------------------
  // COMMISSIONS
  // ---------------------------------------------------------------------------

  Future<List<CommissionModel>> fetchCommissions() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return List<CommissionModel>.from(_commissions);
  }

  Future<List<CommissionModel>> getCommissionsByLawyer(
    String lawyerId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _commissions
        .where((commission) => commission.lawyerId == lawyerId)
        .toList();
  }

  // ---------------------------------------------------------------------------
  // REFUNDS
  // ---------------------------------------------------------------------------

  Future<List<RefundModel>> fetchRefunds() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return List<RefundModel>.from(_refunds);
  }

  Future<RefundModel?> getRefundById(String refundId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    for (final refund in _refunds) {
      if (refund.id == refundId) {
        return refund;
      }
    }

    return null;
  }

  Future<bool> updateRefundStatus(
    String refundId,
    String status, {
    String? processedBy,
    String? notes,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final index = _refunds.indexWhere(
      (refund) => refund.id == refundId,
    );

    if (index == -1) {
      return false;
    }

    final refund = _refunds[index];
    final now = DateTime.now();

    _refunds[index] = refund.copyWith(
      status: status,
      processedBy: processedBy ?? refund.processedBy,
      notes: notes ?? refund.notes,
      processedAt: status.toLowerCase() == 'pending'
          ? refund.processedAt
          : now,
      updatedAt: now,
    );

    // A completed refund also updates its related payment.
    if (status.toLowerCase() == 'completed') {
      final paymentIndex = _payments.indexWhere(
        (payment) => payment.id == refund.paymentId,
      );

      if (paymentIndex != -1) {
        final payment = _payments[paymentIndex];

        _payments[paymentIndex] = payment.copyWith(
          status: 'Refunded',
          refundId: refund.id,
          refundedAmount:
              payment.refundedAmount + refund.refundAmount,
          updatedAt: now,
        );
      }
    }

    return true;
  }

  // ---------------------------------------------------------------------------
  // TRANSACTIONS
  // ---------------------------------------------------------------------------

  Future<List<TransactionModel>> fetchTransactions() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return List<TransactionModel>.from(_transactions);
  }

  Future<TransactionModel?> getTransactionById(
    String transactionId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    for (final transaction in _transactions) {
      if (transaction.id == transactionId ||
          transaction.transactionId == transactionId) {
        return transaction;
      }
    }

    return null;
  }

  Future<List<TransactionModel>> searchTransactions(
    String query,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<TransactionModel>.from(_transactions);
    }

    return _transactions.where((transaction) {
      return transaction.id.toLowerCase().contains(
            normalizedQuery,
          ) ||
          transaction.transactionId.toLowerCase().contains(
                normalizedQuery,
              ) ||
          transaction.userName.toLowerCase().contains(
                normalizedQuery,
              ) ||
          transaction.userEmail.toLowerCase().contains(
                normalizedQuery,
              ) ||
          (transaction.lawyerName?.toLowerCase().contains(
                normalizedQuery,
              ) ??
              false) ||
          transaction.description.toLowerCase().contains(
                normalizedQuery,
              ) ||
          (transaction.reference?.toLowerCase().contains(
                normalizedQuery,
              ) ??
              false);
    }).toList();
  }

  Future<List<TransactionModel>> filterTransactionsByStatus(
    String status,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _transactions
        .where(
          (transaction) =>
              transaction.status.toLowerCase() ==
              status.toLowerCase(),
        )
        .toList();
  }

  Future<List<TransactionModel>> filterTransactionsByType(
    String type,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _transactions
        .where(
          (transaction) =>
              transaction.type.toLowerCase() ==
              type.toLowerCase(),
        )
        .toList();
  }

  Future<List<TransactionModel>>
      filterTransactionsByPaymentMethod(
    String paymentMethod,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _transactions
        .where(
          (transaction) =>
              transaction.paymentMethod.toLowerCase() ==
              paymentMethod.toLowerCase(),
        )
        .toList();
  }
}