import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Extract Pages tool.
class ScannerExtractPagesScreen extends StatelessWidget {
  const ScannerExtractPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'extract',
    title: 'Extract Pages',
    icon: Icons.file_copy_outlined,
    subtitle: 'Create a new PDF from selected pages.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'pages',
        label: 'Page indexes (comma-separated, zero-based)',
        type: ScannerPdfToolFieldType.pageIndexList,
        hint: '0,2,4',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final raw = input.values['pages']?.toString() ?? '';
    if (raw.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'extractPages: at least one page index is required.',
      );
    }

    final pageCount = _readPageCount(input.inputPaths.first);
    final indexes = _parsePageIndexes(raw, pageCount);

    if (indexes.isEmpty) {
      throw const ScannerPdfToolkitException(
        'extractPages: no valid page indexes supplied.',
      );
    }

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.extractPages(
      inputPath: input.inputPaths.first,
      pageIndexes: indexes,
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

  /// Parses a comma-separated list of zero-based page indexes.
  ///
  /// Duplicates are preserved. Whitespace is trimmed, empty elements
  /// are ignored. Values outside `0..pageCount - 1` throw
  /// [ScannerPdfToolkitException].
  static List<int> _parsePageIndexes(String raw, int pageCount) {
    final result = <int>[];
    final parts = raw.split(',');

    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;

      final value = int.tryParse(trimmed);
      if (value == null) {
        throw ScannerPdfToolkitException(
          'extractPages: "$trimmed" is not a valid page index.',
        );
      }
      if (value < 0) {
        throw ScannerPdfToolkitException(
          'extractPages: "$trimmed" must be non-negative.',
        );
      }
      if (value >= pageCount) {
        throw ScannerPdfToolkitException(
          'extractPages: index $value exceeds page count $pageCount.',
        );
      }

      result.add(value);
    }

    return result;
  }
}