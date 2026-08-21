class ClientCaseSummaryModel {
  final String caseId;
  final String clientId;
  final String caseTitle;
  final String caseNumber;
  final String court;
  final String caseType;
  final String status;
  final DateTime? nextHearingDate;
  final String? lastUpdate;

  const ClientCaseSummaryModel({
    required this.caseId,
    required this.clientId,
    required this.caseTitle,
    required this.caseNumber,
    required this.court,
    required this.caseType,
    required this.status,
    this.nextHearingDate,
    this.lastUpdate,
  });

  ClientCaseSummaryModel copyWith({
    String? caseId,
    String? clientId,
    String? caseTitle,
    String? caseNumber,
    String? court,
    String? caseType,
    String? status,
    DateTime? nextHearingDate,
    String? lastUpdate,
  }) {
    return ClientCaseSummaryModel(
      caseId: caseId ?? this.caseId,
      clientId: clientId ?? this.clientId,
      caseTitle: caseTitle ?? this.caseTitle,
      caseNumber: caseNumber ?? this.caseNumber,
      court: court ?? this.court,
      caseType: caseType ?? this.caseType,
      status: status ?? this.status,
      nextHearingDate: nextHearingDate ?? this.nextHearingDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}