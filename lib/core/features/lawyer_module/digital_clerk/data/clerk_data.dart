
import '../models/case_model.dart';
import '../models/client_model.dart';
import '../models/document_model.dart';
import '../models/fee_model.dart';
import '../models/schedule_model.dart';
import '../models/task_model.dart';

class ClerkData {
  ClerkData._();

  // ============================================================
  // CLIENTS
  // ============================================================

  static final List<ClientModel> clients = [
    ClientModel(
      id: 'client_001',
      name: 'Muhammad Ahmed',
      phone: '0300-1234567',
      email: 'ahmed@example.com',
      address: 'Lahore, Punjab',
      cnic: '35202-1234567-1',
      notes: 'Civil litigation client.',
      createdAt: DateTime(2026, 8, 1),
      updatedAt: DateTime(2026, 8, 1),
    ),
    ClientModel(
      id: 'client_002',
      name: 'Ali Raza',
      phone: '0312-7654321',
      email: 'ali@example.com',
      address: 'Gujranwala, Punjab',
      cnic: '34101-7654321-3',
      notes: 'Property dispute client.',
      createdAt: DateTime(2026, 8, 3),
      updatedAt: DateTime(2026, 8, 3),
    ),
  ];


// ============================================================
// CASES
// ============================================================

static final List<CaseModel> cases = [
  CaseModel(
    id: 'case_001',
    clientId: 'client_001',
    clientName: 'Muhammad Ahmed',
    caseTitle: 'Ahmed vs. Khan',
    caseNumber: 'CIV-2026-00125',
    courtName: 'Civil Court Lahore',
    caseType: 'Civil',
    oppositeParty: 'Khan',
    judgeName: 'Hon. Judge Muhammad Ali',
    nextHearingDate: DateTime(2026, 8, 12),
    hearingTime: '10:30 AM',
    status: 'Active',
    notes: 'Prepare arguments before next hearing.',
    createdAt: DateTime(2026, 8, 1),
    updatedAt: DateTime(2026, 8, 8),
  ),

  CaseModel(
    id: 'case_002',
    clientId: 'client_002',
    clientName: 'Ali Raza',
    caseTitle: 'Ali Raza vs. Malik',
    caseNumber: 'PROP-2026-00452',
    courtName: 'Lahore High Court',
    caseType: 'Property',
    oppositeParty: 'Malik',
    judgeName: 'Hon. Justice Ahmed Raza',
    nextHearingDate: DateTime(2026, 8, 14),
    hearingTime: '11:00 AM',
    status: 'Active',
    notes: 'Review documents before hearing.',
    createdAt: DateTime(2026, 8, 3),
    updatedAt: DateTime(2026, 8, 8),
  ),
];

  // ============================================================
  // FEES
  // ============================================================

  static final List<FeeModel> fees = [
    FeeModel(
      id: 'fee_001',
      clientId: 'client_001',
      clientName: 'Muhammad Ahmed',
      caseId: 'case_001',
      caseTitle: 'Ahmed vs. Khan',
      totalFee: 100000,
      paidAmount: 60000,
      remainingAmount: 40000,
      dueDate: DateTime(2026, 8, 20),
      paymentStatus: 'Partial',
      notes: 'Second installment pending.',
      createdAt: DateTime(2026, 8, 1),
      updatedAt: DateTime(2026, 8, 8),
    ),
    FeeModel(
      id: 'fee_002',
      clientId: 'client_002',
      clientName: 'Ali Raza',
      caseId: 'case_002',
      caseTitle: 'Ali Raza vs. Malik',
      totalFee: 150000,
      paidAmount: 150000,
      remainingAmount: 0,
      dueDate: null,
      paymentStatus: 'Paid',
      notes: 'Full fee received.',
      createdAt: DateTime(2026, 8, 3),
      updatedAt: DateTime(2026, 8, 8),
    ),
  ];

  // ============================================================
  // DOCUMENTS
  // ============================================================

  static final List<DocumentModel> documents = [
    DocumentModel(
      id: 'document_001',
      name: 'Plaint - Ahmed vs Khan',
      category: 'Pleadings',
      caseId: 'case_001',
      caseTitle: 'Ahmed vs. Khan',
      clientId: 'client_001',
      clientName: 'Muhammad Ahmed',
      filePath: '',
      fileType: 'PDF',
      fileSize: null,
      notes: 'Original plaint document.',
      createdAt: DateTime(2026, 8, 2),
      updatedAt: DateTime(2026, 8, 2),
    ),
    DocumentModel(
      id: 'document_002',
      name: 'Property Documents',
      category: 'Evidence',
      caseId: 'case_002',
      caseTitle: 'Ali Raza vs. Malik',
      clientId: 'client_002',
      clientName: 'Ali Raza',
      filePath: '',
      fileType: 'PDF',
      fileSize: null,
      notes: 'Property ownership documents.',
      createdAt: DateTime(2026, 8, 4),
      updatedAt: DateTime(2026, 8, 4),
    ),
  ];

  // ============================================================
  // SCHEDULE
  // ============================================================

  static final List<ScheduleModel> schedules = [
    ScheduleModel(
      id: 'schedule_001',
      title: 'Court Hearing',
      type: 'Court',
      clientId: 'client_001',
      clientName: 'Muhammad Ahmed',
      caseId: 'case_001',
      caseTitle: 'Ahmed vs. Khan',
      location: 'Civil Court Lahore',
      dateTime: DateTime(2026, 8, 12, 10, 30),
      duration: '1 hour',
      notes: 'Arguments before the court.',
      reminderEnabled: true,
      createdAt: DateTime(2026, 8, 8),
      updatedAt: DateTime(2026, 8, 8),
    ),
    ScheduleModel(
      id: 'schedule_002',
      title: 'Client Meeting',
      type: 'Meeting',
      clientId: 'client_002',
      clientName: 'Ali Raza',
      caseId: 'case_002',
      caseTitle: 'Ali Raza vs. Malik',
      location: 'Law Office',
      dateTime: DateTime(2026, 8, 11, 15, 00),
      duration: '45 minutes',
      notes: 'Review property documents.',
      reminderEnabled: true,
      createdAt: DateTime(2026, 8, 9),
      updatedAt: DateTime(2026, 8, 9),
    ),
  ];

  // ============================================================
  // TASKS
  // ============================================================

  static final List<TaskModel> tasks = [
    TaskModel(
      id: 'task_001',
      title: 'Prepare Arguments',
      description: 'Prepare arguments for the upcoming civil case hearing.',
      priority: 'High',
      status: 'Pending',
      clientId: 'client_001',
      clientName: 'Muhammad Ahmed',
      caseId: 'case_001',
      caseTitle: 'Ahmed vs. Khan',
      dueDate: DateTime(2026, 8, 11),
      reminderEnabled: true,
      createdAt: DateTime(2026, 8, 8),
      updatedAt: DateTime(2026, 8, 8),
    ),
    TaskModel(
      id: 'task_002',
      title: 'Review Property Documents',
      description: 'Review documents before the next hearing.',
      priority: 'Medium',
      status: 'Pending',
      clientId: 'client_002',
      clientName: 'Ali Raza',
      caseId: 'case_002',
      caseTitle: 'Ali Raza vs. Malik',
      dueDate: DateTime(2026, 8, 13),
      reminderEnabled: true,
      createdAt: DateTime(2026, 8, 8),
      updatedAt: DateTime(2026, 8, 8),
    ),
  ];
}
