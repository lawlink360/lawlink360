class ClientActivityModel {
  final String id;
  final String clientId;
  final String title;
  final String description;
  final String type;
  final DateTime createdAt;

  const ClientActivityModel({
    required this.id,
    required this.clientId,
    required this.title,
    required this.description,
    required this.type,
    required this.createdAt,
  });

  ClientActivityModel copyWith({
    String? id,
    String? clientId,
    String? title,
    String? description,
    String? type,
    DateTime? createdAt,
  }) {
    return ClientActivityModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}