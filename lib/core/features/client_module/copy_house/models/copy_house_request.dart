import 'package:cloud_firestore/cloud_firestore.dart';

/// Immutable model for a Copy House request.
///
/// Backward compatible: Phase 1 documents that lack Phase 2 fields
/// read as empty values via [fromDoc]. Phase 2 documents populate
/// [serviceSubtype] and [serviceDetails].
class CopyHouseRequest {
  final String? id;
  final String serviceId;
  final String serviceSubtype;
  final Map<String, dynamic> serviceDetails;
  final String submittedBy;
  final String status;
  final String caseType;
  final String caseStatus;

  final String firstParty;
  final String secondParty;
  final String caseTitle;

  final String caseNumber;
  final String firNumber;
  final String firYear;
  final String policeStation;
  final String offence;
  final String dated;

  final String courtOrJurisdiction;
  final String judge;

  final String caseDecidedOn;
  final String nextHearingDate;

  final String recordRequested;
  final List<String> recordRequestedList;

  final String purpose;
  final String additionalInformation;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const CopyHouseRequest({
    this.id,
    required this.serviceId,
    this.serviceSubtype = '',
    this.serviceDetails = const <String, dynamic>{},
    required this.submittedBy,
    required this.status,
    required this.caseType,
    required this.caseStatus,
    this.firstParty = '',
    this.secondParty = '',
    this.caseTitle = '',
    this.caseNumber = '',
    this.firNumber = '',
    this.firYear = '',
    this.policeStation = '',
    this.offence = '',
    this.dated = '',
    required this.courtOrJurisdiction,
    this.judge = '',
    this.caseDecidedOn = '',
    this.nextHearingDate = '',
    this.recordRequested = '',
    this.recordRequestedList = const <String>[],
    required this.purpose,
    this.additionalInformation = '',
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toCreateMap() {
    final legacyJoined =
        recordRequestedList.where((s) => s.isNotEmpty).join('\n');

    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceSubtype': serviceSubtype,
      'serviceDetails': serviceDetails,
      'submittedBy': submittedBy,
      'status': status,
      'caseType': caseType,
      'caseStatus': caseStatus,
      'firstParty': firstParty,
      'secondParty': secondParty,
      'caseTitle': caseTitle,
      'caseNumber': caseNumber,
      'firNumber': firNumber,
      'firYear': firYear,
      'policeStation': policeStation,
      'offence': offence,
      'dated': dated,
      'courtOrJurisdiction': courtOrJurisdiction,
      'judge': judge,
      'caseDecidedOn': caseDecidedOn,
      'nextHearingDate': nextHearingDate,
      'recordRequested': recordRequested.isEmpty
          ? legacyJoined
          : recordRequested,
      'recordRequestedList': recordRequestedList,
      'purpose': purpose,
      'additionalInformation': additionalInformation,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory CopyHouseRequest.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    final rawList = data['recordRequestedList'];
    List<String> list;
    if (rawList is List) {
      list = rawList
          .whereType<String>()
          .where((s) => s.trim().isNotEmpty)
          .toList(growable: false);
    } else {
      final legacy = (data['recordRequested'] as String? ?? '').trim();
      list = legacy.isEmpty
          ? const <String>[]
          : legacy.split('\n').where((s) => s.isNotEmpty).toList();
    }

    final rawDetails = data['serviceDetails'];
    final Map<String, dynamic> details = rawDetails is Map
        ? Map<String, dynamic>.from(rawDetails)
        : const <String, dynamic>{};

    return CopyHouseRequest(
      id: doc.id,
      serviceId: data['serviceId'] as String? ?? '',
      serviceSubtype: data['serviceSubtype'] as String? ?? '',
      serviceDetails: details,
      submittedBy: data['submittedBy'] as String? ?? '',
      status: data['status'] as String? ?? '',
      caseType: data['caseType'] as String? ?? '',
      caseStatus: data['caseStatus'] as String? ?? '',
      firstParty: data['firstParty'] as String? ?? '',
      secondParty: data['secondParty'] as String? ?? '',
      caseTitle: data['caseTitle'] as String? ?? '',
      caseNumber: data['caseNumber'] as String? ?? '',
      firNumber: data['firNumber'] as String? ?? '',
      firYear: data['firYear'] as String? ?? '',
      policeStation: data['policeStation'] as String? ?? '',
      offence: data['offence'] as String? ?? '',
      dated: data['dated'] as String? ?? '',
      courtOrJurisdiction:
          data['courtOrJurisdiction'] as String? ?? '',
      judge: data['judge'] as String? ?? '',
      caseDecidedOn: data['caseDecidedOn'] as String? ?? '',
      nextHearingDate: data['nextHearingDate'] as String? ?? '',
      recordRequested: data['recordRequested'] as String? ?? '',
      recordRequestedList: list,
      purpose: data['purpose'] as String? ?? '',
      additionalInformation:
          data['additionalInformation'] as String? ?? '',
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }
}