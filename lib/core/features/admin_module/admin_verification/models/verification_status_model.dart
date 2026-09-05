class VerificationStatusModel {
  final String value;
  final String label;

  const VerificationStatusModel({
    required this.value,
    required this.label,
  });

  static const pending = VerificationStatusModel(
    value: 'pending',
    label: 'Pending',
  );

  static const underReview = VerificationStatusModel(
    value: 'under_review',
    label: 'Under Review',
  );

  static const approved = VerificationStatusModel(
    value: 'approved',
    label: 'Approved',
  );

  static const rejected = VerificationStatusModel(
    value: 'rejected',
    label: 'Rejected',
  );

  static const List<VerificationStatusModel> all = [
    pending,
    underReview,
    approved,
    rejected,
  ];

  static VerificationStatusModel fromValue(String value) {
    return all.firstWhere(
      (status) => status.value == value,
      orElse: () => pending,
    );
  }

  bool get isPending => value == pending.value;

  bool get isUnderReview => value == underReview.value;

  bool get isApproved => value == approved.value;

  bool get isRejected => value == rejected.value;
}