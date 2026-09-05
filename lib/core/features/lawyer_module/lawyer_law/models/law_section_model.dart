class LawSectionModel {
  final String id;
  final String lawId;
  final String sectionNumber;
  final String title;
  final String text;
  final String? chapterNumber;
  final String? chapterTitle;
  final List<String> keywords;
  final List<String> relatedSectionIds;
  final bool isBookmarked;

  const LawSectionModel({
    required this.id,
    required this.lawId,
    required this.sectionNumber,
    required this.title,
    required this.text,
    this.chapterNumber,
    this.chapterTitle,
    this.keywords = const [],
    this.relatedSectionIds = const [],
    this.isBookmarked = false,
  });

  factory LawSectionModel.fromMap(Map<String, dynamic> map) {
    return LawSectionModel(
      id: map['id']?.toString() ?? '',
      lawId: map['lawId']?.toString() ?? '',
      sectionNumber: map['sectionNumber']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
      chapterNumber: map['chapterNumber']?.toString(),
      chapterTitle: map['chapterTitle']?.toString(),
      keywords: _parseStringList(map['keywords']),
      relatedSectionIds: _parseStringList(map['relatedSectionIds']),
      isBookmarked: map['isBookmarked'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lawId': lawId,
      'sectionNumber': sectionNumber,
      'title': title,
      'text': text,
      'chapterNumber': chapterNumber,
      'chapterTitle': chapterTitle,
      'keywords': keywords,
      'relatedSectionIds': relatedSectionIds,
      'isBookmarked': isBookmarked,
    };
  }

  LawSectionModel copyWith({
    String? id,
    String? lawId,
    String? sectionNumber,
    String? title,
    String? text,
    String? chapterNumber,
    String? chapterTitle,
    List<String>? keywords,
    List<String>? relatedSectionIds,
    bool? isBookmarked,
  }) {
    return LawSectionModel(
      id: id ?? this.id,
      lawId: lawId ?? this.lawId,
      sectionNumber: sectionNumber ?? this.sectionNumber,
      title: title ?? this.title,
      text: text ?? this.text,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      keywords: keywords ?? this.keywords,
      relatedSectionIds: relatedSectionIds ?? this.relatedSectionIds,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }

    return const [];
  }
}