class CommissionModel {
  final String id;
  final String paymentId;
  final String transactionId;

  final String lawyerId;
  final String lawyerName;

  final double paymentAmount;
  final double commissionRate;
  final double commissionAmount;
  final double lawyerAmount;

  final String status;
  final DateTime createdAt;
  final DateTime? paidAt;

  const CommissionModel({
    required this.id,
    required this.paymentId,
    required this.transactionId,
    required this.lawyerId,
    required this.lawyerName,
    required this.paymentAmount,
    required this.commissionRate,
    required this.commissionAmount,
    required this.lawyerAmount,
    required this.status,
    required this.createdAt,
    this.paidAt,
  });

  CommissionModel copyWith({
    String? id,
    String? paymentId,
    String? transactionId,
    String? lawyerId,
    String? lawyerName,
    double? paymentAmount,
    double? commissionRate,
    double? commissionAmount,
    double? lawyerAmount,
    String? status,
    DateTime? createdAt,
    DateTime? paidAt,
  }) {
    return CommissionModel(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      transactionId: transactionId ?? this.transactionId,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionAmount: commissionAmount ?? this.commissionAmount,
      lawyerAmount: lawyerAmount ?? this.lawyerAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentId': paymentId,
      'transactionId': transactionId,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'paymentAmount': paymentAmount,
      'commissionRate': commissionRate,
      'commissionAmount': commissionAmount,
      'lawyerAmount': lawyerAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'paidAt': paidAt?.toIso8601String(),
    };
  }

  factory CommissionModel.fromMap(Map<String, dynamic> map) {
    return CommissionModel(
      id: map['id'] as String? ?? '',
      paymentId: map['paymentId'] as String? ?? '',
      transactionId: map['transactionId'] as String? ?? '',
      lawyerId: map['lawyerId'] as String? ?? '',
      lawyerName: map['lawyerName'] as String? ?? '',
      paymentAmount:
          (map['paymentAmount'] as num?)?.toDouble() ?? 0,
      commissionRate:
          (map['commissionRate'] as num?)?.toDouble() ?? 0,
      commissionAmount:
          (map['commissionAmount'] as num?)?.toDouble() ?? 0,
      lawyerAmount:
          (map['lawyerAmount'] as num?)?.toDouble() ?? 0,
      status: map['status'] as String? ?? '',
      createdAt: DateTime.tryParse(
            map['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      paidAt: map['paidAt'] != null
          ? DateTime.tryParse(map['paidAt'] as String)
          : null,
    );
  }
}