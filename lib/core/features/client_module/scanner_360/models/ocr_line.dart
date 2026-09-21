import 'dart:ui';

import 'package:meta/meta.dart';

import 'ocr_word.dart';

@immutable
class OcrLine {
  const OcrLine({
    required this.text,
    required this.words,
    required this.boundingBox,
    required this.cornerPoints,
    required this.angle,
    required this.recognizedLanguages,
  });

  final String text;
  final List<OcrWord> words;
  final Rect boundingBox;
  final List<Offset> cornerPoints;
  final double angle;
  final List<String> recognizedLanguages;

  OcrLine copyWith({
    String? text,
    List<OcrWord>? words,
    Rect? boundingBox,
    List<Offset>? cornerPoints,
    double? angle,
    List<String>? recognizedLanguages,
  }) {
    return OcrLine(
      text: text ?? this.text,
      words: words ?? this.words,
      boundingBox: boundingBox ?? this.boundingBox,
      cornerPoints: cornerPoints ?? this.cornerPoints,
      angle: angle ?? this.angle,
      recognizedLanguages: recognizedLanguages ?? this.recognizedLanguages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'words': words.map((w) => w.toMap()).toList(),
      'boundingBox': [boundingBox.left, boundingBox.top, boundingBox.right, boundingBox.bottom],
      'cornerPoints': cornerPoints.map((o) => [o.dx, o.dy]).toList(),
      'angle': angle,
      'recognizedLanguages': recognizedLanguages,
    };
  }

  factory OcrLine.fromMap(Map<String, dynamic> map) {
    final bb = (map['boundingBox'] as List).cast<num>();
    return OcrLine(
      text: map['text'] as String,
      words: (map['words'] as List)
          .map((e) => OcrWord.fromMap((e as Map).cast<String, dynamic>()))
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
      angle: (map['angle'] as num).toDouble(),
      recognizedLanguages: (map['recognizedLanguages'] as List).cast<String>(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OcrLine &&
        other.text == text &&
        _listEquals(other.words, words) &&
        other.boundingBox == boundingBox &&
        _listEquals(other.cornerPoints, cornerPoints) &&
        other.angle == angle &&
        _listEquals(other.recognizedLanguages, recognizedLanguages);
  }

  @override
  int get hashCode => Object.hash(
        text,
        Object.hashAll(words),
        boundingBox,
        Object.hashAll(cornerPoints),
        angle,
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