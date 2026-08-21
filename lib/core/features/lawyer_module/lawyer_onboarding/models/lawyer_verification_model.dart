
enum LawyerVerificationStatus {
  notSubmitted,
  underReview,
  verified,
  resubmissionRequired,
  rejected,
}

class LawyerVerificationModel {
  final String? barCardFrontPath;
  final String? barCardBackPath;

  final String? idCardFrontPath;
  final String? idCardBackPath;

  final LawyerVerificationStatus status;

  final DateTime? submittedAt;

  final String? verificationNote;

  const LawyerVerificationModel({
    this.barCardFrontPath,
    this.barCardBackPath,
    this.idCardFrontPath,
    this.idCardBackPath,
    this.status = LawyerVerificationStatus.notSubmitted,
    this.submittedAt,
    this.verificationNote,
  });

  LawyerVerificationModel copyWith({
    String? barCardFrontPath,
    String? barCardBackPath,
    String? idCardFrontPath,
    String? idCardBackPath,
    LawyerVerificationStatus? status,
    DateTime? submittedAt,
    String? verificationNote,
  }) {
    return LawyerVerificationModel(
      barCardFrontPath:
          barCardFrontPath ?? this.barCardFrontPath,
      barCardBackPath:
          barCardBackPath ?? this.barCardBackPath,
      idCardFrontPath:
          idCardFrontPath ?? this.idCardFrontPath,
      idCardBackPath:
          idCardBackPath ?? this.idCardBackPath,
      status:
          status ?? this.status,
      submittedAt:
          submittedAt ?? this.submittedAt,
      verificationNote:
          verificationNote ?? this.verificationNote,
    );
  }
}
