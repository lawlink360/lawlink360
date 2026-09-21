import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Reorder Pages tool.
class ScannerReorderPagesScreen extends StatelessWidget {
  const ScannerReorderPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'reorder',
    title: 'Reorder Pages',
    icon: Icons.reorder,
    subtitle: 'Change the order of PDF pages.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'order',
        label: 'New page order (zero-based indexes, comma-separated)',
        type: ScannerPdfToolFieldType.integerList,
        hint: '2,0,1,3',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final raw = input.values['order']?.toString() ?? '';
    if (raw.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'reorderPages: a new page order is required.',
      );
    }

    final pageCount = _readPageCount(input.inputPaths.first);
    final order = _parseOrder(raw, pageCount);

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.reorderPages(
      inputPath: input.inputPaths.first,
      newOrder: order,
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

  /// Parses a comma-separated list of zero-based indexes and
  /// validates that it is a permutation of `0..pageCount - 1`.
  static List<int> _parseOrder(String raw, int pageCount) {
    final result = <int>[];
    final parts = raw.split(',');

    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;

      final value = int.tryParse(trimmed);
      if (value == null) {
        throw ScannerPdfToolkitException(
          'reorderPages: "$trimmed" is not a valid page index.',
        );
      }
      if (value < 0 || value >= pageCount) {
        throw ScannerPdfToolkitException(
          'reorderPages: index $value is out of range '
          '(0..${pageCount - 1}).',
        );
      }

      result.add(value);
    }

    if (result.length != pageCount) {
      throw ScannerPdfToolkitException(
        'reorderPages: expected $pageCount page indexes, '
        'received ${result.length}.',
      );
    }

    final seen = <int>{};
    for (final value in result) {
      if (!seen.add(value)) {
        throw ScannerPdfToolkitException(
          'reorderPages: index $value is duplicated. The order '
          'must be a permutation of 0..${pageCount - 1}.',
        );
      }
    }

    return result;
  }
}