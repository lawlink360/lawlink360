class CaseModel {
  final String id;
  final String caseTitle;
  final String caseNumber;
  final String clientId;
  final String clientName;
  final String courtName;
  final String caseType;
  final String oppositeParty;
  final String judgeName;
  final DateTime? nextHearingDate;
  final String? hearingTime;
  final String status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CaseModel({
    required this.id,
    required this.caseTitle,
    required this.caseNumber,
    required this.clientId,
    required this.clientName,
    required this.courtName,
    required this.caseType,
    required this.oppositeParty,
    required this.judgeName,
    this.nextHearingDate,
    this.hearingTime,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  CaseModel copyWith({
    String? id,
    String? caseTitle,
    String? caseNumber,
    String? clientId,
    String? clientName,
    String? courtName,
    String? caseType,
    String? oppositeParty,
    String? judgeName,
    DateTime? nextHearingDate,
    String? hearingTime,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CaseModel(
      id: id ?? this.id,
      caseTitle: caseTitle ?? this.caseTitle,
      caseNumber: caseNumber ?? this.caseNumber,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      courtName: courtName ?? this.courtName,
      caseType: caseType ?? this.caseType,
      oppositeParty: oppositeParty ?? this.oppositeParty,
      judgeName: judgeName ?? this.judgeName,
      nextHearingDate: nextHearingDate ?? this.nextHearingDate,
      hearingTime: hearingTime ?? this.hearingTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}