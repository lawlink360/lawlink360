class LawModel {
  final String id;
  final String title;
  final String shortTitle;
  final int year;
  final String jurisdiction;
  final String categoryId;
  final String categoryName;
  final String description;
  final String? promulgationDate;
  final String? lawNumber;
  final int totalSections;
  final bool isFeatured;
  final bool isNew;
  final List<String> keywords;

  const LawModel({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.year,
    required this.jurisdiction,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    this.promulgationDate,
    this.lawNumber,
    required this.totalSections,
    this.isFeatured = false,
    this.isNew = false,
    this.keywords = const [],
  });

  /// Creates a LawModel from Firestore/API/JSON data.
  factory LawModel.fromMap(Map<String, dynamic> map) {
    return LawModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      shortTitle: map['shortTitle']?.toString() ?? '',
      year: _parseInt(map['year']),
      jurisdiction: map['jurisdiction']?.toString() ?? '',
      categoryId: map['categoryId']?.toString() ?? '',
      categoryName: map['categoryName']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      promulgationDate: map['promulgationDate']?.toString(),
      lawNumber: map['lawNumber']?.toString(),
      totalSections: _parseInt(map['totalSections']),
      isFeatured: map['isFeatured'] == true,
      isNew: map['isNew'] == true,
      keywords: _parseStringList(map['keywords']),
    );
  }

  /// Converts the model into a Map for Firestore/API/local storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'shortTitle': shortTitle,
      'year': year,
      'jurisdiction': jurisdiction,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
      'promulgationDate': promulgationDate,
      'lawNumber': lawNumber,
      'totalSections': totalSections,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'keywords': keywords,
    };
  }

  /// Returns the first alphabetical character of the law title.
  String get alphabeticalLetter {
    if (title.trim().isEmpty) {
      return '#';
    }

    return title.trim()[0].toUpperCase();
  }

  /// Creates a copy with selected fields changed.
  LawModel copyWith({
    String? id,
    String? title,
    String? shortTitle,
    int? year,
    String? jurisdiction,
    String? categoryId,
    String? categoryName,
    String? description,
    String? promulgationDate,
    String? lawNumber,
    int? totalSections,
    bool? isFeatured,
    bool? isNew,
    List<String>? keywords,
  }) {
    return LawModel(
      id: id ?? this.id,
      title: title ?? this.title,
      shortTitle: shortTitle ?? this.shortTitle,
      year: year ?? this.year,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      promulgationDate: promulgationDate ?? this.promulgationDate,
      lawNumber: lawNumber ?? this.lawNumber,
      totalSections: totalSections ?? this.totalSections,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      keywords: keywords ?? this.keywords,
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

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }

    return const [];
  }
}