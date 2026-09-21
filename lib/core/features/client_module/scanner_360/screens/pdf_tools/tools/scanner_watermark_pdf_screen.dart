import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Add Watermark tool.
///
/// The wrapper accepts text-based configuration only, matching the
/// frozen 8D-1 architecture. Position, numeric values, and color
/// are parsed inside this file into the types required by the
/// frozen [ScannerPdfToolkitService.addWatermark] API.
class ScannerWatermarkPdfScreen extends StatelessWidget {
  const ScannerWatermarkPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'watermark',
    title: 'Add Watermark',
    icon: Icons.branding_watermark_outlined,
    subtitle: 'Add a text watermark to every page.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'text',
        label: 'Watermark text',
        type: ScannerPdfToolFieldType.text,
        hint: 'CONFIDENTIAL',
      ),
      ScannerPdfToolField(
        id: 'position',
        label:
            'Position — center, topLeft, topCenter, topRight, middleLeft, '
            'middleRight, bottomLeft, bottomCenter, bottomRight',
        type: ScannerPdfToolFieldType.text,
        hint: 'Center',
        defaultValue: 'Center',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'fontSize',
        label: 'Font size',
        type: ScannerPdfToolFieldType.text,
        hint: '48',
        defaultValue: '48',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'opacity',
        label: 'Opacity (0.0 – 1.0)',
        type: ScannerPdfToolFieldType.text,
        hint: '0.3',
        defaultValue: '0.3',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'rotationDegrees',
        label: 'Rotation in degrees',
        type: ScannerPdfToolFieldType.text,
        hint: '45',
        defaultValue: '45',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'color',
        label: 'Color (R,G,B) — optional',
        type: ScannerPdfToolFieldType.text,
        hint: '255,0,0',
        required: false,
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final text = (input.values['text']?.toString() ?? '').trim();
    if (text.isEmpty) {
      throw const ScannerPdfToolkitException(
        'watermark: watermark text is required.',
      );
    }

    final position = _parsePosition(
      input.values['position']?.toString() ?? '',
    );
    final fontSize = _parseDouble(
      input.values['fontSize']?.toString() ?? '',
      'fontSize',
      fallback: 48,
      minExclusive: 0,
    );
    final opacity = _parseDouble(
      input.values['opacity']?.toString() ?? '',
      'opacity',
      fallback: 0.3,
      min: 0,
      max: 1,
    );
    final rotationDegrees = _parseDouble(
      input.values['rotationDegrees']?.toString() ?? '',
      'rotationDegrees',
      fallback: 45,
    );
    final color = _parseColor(input.values['color']?.toString() ?? '');

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.addWatermark(
      inputPath: input.inputPaths.first,
      outputPath: input.outputPath,
      text: text,
      position: position,
      fontSize: fontSize,
      opacity: opacity,
      rotationDegrees: rotationDegrees,
      red: color.r,
      green: color.g,
      blue: color.b,
    );
    return <String>[path];
  }

  /// Parses a case-insensitive [PdfWatermarkPosition] name.
  ///
  /// An empty input falls back to [PdfWatermarkPosition.center].
  static PdfWatermarkPosition _parsePosition(String raw) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return PdfWatermarkPosition.center;
    }
    for (final value in PdfWatermarkPosition.values) {
      if (value.name.toLowerCase() == normalized.toLowerCase()) {
        return value;
      }
    }
    throw ScannerPdfToolkitException(
      'watermark: "$raw" is not a valid position. Use one of: '
      '${PdfWatermarkPosition.values.map((e) => e.name).join(', ')}.',
    );
  }

  /// Parses a numeric field with optional range enforcement.
  ///
  /// An empty input returns [fallback]. Invalid text, non-finite
  /// values, or values outside `[min, max]` / `(minExclusive, ∞)`
  /// throw [ScannerPdfToolkitException].
  static double _parseDouble(
    String raw,
    String fieldName, {
    required double fallback,
    double? min,
    double? max,
    double? minExclusive,
  }) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return fallback;

    final value = double.tryParse(trimmed);
    if (value == null || !value.isFinite) {
      throw ScannerPdfToolkitException(
        'watermark: "$raw" is not a valid number for $fieldName.',
      );
    }
    if (min != null && value < min) {
      throw ScannerPdfToolkitException(
        'watermark: $fieldName must be >= $min.',
      );
    }
    if (max != null && value > max) {
      throw ScannerPdfToolkitException(
        'watermark: $fieldName must be <= $max.',
      );
    }
    if (minExclusive != null && value <= minExclusive) {
      throw ScannerPdfToolkitException(
        'watermark: $fieldName must be > $minExclusive.',
      );
    }
    return value;
  }

  /// Parses an optional `"r,g,b"` color triple.
  ///
  /// Empty input returns `(r: null, g: null, b: null)`, which lets
  /// the service apply its default color. Any non-empty input must
  /// be exactly three comma-separated integers in `[0, 255]`.
  static ({int? r, int? g, int? b}) _parseColor(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return (r: null, g: null, b: null);
    }

    final parts = trimmed.split(',');
    if (parts.length != 3) {
      throw ScannerPdfToolkitException(
        'watermark: color must be exactly three comma-separated '
        'integers in 0–255, e.g. "255,0,0". Got "$raw".',
      );
    }

    final r = _parseColorChannel(parts[0], 'R');
    final g = _parseColorChannel(parts[1], 'G');
    final b = _parseColorChannel(parts[2], 'B');
    return (r: r, g: g, b: b);
  }

  static int _parseColorChannel(String raw, String channelName) {
    final value = int.tryParse(raw.trim());
    if (value == null || value < 0 || value > 255) {
      throw ScannerPdfToolkitException(
        'watermark: $channelName channel must be an integer in 0–255. '
        'Got "$raw".',
      );
    }
    return value;
  }
}