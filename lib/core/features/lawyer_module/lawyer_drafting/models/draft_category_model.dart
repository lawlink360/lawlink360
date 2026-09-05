class DraftCategoryModel {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int draftCount;
  final bool isPopular;

  const DraftCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    this.draftCount = 0,
    this.isPopular = false,
  });

  DraftCategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    int? draftCount,
    bool? isPopular,
  }) {
    return DraftCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      draftCount: draftCount ?? this.draftCount,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}
