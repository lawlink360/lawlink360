import '../models/case_models.dart';
import '../models/case_status.dart';

class CaseData {
  static final List<CaseModel> cases = [
    CaseModel(
      caseNumber: "LL-2026-001",
      title: "Property Partition Case",
      clientName: "Muhammad Ali",
      lawyerName: "Adv. Ahmad Khan",
      courtName: "Civil Court Lahore",
      nextHearing: DateTime(2026, 8, 15),
      lastUpdated: DateTime(2026, 8, 2),
      status: CaseStatus.active,
    ),

    CaseModel(
      caseNumber: "LL-2026-002",
      title: "Family Settlement",
      clientName: "Fatima Noor",
      lawyerName: "Adv. Sarah Malik",
      courtName: "Family Court Islamabad",
      nextHearing: DateTime(2026, 8, 10),
      lastUpdated: DateTime(2026, 8, 1),
      status: CaseStatus.pending,
    ),

    CaseModel(
      caseNumber: "LL-2026-003",
      title: "Rental Agreement Dispute",
      clientName: "Usman Tariq",
      lawyerName: "Adv. Imran Sheikh",
      courtName: "Civil Court Karachi",
      nextHearing: DateTime(2026, 7, 20),
      lastUpdated: DateTime(2026, 7, 22),
      status: CaseStatus.completed,
    ),

    CaseModel(
      caseNumber: "LL-2026-004",
      title: "Inheritance Matter",
      clientName: "Ayesha Siddiqui",
      lawyerName: "Adv. Bilal Ahmed",
      courtName: "District Court Multan",
      nextHearing: DateTime(2026, 6, 18),
      lastUpdated: DateTime(2026, 6, 19),
      status: CaseStatus.archived,
    ),
  ];
}