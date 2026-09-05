class AdminActivityModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String type;
  final DateTime timestamp;

  const AdminActivityModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
  });

  AdminActivityModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? type,
    DateTime? timestamp,
  }) {
    return AdminActivityModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory AdminActivityModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AdminActivityModel(
      id: map['id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      type: map['type'] as String? ?? 'other',
      timestamp: map['timestamp'] is DateTime
          ? map['timestamp'] as DateTime
          : DateTime.tryParse(
                map['timestamp'] as String? ?? '',
              ) ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}