import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Rotate PDF tool.
///
/// The user supplies either a single integer (`0`, `90`, `180`,
/// `270`) which applies the rotation to every page, or a list of
/// `pageIndex:angle` pairs (`1:90, 3:180`) which applies rotations
/// to specific pages. Page indexes are zero-based.
class ScannerRotatePdfScreen extends StatelessWidget {
  const ScannerRotatePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'rotate',
    title: 'Rotate PDF',
    icon: Icons.rotate_90_degrees_cw,
    subtitle: 'Rotate one or more PDF pages.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'rotation',
        label: 'Rotation — "90", "180", "270", or per-page "1:90, 3:180"',
        type: ScannerPdfToolFieldType.rotationMap,
        hint: '90',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final raw = input.values['rotation']?.toString() ?? '';
    if (raw.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'rotate: a rotation value is required.',
      );
    }

    final pageCount = _readPageCount(input.inputPaths.first);
    final rotations = _parseRotations(raw, pageCount);

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.rotate(
      inputPath: input.inputPaths.first,
      rotations: rotations,
      outputPath: input.outputPath,
    );
    return <String>[path];
  }

  static int _readPageCount(String path) {
    final file = File(path);
    final bytes = file.readAsBytesSync();
    final document = PdfDocument(inputBytes: bytes);
    try {
      return document.pages.count;
    } finally {
      document.dispose();
    }
  }

  /// Parses a rotation expression into a `Map<int, PdfRotation>`.
  ///
  /// A single integer applies to all pages. A list of
  /// `pageIndex:angle` pairs applies to the specified pages.
  /// Malformed input throws [ScannerPdfToolkitException].
  static Map<int, PdfRotation> _parseRotations(
    String raw,
    int pageCount,
  ) {
    final trimmed = raw.trim();

    if (!trimmed.contains(':')) {
      final angle = int.tryParse(trimmed);
      if (angle == null) {
        throw ScannerPdfToolkitException(
          'rotate: "$trimmed" is not a valid rotation.',
        );
      }
      final rotation = _angleToRotation(angle);

      final map = <int, PdfRotation>{};
      for (var i = 0; i < pageCount; i++) {
        map[i] = rotation;
      }
      return map;
    }

    final map = <int, PdfRotation>{};
    final parts = trimmed.split(',');

    for (final part in parts) {
      final element = part.trim();
      if (element.isEmpty) continue;

      final pieces = element.split(':');
      if (pieces.length != 2) {
        throw ScannerPdfToolkitException(
          'rotate: malformed entry "$element".',
        );
      }

      final index = int.tryParse(pieces[0].trim());
      final angle = int.tryParse(pieces[1].trim());

      if (index == null || angle == null) {
        throw ScannerPdfToolkitException(
          'rotate: entry "$element" must contain integers.',
        );
      }
      if (index < 0 || index >= pageCount) {
        throw ScannerPdfToolkitException(
          'rotate: page index $index is out of range '
          '(0..${pageCount - 1}).',
        );
      }

      map[index] = _angleToRotation(angle);
    }

    if (map.isEmpty) {
      throw const ScannerPdfToolkitException(
        'rotate: no valid rotation entries supplied.',
      );
    }

    return map;
  }

  static PdfRotation _angleToRotation(int angle) {
    switch (angle) {
      case 0:
        return PdfRotation.none;
      case 90:
        return PdfRotation.rotate90;
      case 180:
        return PdfRotation.rotate180;
      case 270:
        return PdfRotation.rotate270;
      default:
        throw ScannerPdfToolkitException(
          'rotate: angle $angle is not supported. '
          'Use 0, 90, 180, or 270.',
        );
    }
  }
}