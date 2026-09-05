class AdminActivityModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime timestamp;
  final String? actorName;

  const AdminActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
    this.actorName,
  });

  AdminActivityModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    DateTime? timestamp,
    String? actorName,
  }) {
    return AdminActivityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      actorName: actorName ?? this.actorName,
    );
  }

  factory AdminActivityModel.fromMap(Map<String, dynamic> map) {
    return AdminActivityModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      type: map['type'] as String? ?? '',
      timestamp: map['timestamp'] is DateTime
          ? map['timestamp'] as DateTime
          : DateTime.tryParse(
                map['timestamp'] as String? ?? '',
              ) ??
              DateTime.now(),
      actorName: map['actorName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'actorName': actorName,
    };
  }
}