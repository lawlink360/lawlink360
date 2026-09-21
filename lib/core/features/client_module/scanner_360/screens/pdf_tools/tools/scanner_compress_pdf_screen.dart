import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Compress PDF tool.
class ScannerCompressPdfScreen extends StatelessWidget {
  const ScannerCompressPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'compress',
    title: 'Compress PDF',
    icon: Icons.compress,
    subtitle: 'Reduce PDF file size.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'level',
        label: 'Compression level — Low, Medium, or High',
        type: ScannerPdfToolFieldType.compressionLevel,
        hint: 'Medium',
        defaultValue: 'Medium',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final raw = input.values['level']?.toString() ?? '';
    final level = _parseLevel(raw);

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.compress(
      inputPath: input.inputPaths.first,
      outputPath: input.outputPath,
      level: level,
    );
    return <String>[path];
  }

  static PdfCompressionLevelChoice _parseLevel(String raw) {
    final normalized = raw.trim().toLowerCase();

    switch (normalized) {
      case 'low':
        return PdfCompressionLevelChoice.bestSpeed;
      case 'medium':
        return PdfCompressionLevelChoice.normal;
      case 'high':
        return PdfCompressionLevelChoice.best;
      default:
        throw ScannerPdfToolkitException(
          'compress: "$raw" is not a valid level. '
          'Use Low, Medium, or High.',
        );
    }
  }
}