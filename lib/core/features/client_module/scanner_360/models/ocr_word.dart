import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class OcrWord {
  const OcrWord({
    required this.text,
    required this.boundingBox,
    required this.cornerPoints,
  });

  final String text;
  final Rect boundingBox;
  final List<Offset> cornerPoints;

  OcrWord copyWith({
    String? text,
    Rect? boundingBox,
    List<Offset>? cornerPoints,
  }) {
    return OcrWord(
      text: text ?? this.text,
      boundingBox: boundingBox ?? this.boundingBox,
      cornerPoints: cornerPoints ?? this.cornerPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'boundingBox': [boundingBox.left, boundingBox.top, boundingBox.right, boundingBox.bottom],
      'cornerPoints': cornerPoints.map((o) => [o.dx, o.dy]).toList(),
    };
  }

  factory OcrWord.fromMap(Map<String, dynamic> map) {
    final bb = (map['boundingBox'] as List).cast<num>();
    final points = (map['cornerPoints'] as List)
        .map((e) => (e as List).cast<num>())
        .map((e) => Offset(e[0].toDouble(), e[1].toDouble()))
        .toList();

    return OcrWord(
      text: map['text'] as String,
      boundingBox: Rect.fromLTRB(
        bb[0].toDouble(),
        bb[1].toDouble(),
        bb[2].toDouble(),
        bb[3].toDouble(),
      ),
      cornerPoints: points,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OcrWord &&
        other.text == text &&
        other.boundingBox == boundingBox &&
        _listEquals(other.cornerPoints, cornerPoints);
  }

  @override
  int get hashCode => Object.hash(text, boundingBox, Object.hashAll(cornerPoints));
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}