import 'package:meta/meta.dart';

import 'crop_data.dart';
import 'ocr_result.dart';
import 'scan_filter.dart';

@immutable
class ScannerPage {
  const ScannerPage({
    required this.id,
    required this.imagePath,
    required this.filter,
    required this.rotation,
    required this.width,
    required this.height,
    required this.createdAt,
    this.thumbnailPath,
    this.cropData,
    this.ocrResult,
  });

  final String id;
  final String imagePath;
  final String? thumbnailPath;
  final CropData? cropData;
  final ScanFilter filter;
  final double rotation;
  final int width;
  final int height;
  final OcrResult? ocrResult;
  final DateTime createdAt;

  ScannerPage copyWith({
    String? id,
    String? imagePath,
    String? thumbnailPath,
    bool clearThumbnailPath = false,
    CropData? cropData,
    bool clearCropData = false,
    ScanFilter? filter,
    double? rotation,
    int? width,
    int? height,
    OcrResult? ocrResult,
    bool clearOcrResult = false,
    DateTime? createdAt,
  }) {
    return ScannerPage(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      thumbnailPath:
          clearThumbnailPath ? null : (thumbnailPath ?? this.thumbnailPath),
      cropData: clearCropData ? null : (cropData ?? this.cropData),
      filter: filter ?? this.filter,
      rotation: rotation ?? this.rotation,
      width: width ?? this.width,
      height: height ?? this.height,
      ocrResult: clearOcrResult ? null : (ocrResult ?? this.ocrResult),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'thumbnailPath': thumbnailPath,
      'cropData': cropData?.toMap(),
      'filter': filter.name,
      'rotation': rotation,
      'width': width,
      'height': height,
      'ocrResult': ocrResult?.toMap(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ScannerPage.fromMap(Map<String, dynamic> map) {
    return ScannerPage(
      id: map['id'] as String,
      imagePath: map['imagePath'] as String,
      thumbnailPath: map['thumbnailPath'] as String?,
      cropData: map['cropData'] == null
          ? null
          : CropData.fromMap((map['cropData'] as Map).cast<String, dynamic>()),
      filter: ScanFilter.values.firstWhere(
        (e) => e.name == map['filter'],
        orElse: () => ScanFilter.original,
      ),
      rotation: (map['rotation'] as num).toDouble(),
      width: map['width'] as int,
      height: map['height'] as int,
      ocrResult: map['ocrResult'] == null
          ? null
          : OcrResult.fromMap((map['ocrResult'] as Map).cast<String, dynamic>()),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScannerPage &&
        other.id == id &&
        other.imagePath == imagePath &&
        other.thumbnailPath == thumbnailPath &&
        other.cropData == cropData &&
        other.filter == filter &&
        other.rotation == rotation &&
        other.width == width &&
        other.height == height &&
        other.ocrResult == ocrResult &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        imagePath,
        thumbnailPath,
        cropData,
        filter,
        rotation,
        width,
        height,
        ocrResult,
        createdAt,
      );
}