class LawCategoryModel {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int lawCount;
  final bool isFeatured;
  final int displayOrder;

  const LawCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    this.lawCount = 0,
    this.isFeatured = false,
    this.displayOrder = 0,
  });

  factory LawCategoryModel.fromMap(Map<String, dynamic> map) {
    return LawCategoryModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      iconName: map['iconName']?.toString() ?? '',
      lawCount: _parseInt(map['lawCount']),
      isFeatured: map['isFeatured'] == true,
      displayOrder: _parseInt(map['displayOrder']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'lawCount': lawCount,
      'isFeatured': isFeatured,
      'displayOrder': displayOrder,
    };
  }

  LawCategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    int? lawCount,
    bool? isFeatured,
    int? displayOrder,
  }) {
    return LawCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      lawCount: lawCount ?? this.lawCount,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}