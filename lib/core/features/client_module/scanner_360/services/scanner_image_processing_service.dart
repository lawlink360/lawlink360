import 'dart:io';
import 'dart:ui';

import 'package:image/image.dart' as img;

import '../models/crop_data.dart';
import '../models/scan_filter.dart';

/// Raised when an image transformation cannot be completed.
class ScannerImageProcessingException implements Exception {
  const ScannerImageProcessingException(this.message);
  final String message;

  @override
  String toString() => 'ScannerImageProcessingException: $message';
}

/// File-to-file image transformations for Scanner 360.
///
/// All methods read from a file path and write to a file path. No
/// `ui.Image` is retained. All processing is done through the
/// `image` package. Perspective correction requires caller-supplied
/// corner coordinates; this service does not detect them.
class ScannerImageProcessingService {
  const ScannerImageProcessingService();

  // ============================================================
  // Rotation
  // ============================================================

  /// Rotates [inputPath] by [degrees] clockwise and writes to
  /// [outputPath]. Positive values rotate clockwise.
  Future<String> rotate({
    required String inputPath,
    required String outputPath,
    required double degrees,
  }) async {
    final src = await _decode(inputPath);
    final rotated = img.copyRotate(src, angle: degrees);
    await _write(outputPath, rotated);
    return outputPath;
  }

  // ============================================================
  // Crop (axis-aligned)
  // ============================================================

  /// Crops [inputPath] to the axis-aligned bounding rectangle of
  /// [cropData] and writes to [outputPath].
  ///
  /// [cropData] coordinates are normalized to 0..1 relative to the
  /// image dimensions.
  Future<String> cropAxisAligned({
    required String inputPath,
    required String outputPath,
    required CropData cropData,
  }) async {
    final src = await _decode(inputPath);

    final xs = <double>[
      cropData.topLeft.dx,
      cropData.topRight.dx,
      cropData.bottomLeft.dx,
      cropData.bottomRight.dx,
    ];
    final ys = <double>[
      cropData.topLeft.dy,
      cropData.topRight.dy,
      cropData.bottomLeft.dy,
      cropData.bottomRight.dy,
    ];

    final minX = xs.reduce((a, b) => a < b ? a : b);
    final maxX = xs.reduce((a, b) => a > b ? a : b);
    final minY = ys.reduce((a, b) => a < b ? a : b);
    final maxY = ys.reduce((a, b) => a > b ? a : b);

    final left = (minX * src.width).round().clamp(0, src.width - 1);
    final top = (minY * src.height).round().clamp(0, src.height - 1);
    final right = (maxX * src.width).round().clamp(left + 1, src.width);
    final bottom =
        (maxY * src.height).round().clamp(top + 1, src.height);

    final cropped = img.copyCrop(
      src,
      x: left,
      y: top,
      width: right - left,
      height: bottom - top,
    );

    await _write(outputPath, cropped);
    return outputPath;
  }

  // ============================================================
  // Perspective correction
  // ============================================================

  /// Rectifies the quadrilateral described by [cropData] in
  /// [inputPath] to a rectangle and writes to [outputPath].
  ///
  /// The corner order is taken directly from [cropData]:
  /// topLeft, topRight, bottomLeft, bottomRight. Coordinates are
  /// normalized to 0..1 and converted to pixel space internally.
  ///
  /// This method does NOT detect corners. The caller must supply
  /// them (for example from a manual crop UI).
 Future<String> rectifyPerspective({
  required String inputPath,
  required String outputPath,
  required CropData cropData,
}) async {
  final src = await _decode(inputPath);

  final tl = _toPixel(cropData.topLeft, src);
  final tr = _toPixel(cropData.topRight, src);
  final bl = _toPixel(cropData.bottomLeft, src);
  final br = _toPixel(cropData.bottomRight, src);

  final rectified = img.copyRectify(
    src,
    topLeft: tl,
    topRight: tr,
    bottomLeft: bl,
    bottomRight: br,
  );

  await _write(outputPath, rectified);
  return outputPath;
}

  // ============================================================
  // Filters
  // ============================================================

  /// Applies [filter] to [inputPath] and writes to [outputPath].
  Future<String> applyFilter({
    required String inputPath,
    required String outputPath,
    required ScanFilter filter,
  }) async {
    final src = await _decode(inputPath);
    final img.Image out;

    switch (filter) {
      case ScanFilter.original:
        out = src;
        break;
      case ScanFilter.grayscale:
        out = img.grayscale(src);
        break;
      case ScanFilter.blackAndWhite:
        out = img.luminanceThreshold(
          img.grayscale(src),
          threshold: 0.5,
        );
        break;
      case ScanFilter.enhanced:
        out = img.adjustColor(
          src,
          brightness: 1.05,
          contrast: 1.1,
          saturation: 1.05,
          gamma: 1.0,
        );
        break;
      case ScanFilter.magicColor:
        out = img.adjustColor(
          src,
          brightness: 1.08,
          contrast: 1.2,
          saturation: 1.3,
          gamma: 1.05,
        );
        break;
    }

    await _write(outputPath, out);
    return outputPath;
  }

  // ============================================================
  // Enhancement adjustments
  // ============================================================

  /// Applies individual adjustment parameters to [inputPath] and
  /// writes to [outputPath]. Any of the parameters may be null to
  /// leave that dimension unchanged.
  Future<String> adjust({
    required String inputPath,
    required String outputPath,
    double? brightness,
    double? contrast,
    double? saturation,
    double? gamma,
  }) async {
    final src = await _decode(inputPath);
    final out = img.adjustColor(
      src,
      brightness: brightness,
      contrast: contrast,
      saturation: saturation,
      gamma: gamma,
    );
    await _write(outputPath, out);
    return outputPath;
  }

  // ============================================================
  // Internal helpers
  // ============================================================

  Future<img.Image> _decode(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw ScannerImageProcessingException(
        'Input file does not exist: $path',
      );
    }
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw ScannerImageProcessingException(
        'Failed to decode image: $path',
      );
    }
    return decoded;
  }

  Future<void> _write(String path, img.Image image) async {
    final file = File(path);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(img.encodeJpg(image), flush: true);
  }

  img.Point _toPixel(Offset offset, img.Image src) {
    final dx = offset.dx * src.width;
    final dy = offset.dy * src.height;
    return img.Point(dx.round(), dy.round());
  }
}