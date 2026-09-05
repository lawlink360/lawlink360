class AdminPaymentModel {
  final String id;
  final String transactionId;

  final String clientId;
  final String clientName;
  final String clientEmail;

  final String lawyerId;
  final String lawyerName;

  final String? appointmentId;
  final String? caseId;

  final double amount;
  final String currency;

  final String paymentMethod;
  final String paymentGateway;
  final String status;

  final String description;

  final double platformFee;
  final double lawyerAmount;

  final String? refundId;
  final double refundedAmount;

  final DateTime paymentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminPaymentModel({
    required this.id,
    required this.transactionId,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.lawyerId,
    required this.lawyerName,
    this.appointmentId,
    this.caseId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.paymentGateway,
    required this.status,
    required this.description,
    required this.platformFee,
    required this.lawyerAmount,
    this.refundId,
    required this.refundedAmount,
    required this.paymentDate,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminPaymentModel copyWith({
    String? id,
    String? transactionId,
    String? clientId,
    String? clientName,
    String? clientEmail,
    String? lawyerId,
    String? lawyerName,
    String? appointmentId,
    String? caseId,
    double? amount,
    String? currency,
    String? paymentMethod,
    String? paymentGateway,
    String? status,
    String? description,
    double? platformFee,
    double? lawyerAmount,
    String? refundId,
    double? refundedAmount,
    DateTime? paymentDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminPaymentModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      appointmentId: appointmentId ?? this.appointmentId,
      caseId: caseId ?? this.caseId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      status: status ?? this.status,
      description: description ?? this.description,
      platformFee: platformFee ?? this.platformFee,
      lawyerAmount: lawyerAmount ?? this.lawyerAmount,
      refundId: refundId ?? this.refundId,
      refundedAmount: refundedAmount ?? this.refundedAmount,
      paymentDate: paymentDate ?? this.paymentDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'clientId': clientId,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'appointmentId': appointmentId,
      'caseId': caseId,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'paymentGateway': paymentGateway,
      'status': status,
      'description': description,
      'platformFee': platformFee,
      'lawyerAmount': lawyerAmount,
      'refundId': refundId,
      'refundedAmount': refundedAmount,
      'paymentDate': paymentDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminPaymentModel.fromMap(Map<String, dynamic> map) {
    return AdminPaymentModel(
      id: map['id'] as String? ?? '',
      transactionId: map['transactionId'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      clientName: map['clientName'] as String? ?? '',
      clientEmail: map['clientEmail'] as String? ?? '',
      lawyerId: map['lawyerId'] as String? ?? '',
      lawyerName: map['lawyerName'] as String? ?? '',
      appointmentId: map['appointmentId'] as String?,
      caseId: map['caseId'] as String?,
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      currency: map['currency'] as String? ?? 'PKR',
      paymentMethod: map['paymentMethod'] as String? ?? '',
      paymentGateway: map['paymentGateway'] as String? ?? '',
      status: map['status'] as String? ?? '',
      description: map['description'] as String? ?? '',
      platformFee: (map['platformFee'] as num?)?.toDouble() ?? 0,
      lawyerAmount: (map['lawyerAmount'] as num?)?.toDouble() ?? 0,
      refundId: map['refundId'] as String?,
      refundedAmount:
          (map['refundedAmount'] as num?)?.toDouble() ?? 0,
      paymentDate: DateTime.tryParse(
            map['paymentDate'] as String? ?? '',
          ) ??
          DateTime.now(),
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