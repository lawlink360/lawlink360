import 'package:meta/meta.dart';

import 'scanner_document_category.dart';

@immutable
class DocumentMetadata {
  const DocumentMetadata({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.pageCount,
    this.isFavorite = false,
    this.tags = const [],
    this.linkedCaseId,
    this.linkedClientId,
    this.linkedLawyerId,
    this.linkedMatterId,
  });

  final String id;
  final String name;
  final ScannerDocumentCategory category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int pageCount;
  final bool isFavorite;
  final List<String> tags;
  final String? linkedCaseId;
  final String? linkedClientId;
  final String? linkedLawyerId;
  final String? linkedMatterId;

  DocumentMetadata copyWith({
    String? id,
    String? name,
    ScannerDocumentCategory? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? pageCount,
    bool? isFavorite,
    List<String>? tags,
    String? linkedCaseId,
    bool clearLinkedCaseId = false,
    String? linkedClientId,
    bool clearLinkedClientId = false,
    String? linkedLawyerId,
    bool clearLinkedLawyerId = false,
    String? linkedMatterId,
    bool clearLinkedMatterId = false,
  }) {
    return DocumentMetadata(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pageCount: pageCount ?? this.pageCount,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      linkedCaseId:
          clearLinkedCaseId ? null : (linkedCaseId ?? this.linkedCaseId),
      linkedClientId: clearLinkedClientId
          ? null
          : (linkedClientId ?? this.linkedClientId),
      linkedLawyerId: clearLinkedLawyerId
          ? null
          : (linkedLawyerId ?? this.linkedLawyerId),
      linkedMatterId: clearLinkedMatterId
          ? null
          : (linkedMatterId ?? this.linkedMatterId),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'pageCount': pageCount,
      'isFavorite': isFavorite,
      'tags': tags,
      'linkedCaseId': linkedCaseId,
      'linkedClientId': linkedClientId,
      'linkedLawyerId': linkedLawyerId,
      'linkedMatterId': linkedMatterId,
    };
  }

  factory DocumentMetadata.fromMap(Map<String, dynamic> map) {
    return DocumentMetadata(
      id: map['id'] as String,
      name: map['name'] as String,
      category: ScannerDocumentCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ScannerDocumentCategory.other,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      pageCount: map['pageCount'] as int,
      isFavorite: map['isFavorite'] as bool? ?? false,
      tags: (map['tags'] as List?)?.cast<String>() ?? const [],
      linkedCaseId: map['linkedCaseId'] as String?,
      linkedClientId: map['linkedClientId'] as String?,
      linkedLawyerId: map['linkedLawyerId'] as String?,
      linkedMatterId: map['linkedMatterId'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentMetadata &&
        other.id == id &&
        other.name == name &&
        other.category == category &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.pageCount == pageCount &&
        other.isFavorite == isFavorite &&
        _listEquals(other.tags, tags) &&
        other.linkedCaseId == linkedCaseId &&
        other.linkedClientId == linkedClientId &&
        other.linkedLawyerId == linkedLawyerId &&
        other.linkedMatterId == linkedMatterId;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        category,
        createdAt,
        updatedAt,
        pageCount,
        isFavorite,
        Object.hashAll(tags),
        linkedCaseId,
        linkedClientId,
        linkedLawyerId,
        linkedMatterId,
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}