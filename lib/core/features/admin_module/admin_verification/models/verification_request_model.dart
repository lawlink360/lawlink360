class VerificationRequestModel {
  final String id;
  final String applicantId;
  final String applicantName;
  final String email;
  final String phone;
  final String applicantType;
  final String status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? reviewerName;
  final String? rejectionReason;
  final String? notes;

  const VerificationRequestModel({
    required this.id,
    required this.applicantId,
    required this.applicantName,
    required this.email,
    required this.phone,
    required this.applicantType,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.reviewerName,
    this.rejectionReason,
    this.notes,
  });

  VerificationRequestModel copyWith({
    String? id,
    String? applicantId,
    String? applicantName,
    String? email,
    String? phone,
    String? applicantType,
    String? status,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    String? reviewerName,
    String? rejectionReason,
    String? notes,
  }) {
    return VerificationRequestModel(
      id: id ?? this.id,
      applicantId: applicantId ?? this.applicantId,
      applicantName: applicantName ?? this.applicantName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      applicantType: applicantType ?? this.applicantType,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewerName: reviewerName ?? this.reviewerName,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applicantId': applicantId,
      'applicantName': applicantName,
      'email': email,
      'phone': phone,
      'applicantType': applicantType,
      'status': status,
      'submittedAt': submittedAt.toIso8601String(),
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewerName': reviewerName,
      'rejectionReason': rejectionReason,
      'notes': notes,
    };
  }

  factory VerificationRequestModel.fromMap(Map<String, dynamic> map) {
    return VerificationRequestModel(
      id: map['id'] as String? ?? '',
      applicantId: map['applicantId'] as String? ?? '',
      applicantName: map['applicantName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      applicantType: map['applicantType'] as String? ?? '',
      status: map['status'] as String? ?? '',
      submittedAt: DateTime.tryParse(
            map['submittedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      reviewedAt: DateTime.tryParse(
        map['reviewedAt'] as String? ?? '',
      ),
      reviewerName: map['reviewerName'] as String?,
      rejectionReason: map['rejectionReason'] as String?,
      notes: map['notes'] as String?,
    );
  }
}