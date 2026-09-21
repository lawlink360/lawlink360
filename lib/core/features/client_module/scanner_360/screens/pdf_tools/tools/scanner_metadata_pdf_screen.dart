import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// PDF Metadata tool.
///
/// Phase 10E.1. Thin configuration screen that edits the standard
/// PDF document-information fields and produces a new PDF. Follows
/// the existing PDF Toolkit pattern: it constructs a
/// [ScannerPdfToolConfig] and hands it to the generic
/// [ScannerPdfToolFlowScreen]. No scanner-pipeline coupling.
///
/// All six fields are optional. Leaving a field empty passes null
/// to the toolkit service, which preserves the source value.
class ScannerMetadataPdfScreen extends StatelessWidget {
  const ScannerMetadataPdfScreen({super.key});

  static const ScannerPdfToolkitService _service =
      ScannerPdfToolkitService();

  @override
  Widget build(BuildContext context) {
    return const ScannerPdfToolFlowScreen(
      config: ScannerPdfToolConfig(
        id: 'metadata',
        title: 'PDF Metadata',
        icon: Icons.info_outline,
        subtitle: 'Edit document information and save a new PDF.',
        allowsMultipleInputs: false,
        fields: <ScannerPdfToolField>[
          ScannerPdfToolField(
            id: 'title',
            label: 'Title',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Document title',
          ),
          ScannerPdfToolField(
            id: 'author',
            label: 'Author',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Document author',
          ),
          ScannerPdfToolField(
            id: 'subject',
            label: 'Subject',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Document subject',
          ),
          ScannerPdfToolField(
            id: 'keywords',
            label: 'Keywords',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Comma-separated keywords',
          ),
          ScannerPdfToolField(
            id: 'creator',
            label: 'Creator',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Application that created the document',
          ),
          ScannerPdfToolField(
            id: 'producer',
            label: 'Producer',
            type: ScannerPdfToolFieldType.text,
            required: false,
            hint: 'Application that produced the PDF',
          ),
        ],
        run: _run,
      ),
    );
  }

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final output = await _service.updateMetadata(
      inputPath: input.inputPaths.first,
      outputPath: input.outputPath,
      title: _readString(input.values, 'title'),
      author: _readString(input.values, 'author'),
      subject: _readString(input.values, 'subject'),
      keywords: _readString(input.values, 'keywords'),
      creator: _readString(input.values, 'creator'),
      producer: _readString(input.values, 'producer'),
    );
    return <String>[output];
  }

  /// Reads a field value as a non-empty String, or null if the
  /// value is missing or blank. The flow UI currently supplies
  /// text-field values as raw Strings.
  static String? _readString(
    Map<String, Object?> values,
    String key,
  ) {
    final raw = values[key];
    if (raw is! String) return null;
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return null;
    return trimmed;
  }
}