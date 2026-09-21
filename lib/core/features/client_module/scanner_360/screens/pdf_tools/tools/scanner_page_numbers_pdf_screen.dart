import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Add Page Numbers tool.
///
/// The wrapper accepts text-based configuration only, matching the
/// frozen 8D-1 architecture. Position and numeric values are parsed
/// inside this file into the types required by the frozen
/// [ScannerPdfToolkitService.addPageNumbers] API.
class ScannerPageNumbersPdfScreen extends StatelessWidget {
  const ScannerPageNumbersPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'page_numbers',
    title: 'Add Page Numbers',
    icon: Icons.pin_outlined,
    subtitle: 'Stamp page numbers onto every page.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'format',
        label: 'Format — must contain {0} for the page number',
        type: ScannerPdfToolFieldType.format,
        hint: 'Page {0}',
        defaultValue: 'Page {0}',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'fontSize',
        label: 'Font size',
        type: ScannerPdfToolFieldType.text,
        hint: '10',
        defaultValue: '10',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'margin',
        label: 'Margin',
        type: ScannerPdfToolFieldType.text,
        hint: '24',
        defaultValue: '24',
        required: false,
      ),
      ScannerPdfToolField(
        id: 'position',
        label:
            'Position — center, topLeft, topCenter, topRight, middleLeft, '
            'middleRight, bottomLeft, bottomCenter, bottomRight',
        type: ScannerPdfToolFieldType.text,
        hint: 'BottomCenter',
        defaultValue: 'BottomCenter',
        required: false,
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final format = _requireFormatPlaceholder(
      input.values['format']?.toString() ?? '',
    );
    final fontSize = _parseDouble(
      input.values['fontSize']?.toString() ?? '',
      'fontSize',
      fallback: 10,
      minExclusive: 0,
    );
    final margin = _parseDouble(
      input.values['margin']?.toString() ?? '',
      'margin',
      fallback: 24,
      min: 0,
    );
    final position = _parsePosition(
      input.values['position']?.toString() ?? '',
    );

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.addPageNumbers(
      inputPath: input.inputPaths.first,
      outputPath: input.outputPath,
      format: format,
      fontSize: fontSize,
      margin: margin,
      position: position,
    );
    return <String>[path];
  }

  /// Validates the format string, applying the service default when
  /// empty and requiring the `{0}` page-number placeholder.
  static String _requireFormatPlaceholder(String raw) {
    final trimmed = raw.trim();
    final format = trimmed.isEmpty ? 'Page {0}' : trimmed;
    if (!format.contains('{0}')) {
      throw ScannerPdfToolkitException(
        'page_numbers: format must contain {0} for the page number. '
        'Got "$raw".',
      );
    }
    return format;
  }

  /// Parses a case-insensitive [PdfWatermarkPosition] name.
  ///
  /// An empty input falls back to [PdfWatermarkPosition.bottomCenter].
  static PdfWatermarkPosition _parsePosition(String raw) {
    final normalized = raw.trim();
    if (normalized.isEmpty) {
      return PdfWatermarkPosition.bottomCenter;
    }
    for (final value in PdfWatermarkPosition.values) {
      if (value.name.toLowerCase() == normalized.toLowerCase()) {
        return value;
      }
    }
    throw ScannerPdfToolkitException(
      'page_numbers: "$raw" is not a valid position. Use one of: '
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
        'page_numbers: "$raw" is not a valid number for $fieldName.',
      );
    }
    if (min != null && value < min) {
      throw ScannerPdfToolkitException(
        'page_numbers: $fieldName must be >= $min.',
      );
    }
    if (max != null && value > max) {
      throw ScannerPdfToolkitException(
        'page_numbers: $fieldName must be <= $max.',
      );
    }
    if (minExclusive != null && value <= minExclusive) {
      throw ScannerPdfToolkitException(
        'page_numbers: $fieldName must be > $minExclusive.',
      );
    }
    return value;
  }
}