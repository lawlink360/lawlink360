class FeeModel {
  final String id;
  final String clientId;
  final String clientName;
  final String? caseId;
  final String? caseTitle;
  final double totalFee;
  final double paidAmount;
  final double remainingAmount;
  final DateTime? dueDate;
  final String paymentStatus;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FeeModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.caseId,
    this.caseTitle,
    required this.totalFee,
    required this.paidAmount,
    required this.remainingAmount,
    this.dueDate,
    required this.paymentStatus,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  FeeModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    double? totalFee,
    double? paidAmount,
    double? remainingAmount,
    DateTime? dueDate,
    String? paymentStatus,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeeModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      totalFee: totalFee ?? this.totalFee,
      paidAmount: paidAmount ?? this.paidAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      dueDate: dueDate ?? this.dueDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}