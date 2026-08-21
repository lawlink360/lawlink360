import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/clerk_data.dart';
import '../models/case_model.dart';
import '../models/client_model.dart';
import '../models/document_model.dart';
import '../models/fee_model.dart';
import '../models/schedule_model.dart';
import '../models/task_model.dart';

// ======================================================
// CLIENTS
// ======================================================

class ClerkClientsNotifier extends StateNotifier<List<ClientModel>> {
  ClerkClientsNotifier()
      : super(List<ClientModel>.from(ClerkData.clients));

  void addClient(ClientModel newClient) {
    state = [...state, newClient];
  }

  void updateClient(ClientModel updatedClient) {
    state = [
      for (final client in state)
        if (client.id == updatedClient.id)
          updatedClient
        else
          client,
    ];
  }

  void deleteClient(String clientId) {
    state = state
        .where((client) => client.id != clientId)
        .toList();
  }
}

final clerkClientsProvider =
    StateNotifierProvider<ClerkClientsNotifier, List<ClientModel>>((ref) {
  return ClerkClientsNotifier();
});

// ======================================================
// CASES
// ======================================================

final clerkCasesProvider =
    StateNotifierProvider<ClerkCasesNotifier, List<CaseModel>>((ref) {
  return ClerkCasesNotifier();
});

class ClerkCasesNotifier extends StateNotifier<List<CaseModel>> {
  ClerkCasesNotifier() : super(List<CaseModel>.from(ClerkData.cases));

  void addCase(CaseModel newCase) {
    state = [...state, newCase];
  }

  void updateCase(CaseModel updatedCase) {
    state = [
      for (final caseItem in state)
        if (caseItem.id == updatedCase.id) updatedCase else caseItem,
    ];
  }

  void deleteCase(String caseId) {
    state = state.where((caseItem) => caseItem.id != caseId).toList();
  }
}

// ======================================================
// FEES
// ======================================================

final clerkFeesProvider =
    NotifierProvider<ClerkFeesNotifier, List<FeeModel>>(
  ClerkFeesNotifier.new,
);

class ClerkFeesNotifier extends Notifier<List<FeeModel>> {
  @override
  List<FeeModel> build() {
    return List<FeeModel>.from(ClerkData.fees);
  }

  void addFee(FeeModel fee) {
    state = [...state, fee];
  }

  void updateFee(FeeModel updatedFee) {
    state = [
      for (final fee in state)
        if (fee.id == updatedFee.id)
          updatedFee
        else
          fee,
    ];
  }

  void recordPayment({
    required String feeId,
    required double amount,
    required DateTime paymentDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
  }) {
    state = [
      for (final fee in state)
        if (fee.id == feeId)
          (() {
            final newPaidAmount = fee.paidAmount + amount;

            final newRemainingAmount =
                (fee.totalFee - newPaidAmount).clamp(0, double.infinity);

            final newStatus =
                newRemainingAmount <= 0 ? 'Paid' : 'Partially Paid';

            return fee.copyWith(
              paidAmount: newPaidAmount,
              remainingAmount: newRemainingAmount.toDouble(),
              paymentStatus: newStatus,
              updatedAt: DateTime.now(),
              notes: [
                fee.notes,
                'Payment: Rs. ${amount.toStringAsFixed(0)}',
                'Date: ${paymentDate.day.toString().padLeft(2, '0')}/'
                    '${paymentDate.month.toString().padLeft(2, '0')}/'
                    '${paymentDate.year}',
                'Method: $paymentMethod',
                if (referenceNumber != null &&
                    referenceNumber.trim().isNotEmpty)
                  'Reference: ${referenceNumber.trim()}',
                if (notes != null && notes.trim().isNotEmpty)
                  'Note: ${notes.trim()}',
              ].where((item) => item.trim().isNotEmpty).join('\n'),
            );
          })()
        else
          fee,
    ];
  }

  void removeFee(String feeId) {
    state = state.where((item) => item.id != feeId).toList();
  }
}

// ======================================================
// DOCUMENTS
// ======================================================

final clerkDocumentsProvider =
    NotifierProvider<ClerkDocumentsNotifier, List<DocumentModel>>(
  ClerkDocumentsNotifier.new,
);

class ClerkDocumentsNotifier extends Notifier<List<DocumentModel>> {
  @override
  List<DocumentModel> build() {
    return List<DocumentModel>.from(ClerkData.documents);
  }

  void addDocument(DocumentModel document) {
    state = [...state, document];
  }

  void removeDocument(String documentId) {
    state = state.where((item) => item.id != documentId).toList();
  }
}

// ======================================================
// SCHEDULES
// ======================================================

final clerkSchedulesProvider =
    NotifierProvider<ClerkSchedulesNotifier, List<ScheduleModel>>(
  ClerkSchedulesNotifier.new,
);

class ClerkSchedulesNotifier extends Notifier<List<ScheduleModel>> {
  @override
  List<ScheduleModel> build() {
    return List<ScheduleModel>.from(ClerkData.schedules);
  }

  void addSchedule(ScheduleModel schedule) {
    state = [...state, schedule];
  }

  void removeSchedule(String scheduleId) {
    state = state.where((item) => item.id != scheduleId).toList();
  }
}

// ======================================================
// TASKS
// ======================================================

final clerkTasksProvider =
    NotifierProvider<ClerkTasksNotifier, List<TaskModel>>(
  ClerkTasksNotifier.new,
);

class ClerkTasksNotifier extends Notifier<List<TaskModel>> {
  @override
  List<TaskModel> build() {
    return List<TaskModel>.from(ClerkData.tasks);
  }

  void addTask(TaskModel task) {
    state = [...state, task];
  }

  void updateTask(TaskModel updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id)
          updatedTask
        else
          task,
    ];
  }

  void removeTask(String taskId) {
    state = state
        .where((task) => task.id != taskId)
        .toList();
  }
}