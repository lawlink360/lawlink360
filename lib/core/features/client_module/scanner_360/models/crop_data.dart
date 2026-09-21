import 'dart:ui';

import 'package:meta/meta.dart';

/// Crop corners are normalized to 0..1 relative to the
/// image dimensions, not pixel coordinates.
@immutable
class CropData {
  const CropData({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    this.rotation = 0.0,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottomRight;

  /// Rotation in degrees.
  final double rotation;

  CropData copyWith({
    Offset? topLeft,
    Offset? topRight,
    Offset? bottomLeft,
    Offset? bottomRight,
    double? rotation,
  }) {
    return CropData(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      bottomRight: bottomRight ?? this.bottomRight,
      rotation: rotation ?? this.rotation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topLeft': [topLeft.dx, topLeft.dy],
      'topRight': [topRight.dx, topRight.dy],
      'bottomLeft': [bottomLeft.dx, bottomLeft.dy],
      'bottomRight': [bottomRight.dx, bottomRight.dy],
      'rotation': rotation,
    };
  }

  factory CropData.fromMap(Map<String, dynamic> map) {
    Offset readOffset(dynamic value) {
      final list = (value as List).cast<num>();
      return Offset(list[0].toDouble(), list[1].toDouble());
    }

    return CropData(
      topLeft: readOffset(map['topLeft']),
      topRight: readOffset(map['topRight']),
      bottomLeft: readOffset(map['bottomLeft']),
      bottomRight: readOffset(map['bottomRight']),
      rotation: (map['rotation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CropData &&
        other.topLeft == topLeft &&
        other.topRight == topRight &&
        other.bottomLeft == bottomLeft &&
        other.bottomRight == bottomRight &&
        other.rotation == rotation;
  }

  @override
  int get hashCode =>
      Object.hash(topLeft, topRight, bottomLeft, bottomRight, rotation);
}