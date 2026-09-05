class AdminAppointmentModel {
  final String id;
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String lawyerId;
  final String lawyerName;
  final String lawyerSpecialization;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String appointmentType;
  final String status;
  final double fee;
  final String paymentStatus;
  final String? caseId;
  final String? caseTitle;
  final String? notes;
  final DateTime createdAt;

  const AdminAppointmentModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerSpecialization,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
    required this.status,
    required this.fee,
    required this.paymentStatus,
    this.caseId,
    this.caseTitle,
    this.notes,
    required this.createdAt,
  });

  AdminAppointmentModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientEmail,
    String? clientPhone,
    String? lawyerId,
    String? lawyerName,
    String? lawyerSpecialization,
    DateTime? appointmentDate,
    String? appointmentTime,
    String? appointmentType,
    String? status,
    double? fee,
    String? paymentStatus,
    String? caseId,
    String? caseTitle,
    String? notes,
    DateTime? createdAt,
  }) {
    return AdminAppointmentModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      clientPhone: clientPhone ?? this.clientPhone,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      lawyerSpecialization:
          lawyerSpecialization ?? this.lawyerSpecialization,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentType: appointmentType ?? this.appointmentType,
      status: status ?? this.status,
      fee: fee ?? this.fee,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'lawyerSpecialization': lawyerSpecialization,
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'appointmentType': appointmentType,
      'status': status,
      'fee': fee,
      'paymentStatus': paymentStatus,
      'caseId': caseId,
      'caseTitle': caseTitle,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AdminAppointmentModel.fromMap(Map<String, dynamic> map) {
    return AdminAppointmentModel(
      id: map['id'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      clientName: map['clientName'] as String? ?? '',
      clientEmail: map['clientEmail'] as String? ?? '',
      clientPhone: map['clientPhone'] as String? ?? '',
      lawyerId: map['lawyerId'] as String? ?? '',
      lawyerName: map['lawyerName'] as String? ?? '',
      lawyerSpecialization:
          map['lawyerSpecialization'] as String? ?? '',
      appointmentDate: DateTime.tryParse(
            map['appointmentDate'] as String? ?? '',
          ) ??
          DateTime.now(),
      appointmentTime: map['appointmentTime'] as String? ?? '',
      appointmentType: map['appointmentType'] as String? ?? '',
      status: map['status'] as String? ?? '',
      fee: (map['fee'] as num?)?.toDouble() ?? 0,
      paymentStatus: map['paymentStatus'] as String? ?? '',
      caseId: map['caseId'] as String?,
      caseTitle: map['caseTitle'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.tryParse(
            map['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }
}