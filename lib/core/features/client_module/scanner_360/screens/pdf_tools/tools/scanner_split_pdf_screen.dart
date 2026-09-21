import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Split PDF tool.
///
/// The user supplies one or more page ranges as comma-separated
/// values. Each range becomes one output PDF. Output file names are
/// derived from the base output path by appending `_1`, `_2`, ...
/// before the `.pdf` extension.
class ScannerSplitPdfScreen extends StatelessWidget {
  const ScannerSplitPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'split',
    title: 'Split PDF',
    icon: Icons.call_split,
    subtitle: 'Split a PDF by pages or ranges.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'ranges',
        label: 'Page ranges (comma-separated, e.g. "0-2,4,6-8")',
        type: ScannerPdfToolFieldType.integerList,
        hint: '0-2,4,6-8',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final rawRanges = input.values['ranges']?.toString() ?? '';
    if (rawRanges.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'split: at least one page range is required.',
      );
    }

    final pageCount = _readPageCount(input.inputPaths.first);

    final ranges = _parseRanges(rawRanges, pageCount);
    if (ranges.isEmpty) {
      throw const ScannerPdfToolkitException(
        'split: no valid page ranges supplied.',
      );
    }

    final outputPaths = <String>[];
    for (var i = 0; i < ranges.length; i++) {
      outputPaths.add(_deriveSplitOutputPath(input.outputPath, i + 1));
    }

    const toolkit = ScannerPdfToolkitService();
    final produced = await toolkit.split(
      inputPath: input.inputPaths.first,
      pageRanges: ranges,
      outputPaths: outputPaths,
    );
    return produced;
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

  /// Parses a string of comma-separated ranges of the form
  /// `a-b`, `a`, or `a-a` into a list of page-index lists.
  ///
  /// Whitespace is trimmed, empty elements are ignored. Malformed
  /// ranges (e.g. `2-0`, `0-x`, negative numbers, out-of-range
  /// indexes) throw [ScannerPdfToolkitException].
  static List<List<int>> _parseRanges(String raw, int pageCount) {
    final result = <List<int>>[];
    final parts = raw.split(',');

    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;

      if (trimmed.contains('-')) {
        final dashParts = trimmed.split('-');
        if (dashParts.length != 2) {
          throw ScannerPdfToolkitException(
            'split: malformed range "$trimmed".',
          );
        }

        final start = int.tryParse(dashParts[0].trim());
        final end = int.tryParse(dashParts[1].trim());

        if (start == null || end == null) {
          throw ScannerPdfToolkitException(
            'split: range "$trimmed" must contain integers.',
          );
        }
        if (start < 0 || end < 0) {
          throw ScannerPdfToolkitException(
            'split: range "$trimmed" must use non-negative integers.',
          );
        }
        if (start > end) {
          throw ScannerPdfToolkitException(
            'split: range "$trimmed" has start greater than end.',
          );
        }
        if (end >= pageCount) {
          throw ScannerPdfToolkitException(
            'split: range "$trimmed" exceeds page count $pageCount.',
          );
        }

        result.add(
          List<int>.generate(end - start + 1, (i) => start + i),
        );
      } else {
        final value = int.tryParse(trimmed);
        if (value == null) {
          throw ScannerPdfToolkitException(
            'split: "$trimmed" is not a valid page index.',
          );
        }
        if (value < 0) {
          throw ScannerPdfToolkitException(
            'split: "$trimmed" must be non-negative.',
          );
        }
        if (value >= pageCount) {
          throw ScannerPdfToolkitException(
            'split: index $value exceeds page count $pageCount.',
          );
        }

        result.add(<int>[value]);
      }
    }

    return result;
  }

  /// Inserts `_N` before the `.pdf` extension of [basePath].
  ///
  /// If [basePath] does not end with `.pdf`, the suffix is appended
  /// and `.pdf` is then added.
  static String _deriveSplitOutputPath(String basePath, int index) {
    final lower = basePath.toLowerCase();
    if (lower.endsWith('.pdf')) {
      final stem = basePath.substring(0, basePath.length - 4);
      return '${stem}_$index.pdf';
    }
    return '${basePath}_$index.pdf';
  }
}
