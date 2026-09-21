import 'package:meta/meta.dart';

@immutable
class PdfDocument {
  const PdfDocument({
    required this.id,
    required this.filePath,
    required this.pageCount,
    required this.sizeInBytes,
    required this.createdAt,
    this.isSearchable = false,
  });

  final String id;
  final String filePath;
  final int pageCount;
  final int sizeInBytes;
  final DateTime createdAt;

  /// Future OCR-PDF / searchable PDF support flag.
  final bool isSearchable;

  PdfDocument copyWith({
    String? id,
    String? filePath,
    int? pageCount,
    int? sizeInBytes,
    DateTime? createdAt,
    bool? isSearchable,
  }) {
    return PdfDocument(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      pageCount: pageCount ?? this.pageCount,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
      createdAt: createdAt ?? this.createdAt,
      isSearchable: isSearchable ?? this.isSearchable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'filePath': filePath,
      'pageCount': pageCount,
      'sizeInBytes': sizeInBytes,
      'createdAt': createdAt.toIso8601String(),
      'isSearchable': isSearchable,
    };
  }

  factory PdfDocument.fromMap(Map<String, dynamic> map) {
    return PdfDocument(
      id: map['id'] as String,
      filePath: map['filePath'] as String,
      pageCount: map['pageCount'] as int,
      sizeInBytes: map['sizeInBytes'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      isSearchable: map['isSearchable'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PdfDocument &&
        other.id == id &&
        other.filePath == filePath &&
        other.pageCount == pageCount &&
        other.sizeInBytes == sizeInBytes &&
        other.createdAt == createdAt &&
        other.isSearchable == isSearchable;
  }

  @override
  int get hashCode => Object.hash(
        id,
        filePath,
        pageCount,
        sizeInBytes,
        createdAt,
        isSearchable,
      );
}