class AdminPermissionModel {
  final String id;
  final String key;
  final String name;
  final String description;
  final String category;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminPermissionModel({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.category,
    required this.isEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminPermissionModel copyWith({
    String? id,
    String? key,
    String? name,
    String? description,
    String? category,
    bool? isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminPermissionModel(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'description': description,
      'category': category,
      'isEnabled': isEnabled,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminPermissionModel.fromMap(Map<String, dynamic> map) {
    return AdminPermissionModel(
      id: map['id']?.toString() ?? '',
      key: map['key']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      category: map['category']?.toString() ?? 'General',
      isEnabled: map['isEnabled'] as bool? ?? true,
      createdAt: _parseDate(map['createdAt']),
      updatedAt: _parseDate(map['updatedAt']),
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    return DateTime.now();
  }
}