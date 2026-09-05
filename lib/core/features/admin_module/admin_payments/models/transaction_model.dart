class TransactionModel {
  final String id;
  final String transactionId;

  final String paymentId;

  final String userId;
  final String userName;
  final String userEmail;

  final String? lawyerId;
  final String? lawyerName;

  final double amount;
  final String currency;

  final String type;
  final String status;

  final String paymentMethod;
  final String paymentGateway;

  final String description;
  final String? reference;

  final DateTime transactionDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionModel({
    required this.id,
    required this.transactionId,
    required this.paymentId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.lawyerId,
    this.lawyerName,
    required this.amount,
    required this.currency,
    required this.type,
    required this.status,
    required this.paymentMethod,
    required this.paymentGateway,
    required this.description,
    this.reference,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  TransactionModel copyWith({
    String? id,
    String? transactionId,
    String? paymentId,
    String? userId,
    String? userName,
    String? userEmail,
    String? lawyerId,
    String? lawyerName,
    double? amount,
    String? currency,
    String? type,
    String? status,
    String? paymentMethod,
    String? paymentGateway,
    String? description,
    String? reference,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      paymentId: paymentId ?? this.paymentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      lawyerId: lawyerId ?? this.lawyerId,
      lawyerName: lawyerName ?? this.lawyerName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'paymentId': paymentId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'amount': amount,
      'currency': currency,
      'type': type,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentGateway': paymentGateway,
      'description': description,
      'reference': reference,
      'transactionDate': transactionDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String? ?? '',
      transactionId: map['transactionId'] as String? ?? '',
      paymentId: map['paymentId'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      userEmail: map['userEmail'] as String? ?? '',
      lawyerId: map['lawyerId'] as String?,
      lawyerName: map['lawyerName'] as String?,
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      currency: map['currency'] as String? ?? 'PKR',
      type: map['type'] as String? ?? '',
      status: map['status'] as String? ?? '',
      paymentMethod: map['paymentMethod'] as String? ?? '',
      paymentGateway: map['paymentGateway'] as String? ?? '',
      description: map['description'] as String? ?? '',
      reference: map['reference'] as String?,
      transactionDate: DateTime.tryParse(
            map['transactionDate'] as String? ?? '',
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