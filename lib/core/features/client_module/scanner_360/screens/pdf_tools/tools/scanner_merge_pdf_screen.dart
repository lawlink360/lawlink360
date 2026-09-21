import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Merge PDF tool.
class ScannerMergePdfScreen extends StatelessWidget {
  const ScannerMergePdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'merge',
    title: 'Merge PDF',
    icon: Icons.merge_type,
    subtitle: 'Combine multiple PDFs into one.',
    allowsMultipleInputs: true,
    fields: const [],
    run: (input) async {
      const toolkit = ScannerPdfToolkitService();
      final path = await toolkit.merge(
        inputPaths: input.inputPaths,
        outputPath: input.outputPath,
      );
      return <String>[path];
    },
  );
}