import '../models/client_activity_model.dart';
import '../models/client_case_summary_model.dart';
import '../models/client_request_model.dart';
import '../models/lawyer_client_model.dart';

class ClientData {
  static final List<LawyerClientModel> clients = [
    LawyerClientModel(
      id: 'client_001',
      name: 'Muhammad Ali',
      imageUrl: null,
      phone: '+92 300 1234567',
      email: 'muhammad.ali@example.com',
      city: 'Lahore',
      caseTitle: 'Property Dispute',
      caseStatus: 'Active',
      lastActivity: 'Document uploaded',
      activeCases: 1,
      totalCases: 2,
      joinedAt: DateTime(2026, 7, 12),
    ),
    LawyerClientModel(
      id: 'client_002',
      name: 'Ayesha Khan',
      imageUrl: null,
      phone: '+92 301 7654321',
      email: 'ayesha.khan@example.com',
      city: 'Islamabad',
      caseTitle: 'Family Matter',
      caseStatus: 'Active',
      lastActivity: 'Consultation completed',
      activeCases: 1,
      totalCases: 1,
      joinedAt: DateTime(2026, 7, 28),
    ),
    LawyerClientModel(
      id: 'client_003',
      name: 'Usman Ahmed',
      imageUrl: null,
      phone: '+92 302 9876543',
      email: 'usman.ahmed@example.com',
      city: 'Rawalpindi',
      caseTitle: 'Civil Suit',
      caseStatus: 'Pending',
      lastActivity: 'Appointment scheduled',
      activeCases: 1,
      totalCases: 1,
      joinedAt: DateTime(2026, 8, 3),
    ),
  ];

  static final List<ClientRequestModel> requests = [
    ClientRequestModel(
      id: 'request_001',
      clientId: 'new_client_001',
      clientName: 'Hamza Malik',
      clientImageUrl: null,
      requestType: 'Legal Consultation',
      message:
          'I need legal assistance regarding a property dispute.',
      requestedAt: DateTime(2026, 8, 13, 10, 30),
    ),
    ClientRequestModel(
      id: 'request_002',
      clientId: 'new_client_002',
      clientName: 'Sara Ahmed',
      clientImageUrl: null,
      requestType: 'Family Law',
      message:
          'I would like to discuss a family legal matter.',
      requestedAt: DateTime(2026, 8, 14, 14, 15),
    ),
  ];

  static final List<ClientActivityModel> activities = [
    ClientActivityModel(
      id: 'activity_001',
      clientId: 'client_001',
      title: 'Document Uploaded',
      description:
          'Muhammad Ali uploaded a new case document.',
      type: 'document',
      createdAt: DateTime(2026, 8, 14, 11, 30),
    ),
    ClientActivityModel(
      id: 'activity_002',
      clientId: 'client_002',
      title: 'Consultation Completed',
      description:
          'Consultation with Ayesha Khan was completed.',
      type: 'consultation',
      createdAt: DateTime(2026, 8, 13, 15, 45),
    ),
    ClientActivityModel(
      id: 'activity_003',
      clientId: 'client_003',
      title: 'Appointment Scheduled',
      description:
          'An appointment was scheduled with Usman Ahmed.',
      type: 'appointment',
      createdAt: DateTime(2026, 8, 12, 9, 20),
    ),
  ];

  static final List<ClientCaseSummaryModel> cases = [
    ClientCaseSummaryModel(
      caseId: 'case_001',
      clientId: 'client_001',
      caseTitle: 'Property Dispute',
      caseNumber: 'Civil Suit No. 123/2026',
      court: 'Lahore High Court',
      caseType: 'Civil',
      status: 'Active',
      nextHearingDate: DateTime(2026, 8, 25),
      lastUpdate: 'Document uploaded',
    ),
    ClientCaseSummaryModel(
      caseId: 'case_002',
      clientId: 'client_001',
      caseTitle: 'Inheritance Matter',
      caseNumber: 'Civil Suit No. 87/2026',
      court: 'District Courts Lahore',
      caseType: 'Civil',
      status: 'Active',
      nextHearingDate: DateTime(2026, 9, 2),
      lastUpdate: 'Case documents reviewed',
    ),
    ClientCaseSummaryModel(
      caseId: 'case_003',
      clientId: 'client_002',
      caseTitle: 'Family Matter',
      caseNumber: 'Family Suit No. 45/2026',
      court: 'Family Court Islamabad',
      caseType: 'Family',
      status: 'Active',
      nextHearingDate: DateTime(2026, 8, 29),
      lastUpdate: 'Consultation completed',
    ),
  ];
}