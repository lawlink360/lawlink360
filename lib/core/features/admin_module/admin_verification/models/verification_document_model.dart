class VerificationDocumentModel {
  final String id;
  final String verificationRequestId;
  final String documentType;
  final String documentName;
  final String documentNumber;
  final String documentUrl;
  final String status;
  final DateTime uploadedAt;
  final String? rejectionReason;

  const VerificationDocumentModel({
    required this.id,
    required this.verificationRequestId,
    required this.documentType,
    required this.documentName,
    required this.documentNumber,
    required this.documentUrl,
    required this.status,
    required this.uploadedAt,
    this.rejectionReason,
  });

  VerificationDocumentModel copyWith({
    String? id,
    String? verificationRequestId,
    String? documentType,
    String? documentName,
    String? documentNumber,
    String? documentUrl,
    String? status,
    DateTime? uploadedAt,
    String? rejectionReason,
  }) {
    return VerificationDocumentModel(
      id: id ?? this.id,
      verificationRequestId:
          verificationRequestId ?? this.verificationRequestId,
      documentType: documentType ?? this.documentType,
      documentName: documentName ?? this.documentName,
      documentNumber: documentNumber ?? this.documentNumber,
      documentUrl: documentUrl ?? this.documentUrl,
      status: status ?? this.status,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'verificationRequestId': verificationRequestId,
      'documentType': documentType,
      'documentName': documentName,
      'documentNumber': documentNumber,
      'documentUrl': documentUrl,
      'status': status,
      'uploadedAt': uploadedAt.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }

  factory VerificationDocumentModel.fromMap(Map<String, dynamic> map) {
    return VerificationDocumentModel(
      id: map['id'] as String? ?? '',
      verificationRequestId:
          map['verificationRequestId'] as String? ?? '',
      documentType: map['documentType'] as String? ?? '',
      documentName: map['documentName'] as String? ?? '',
      documentNumber: map['documentNumber'] as String? ?? '',
      documentUrl: map['documentUrl'] as String? ?? '',
      status: map['status'] as String? ?? '',
      uploadedAt: DateTime.tryParse(
            map['uploadedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      rejectionReason: map['rejectionReason'] as String?,
    );
  }
}