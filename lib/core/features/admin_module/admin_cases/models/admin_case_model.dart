class AdminCaseModel {
  final String id;
  final String caseNumber;
  final String title;
  final String description;

  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;

  final String lawyerId;
  final String lawyerName;
  final String lawyerSpecialization;

  final String caseType;
  final String courtName;
  final String courtLocation;

  final String status;
  final DateTime filingDate;
  final DateTime? nextHearingDate;

  final double totalFee;
  final double paidAmount;
  final double pendingAmount;

  final String? judgeName;
  final String? notes;

  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminCaseModel({
    required this.id,
    required this.caseNumber,
    required this.title,
    required this.description,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerSpecialization,
    required this.caseType,
    required this.courtName,
    required this.courtLocation,
    required this.status,
    required this.filingDate,
    this.nextHearingDate,
    required this.totalFee,
    required this.paidAmount,
    required this.pendingAmount,
    this.judgeName,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminCaseModel copyWith({
    String? id,
    String? caseNumber,
    String? title,
    String? description,
    String? clientId,
    String? clientName,
    String? clientEmail,
    String? clientPhone,
    String? lawyerId,
    String? lawyerName,
    String? lawyerSpecialization,
    String? caseType,
    String? courtName,
    String? courtLocation,
    String? status,
    DateTime? filingDate,
    DateTime? nextHearingDate,
    double? totalFee,
    double? paidAmount,
    double? pendingAmount,
    String? judgeName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminCaseModel(
      id: id ?? this.id,
      caseNumber: caseNumber ?? this.caseNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientEmail: clientEmail ?? this.clientEmail,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      lawyerSpecialization:
          lawyerSpecialization ?? this.lawyerSpecialization,
      caseType: caseType ?? this.caseType,
      courtName: courtName ?? this.courtName,
      courtLocation: courtLocation ?? this.courtLocation,
      status: status ?? this.status,
      filingDate: filingDate ?? this.filingDate,
      nextHearingDate: nextHearingDate ?? this.nextHearingDate,
      totalFee: totalFee ?? this.totalFee,
      paidAmount: paidAmount ?? this.paidAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      judgeName: judgeName ?? this.judgeName,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caseNumber': caseNumber,
      'title': title,
      'description': description,
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'lawyerSpecialization': lawyerSpecialization,
      'caseType': caseType,
      'courtName': courtName,
      'courtLocation': courtLocation,
      'status': status,
      'filingDate': filingDate.toIso8601String(),
      'nextHearingDate': nextHearingDate?.toIso8601String(),
      'totalFee': totalFee,
      'paidAmount': paidAmount,
      'pendingAmount': pendingAmount,
      'judgeName': judgeName,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminCaseModel.fromMap(Map<String, dynamic> map) {
    return AdminCaseModel(
      id: map['id'] as String? ?? '',
      caseNumber: map['caseNumber'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      clientName: map['clientName'] as String? ?? '',
      clientEmail: map['clientEmail'] as String? ?? '',
      clientPhone: map['clientPhone'] as String? ?? '',
      lawyerId: map['lawyerId'] as String? ?? '',
      lawyerName: map['lawyerName'] as String? ?? '',
      lawyerSpecialization:
          map['lawyerSpecialization'] as String? ?? '',
      caseType: map['caseType'] as String? ?? '',
      courtName: map['courtName'] as String? ?? '',
      courtLocation: map['courtLocation'] as String? ?? '',
      status: map['status'] as String? ?? '',
      filingDate: DateTime.tryParse(
            map['filingDate'] as String? ?? '',
          ) ??
          DateTime.now(),
      nextHearingDate: map['nextHearingDate'] == null
          ? null
          : DateTime.tryParse(
              map['nextHearingDate'] as String,
            ),
      totalFee: (map['totalFee'] as num?)?.toDouble() ?? 0,
      paidAmount: (map['paidAmount'] as num?)?.toDouble() ?? 0,
      pendingAmount: (map['pendingAmount'] as num?)?.toDouble() ?? 0,
      judgeName: map['judgeName'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.tryParse(
            map['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
            map['updatedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }
}