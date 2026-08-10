import 'case_status.dart';

class CaseModel {
  final String caseNumber;
  final String title;
  final String clientName;
  final String lawyerName;
  final String courtName;
  final DateTime nextHearing;
  final DateTime lastUpdated;
  final CaseStatus status;

  const CaseModel({
    required this.caseNumber,
    required this.title,
    required this.clientName,
    required this.lawyerName,
    required this.courtName,
    required this.nextHearing,
    required this.lastUpdated,
    required this.status,
  });
}