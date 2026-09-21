import 'package:flutter/material.dart';

import 'scanner_pdf_tool_field.dart';

/// Everything the generic tool flow screen needs to describe and
/// run one PDF tool.
///
/// This is a UI-layer configuration object, not a domain model.
/// Each tool provides its own `ScannerPdfToolConfig` when it is
/// opened; the flow screen does not know anything specific about
/// the tool beyond what is in this class.
@immutable
class ScannerPdfToolConfig {
  const ScannerPdfToolConfig({
    required this.id,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.allowsMultipleInputs,
    required this.fields,
    required this.run,
  });

  /// Stable identifier, e.g. `'merge'`, `'rotate'`.
  final String id;

  /// Title shown in the app bar and on the result screen.
  final String title;

  /// Icon shown in the app bar and on any summary card.
  final IconData icon;

  /// Short description shown under the title.
  final String subtitle;

  /// When true, the input selector allows picking more than one
  /// input PDF. Used by the merge tool.
  final bool allowsMultipleInputs;

  /// Configuration fields to render. May be empty for tools that
  /// require no parameters.
  final List<ScannerPdfToolField> fields;

  /// Runs the tool. Receives the collected input paths, the chosen
  /// output path, and the field values keyed by field id.
  ///
  /// Returns the list of paths produced by the tool. For single
  /// output tools this is a one-element list.
  final Future<List<String>> Function(ScannerPdfToolRunInput input) run;
}

/// Input passed to [ScannerPdfToolConfig.run].
@immutable
class ScannerPdfToolRunInput {
  const ScannerPdfToolRunInput({
    required this.inputPaths,
    required this.outputPath,
    required this.values,
  });

  /// Absolute paths of the input PDFs, in the order the user
  /// selected them. For single-input tools this has length 1.
  final List<String> inputPaths;

  /// Absolute path where the tool should write its output. For
  /// single-output tools this is a single path. Multi-output tools
  /// (split) receive the directory-free base path chosen by the
  /// user and are responsible for generating the actual file names.
  final String outputPath;

  /// Field values keyed by [ScannerPdfToolField.id].
  final Map<String, Object?> values;
}