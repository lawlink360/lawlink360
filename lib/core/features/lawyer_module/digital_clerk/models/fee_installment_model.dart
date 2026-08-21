class FeeInstallmentModel {
  final String id;
  final double amount;
  final DateTime dueDate;
  final String status;

  // Actual payment information
  final double paidAmount;
  final DateTime? paidDate;
  final String? paymentMethod;
  final String? referenceNumber;
  final String? notes;

  const FeeInstallmentModel({
    required this.id,
    required this.amount,
    required this.dueDate,
    required this.status,
    this.paidAmount = 0,
    this.paidDate,
    this.paymentMethod,
    this.referenceNumber,
    this.notes,
  });

  FeeInstallmentModel copyWith({
    String? id,
    double? amount,
    DateTime? dueDate,
    String? status,
    double? paidAmount,
    DateTime? paidDate,
    String? paymentMethod,
    String? referenceNumber,
    String? notes,
  }) {
    return FeeInstallmentModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidAmount: paidAmount ?? this.paidAmount,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
    );
  }
}