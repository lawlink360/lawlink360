class RefundModel {
  final String id;
  final String paymentId;
  final String transactionId;

  final String clientId;
  final String clientName;

  final String lawyerId;
  final String lawyerName;

  final double originalAmount;
  final double refundAmount;

  final String reason;
  final String status;
  final String? processedBy;
  final String? notes;

  final DateTime requestedAt;
  final DateTime? processedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RefundModel({
    required this.id,
    required this.paymentId,
    required this.transactionId,
    required this.clientId,
    required this.clientName,
    required this.lawyerId,
    required this.lawyerName,
    required this.originalAmount,
    required this.refundAmount,
    required this.reason,
    required this.status,
    this.processedBy,
    this.notes,
    required this.requestedAt,
    this.processedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  RefundModel copyWith({
    String? id,
    String? paymentId,
    String? transactionId,
    String? clientId,
    String? clientName,
    String? lawyerId,
    String? lawyerName,
    double? originalAmount,
    double? refundAmount,
    String? reason,
    String? status,
    String? processedBy,
    String? notes,
    DateTime? requestedAt,
    DateTime? processedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RefundModel(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      transactionId: transactionId ?? this.transactionId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      originalAmount: originalAmount ?? this.originalAmount,
      refundAmount: refundAmount ?? this.refundAmount,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      processedBy: processedBy ?? this.processedBy,
      notes: notes ?? this.notes,
      requestedAt: requestedAt ?? this.requestedAt,
      processedAt: processedAt ?? this.processedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentId': paymentId,
      'transactionId': transactionId,
      'clientId': clientId,
      'clientName': clientName,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'originalAmount': originalAmount,
      'refundAmount': refundAmount,
      'reason': reason,
      'status': status,
      'processedBy': processedBy,
      'notes': notes,
      'requestedAt': requestedAt.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory RefundModel.fromMap(Map<String, dynamic> map) {
    return RefundModel(
      id: map['id'] as String? ?? '',
      paymentId: map['paymentId'] as String? ?? '',
      transactionId: map['transactionId'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      clientName: map['clientName'] as String? ?? '',
      lawyerId: map['lawyerId'] as String? ?? '',
      lawyerName: map['lawyerName'] as String? ?? '',
      originalAmount:
          (map['originalAmount'] as num?)?.toDouble() ?? 0,
      refundAmount:
          (map['refundAmount'] as num?)?.toDouble() ?? 0,
      reason: map['reason'] as String? ?? '',
      status: map['status'] as String? ?? '',
      processedBy: map['processedBy'] as String?,
      notes: map['notes'] as String?,
      requestedAt: DateTime.tryParse(
            map['requestedAt'] as String? ?? '',
          ) ??
          DateTime.now(),
      processedAt: map['processedAt'] != null
          ? DateTime.tryParse(map['processedAt'] as String)
          : null,
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