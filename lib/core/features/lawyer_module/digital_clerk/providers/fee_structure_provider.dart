import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fee_structure_model.dart';
import '../models/fee_item_model.dart';
import '../models/fee_installment_model.dart';

class FeeStructureNotifier
    extends Notifier<List<FeeStructureModel>> {
  @override
  List<FeeStructureModel> build() {
    return [];
  }

  // ======================================================
  // ADD
  // ======================================================

  void addFeeStructure(
    FeeStructureModel feeStructure,
  ) {
    state = [
      ...state,
      feeStructure,
    ];
  }

  // ======================================================
  // UPDATE
  // ======================================================

  void updateFeeStructure(
    FeeStructureModel updatedFeeStructure,
  ) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id ==
            updatedFeeStructure.id)
          updatedFeeStructure
        else
          feeStructure,
    ];
  }

  // ======================================================
  // DELETE
  // ======================================================

  void removeFeeStructure(
    String feeStructureId,
  ) {
    state = state
        .where(
          (feeStructure) =>
              feeStructure.id != feeStructureId,
        )
        .toList();
  }

  // ======================================================
  // ADD FEE ITEM
  // ======================================================

  void addFeeItem({
    required String feeStructureId,
    required FeeItemModel item,
  }) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id == feeStructureId)
          feeStructure.copyWith(
            items: [
              ...feeStructure.items,
              item,
            ],
            totalAmount:
                _calculateTotal([
              ...feeStructure.items,
              item,
            ]),
            updatedAt: DateTime.now(),
          )
        else
          feeStructure,
    ];
  }

  // ======================================================
  // REMOVE FEE ITEM
  // ======================================================

  void removeFeeItem({
    required String feeStructureId,
    required String itemId,
  }) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id == feeStructureId)
          _updateAfterItemChange(
            feeStructure,
            feeStructure.items
                .where(
                  (item) =>
                      item.id != itemId,
                )
                .toList(),
          )
        else
          feeStructure,
    ];
  }

  // ======================================================
  // ADD INSTALLMENT
  // ======================================================

  void addInstallment({
    required String feeStructureId,
    required FeeInstallmentModel installment,
  }) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id == feeStructureId)
          feeStructure.copyWith(
            installments: [
              ...feeStructure.installments,
              installment,
            ],
            updatedAt: DateTime.now(),
          )
        else
          feeStructure,
    ];
  }

  // ======================================================
  // REMOVE INSTALLMENT
  // ======================================================

  void removeInstallment({
    required String feeStructureId,
    required String installmentId,
  }) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id == feeStructureId)
          feeStructure.copyWith(
            installments:
                feeStructure.installments
                    .where(
                      (installment) =>
                          installment.id !=
                          installmentId,
                    )
                    .toList(),
            updatedAt: DateTime.now(),
          )
        else
          feeStructure,
    ];
  }

  // ======================================================
  // UPDATE PAYMENT
  // ======================================================

  void updatePayment({
    required String feeStructureId,
    required double paidAmount,
  }) {
    state = [
      for (final feeStructure in state)
        if (feeStructure.id == feeStructureId)
          feeStructure.copyWith(
            paidAmount: paidAmount,
            remainingAmount:
                feeStructure.totalAmount -
                    paidAmount <
                    0
                ? 0
                : feeStructure.totalAmount -
                    paidAmount,
            updatedAt: DateTime.now(),
          )
        else
          feeStructure,
    ];
  }

  // ======================================================
  // CALCULATE TOTAL
  // ======================================================

  double _calculateTotal(
    List<FeeItemModel> items,
  ) {
    return items.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
  }

  // ======================================================
  // UPDATE AFTER ITEM CHANGE
  // ======================================================

  FeeStructureModel _updateAfterItemChange(
    FeeStructureModel feeStructure,
    List<FeeItemModel> items,
  ) {
    final total = _calculateTotal(items);

    final remaining =
        total - feeStructure.paidAmount;

    return feeStructure.copyWith(
      items: items,
      totalAmount: total,
      remainingAmount:
          remaining < 0 ? 0 : remaining,
      updatedAt: DateTime.now(),
    );
  }
}

// ======================================================
// PROVIDER
// ======================================================

final feeStructureProvider =
    NotifierProvider<
        FeeStructureNotifier,
        List<FeeStructureModel>>(
  FeeStructureNotifier.new,
);