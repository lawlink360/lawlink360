import 'package:meta/meta.dart';

import 'ocr_block.dart';
import 'scanner_language.dart';

@immutable
class OcrResult {
  const OcrResult({
    required this.text,
    required this.blocks,
    required this.language,
    required this.createdAt,
    this.pageId,
  });

  final String text;
  final List<OcrBlock> blocks;
  final ScannerLanguage language;
  final DateTime createdAt;
  final String? pageId;

  OcrResult copyWith({
    String? text,
    List<OcrBlock>? blocks,
    ScannerLanguage? language,
    DateTime? createdAt,
    String? pageId,
    bool clearPageId = false,
  }) {
    return OcrResult(
      text: text ?? this.text,
      blocks: blocks ?? this.blocks,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      pageId: clearPageId ? null : (pageId ?? this.pageId),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'blocks': blocks.map((b) => b.toMap()).toList(),
      'language': language.name,
      'createdAt': createdAt.toIso8601String(),
      'pageId': pageId,
    };
  }

  factory OcrResult.fromMap(Map<String, dynamic> map) {
    return OcrResult(
      text: map['text'] as String,
      blocks: (map['blocks'] as List)
          .map((e) => OcrBlock.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
      language: ScannerLanguage.values.firstWhere(
        (e) => e.name == map['language'],
        orElse: () => ScannerLanguage.latin,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      pageId: map['pageId'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OcrResult &&
        other.text == text &&
        _listEquals(other.blocks, blocks) &&
        other.language == language &&
        other.createdAt == createdAt &&
        other.pageId == pageId;
  }

  @override
  int get hashCode => Object.hash(
        text,
        Object.hashAll(blocks),
        language,
        createdAt,
        pageId,
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}