import 'dart:ui';

import 'package:meta/meta.dart';

import 'ocr_line.dart';

@immutable
class OcrBlock {
  const OcrBlock({
    required this.text,
    required this.lines,
    required this.boundingBox,
    required this.cornerPoints,
    required this.recognizedLanguages,
  });

  final String text;
  final List<OcrLine> lines;
  final Rect boundingBox;
  final List<Offset> cornerPoints;
  final List<String> recognizedLanguages;

  OcrBlock copyWith({
    String? text,
    List<OcrLine>? lines,
    Rect? boundingBox,
    List<Offset>? cornerPoints,
    List<String>? recognizedLanguages,
  }) {
    return OcrBlock(
      text: text ?? this.text,
      lines: lines ?? this.lines,
      boundingBox: boundingBox ?? this.boundingBox,
      cornerPoints: cornerPoints ?? this.cornerPoints,
      recognizedLanguages: recognizedLanguages ?? this.recognizedLanguages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'lines': lines.map((l) => l.toMap()).toList(),
      'boundingBox': [boundingBox.left, boundingBox.top, boundingBox.right, boundingBox.bottom],
      'cornerPoints': cornerPoints.map((o) => [o.dx, o.dy]).toList(),
      'recognizedLanguages': recognizedLanguages,
    };
  }

  factory OcrBlock.fromMap(Map<String, dynamic> map) {
    final bb = (map['boundingBox'] as List).cast<num>();
    return OcrBlock(
      text: map['text'] as String,
      lines: (map['lines'] as List)
          .map((e) => OcrLine.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
      boundingBox: Rect.fromLTRB(
        bb[0].toDouble(),
        bb[1].toDouble(),
        bb[2].toDouble(),
        bb[3].toDouble(),
      ),
      cornerPoints: (map['cornerPoints'] as List)
          .map((e) => (e as List).cast<num>())
          .map((e) => Offset(e[0].toDouble(), e[1].toDouble()))
          .toList(),
      recognizedLanguages: (map['recognizedLanguages'] as List).cast<String>(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OcrBlock &&
        other.text == text &&
        _listEquals(other.lines, lines) &&
        other.boundingBox == boundingBox &&
        _listEquals(other.cornerPoints, cornerPoints) &&
        _listEquals(other.recognizedLanguages, recognizedLanguages);
  }

  @override
  int get hashCode => Object.hash(
        text,
        Object.hashAll(lines),
        boundingBox,
        Object.hashAll(cornerPoints),
        Object.hashAll(recognizedLanguages),
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}