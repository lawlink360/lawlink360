enum ClientRequestStatus {
  pending,
  accepted,
  declined,
}

class ClientRequestModel {
  final String id;
  final String clientId;
  final String clientName;
  final String? clientImageUrl;
  final String requestType;
  final String message;
  final DateTime requestedAt;
  final ClientRequestStatus status;

  const ClientRequestModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.clientImageUrl,
    required this.requestType,
    required this.message,
    required this.requestedAt,
    this.status = ClientRequestStatus.pending,
  });

  ClientRequestModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientImageUrl,
    String? requestType,
    String? message,
    DateTime? requestedAt,
    ClientRequestStatus? status,
  }) {
    return ClientRequestModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientImageUrl: clientImageUrl ?? this.clientImageUrl,
      requestType: requestType ?? this.requestType,
      message: message ?? this.message,
      requestedAt: requestedAt ?? this.requestedAt,
      status: status ?? this.status,
    );
  }
}