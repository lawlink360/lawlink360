import 'fee_item_model.dart';
import 'fee_installment_model.dart';

class FeeStructureModel {
  final String id;

  // ======================================================
  // CLIENT
  // ======================================================

  final String? clientId;
  final String? clientName;

  // ======================================================
  // CASE
  // ======================================================

  final String? caseId;
  final String? caseTitle;
  final String? oppositeParty;
  final String? caseNumber;

  // ======================================================
  // FEE ITEMS
  // ======================================================

  final List<FeeItemModel> items;

  // ======================================================
  // PAYMENT
  // ======================================================

  final double totalAmount;
  final double paidAmount;
  final double remainingAmount;

  // ======================================================
  // INSTALLMENTS
  // ======================================================

  final List<FeeInstallmentModel> installments;

  // ======================================================
  // NOTES
  // ======================================================

  final String notes;

  // ======================================================
  // DATES
  // ======================================================

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dueDate;

  const FeeStructureModel({
    required this.id,
    this.clientId,
    this.clientName,
    this.caseId,
    this.caseTitle,
    this.oppositeParty,
    this.caseNumber,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.installments,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.dueDate,
  });

  // ======================================================
  // COPY WITH
  // ======================================================

  FeeStructureModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    String? oppositeParty,
    String? caseNumber,
    List<FeeItemModel>? items,
    double? totalAmount,
    double? paidAmount,
    double? remainingAmount,
    List<FeeInstallmentModel>? installments,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
  }) {
    return FeeStructureModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      oppositeParty: oppositeParty ?? this.oppositeParty,
      caseNumber: caseNumber ?? this.caseNumber,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      installments: installments ?? this.installments,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}