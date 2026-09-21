import 'package:flutter/material.dart';

import '../../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../../services/scanner_pdf_toolkit_service.dart';
import '../scanner_pdf_tool_flow_screen.dart';

/// Thin wrapper that configures the generic tool flow screen for
/// the Protect PDF tool.
///
/// ## Factual note on permissions
///
/// The frozen `ScannerPdfToolkitService.protect` only **adds** the
/// permissions supplied to it on top of Syncfusion's default
/// permission set. It does not remove permissions. Therefore the
/// preset names here describe what the wrapper explicitly requests
/// to be granted, not what it explicitly denies.
class ScannerProtectPdfScreen extends StatelessWidget {
  const ScannerProtectPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScannerPdfToolFlowScreen(config: _config);
  }

  static final ScannerPdfToolConfig _config = ScannerPdfToolConfig(
    id: 'protect',
    title: 'Protect PDF',
    icon: Icons.lock_outline,
    subtitle: 'Add password protection.',
    allowsMultipleInputs: false,
    fields: const [
      ScannerPdfToolField(
        id: 'userPassword',
        label: 'User password (required to open the PDF)',
        type: ScannerPdfToolFieldType.password,
      ),
      ScannerPdfToolField(
        id: 'userPasswordConfirm',
        label: 'Confirm user password',
        type: ScannerPdfToolFieldType.password,
      ),
      ScannerPdfToolField(
        id: 'ownerPassword',
        label: 'Owner password (required to change permissions)',
        type: ScannerPdfToolFieldType.password,
      ),
      ScannerPdfToolField(
        id: 'ownerPasswordConfirm',
        label: 'Confirm owner password',
        type: ScannerPdfToolFieldType.password,
      ),
      ScannerPdfToolField(
        id: 'algorithm',
        label:
            'Encryption algorithm — RC4 40, RC4 128, AES 128, AES 256, AES 256 R6',
        type: ScannerPdfToolFieldType.encryptionAlgorithm,
        hint: 'AES 256',
        defaultValue: 'AES 256',
      ),
      ScannerPdfToolField(
        id: 'permissions',
        label:
            'Permissions — Standard, Print, Print + Copy, or Custom (comma-separated)',
        type: ScannerPdfToolFieldType.text,
        hint: 'Standard',
        defaultValue: 'Standard',
      ),
    ],
    run: _run,
  );

  static Future<List<String>> _run(ScannerPdfToolRunInput input) async {
    final user = _requireMatch(
      input.values['userPassword']?.toString() ?? '',
      input.values['userPasswordConfirm']?.toString() ?? '',
      'user',
    );
    final owner = _requireMatch(
      input.values['ownerPassword']?.toString() ?? '',
      input.values['ownerPasswordConfirm']?.toString() ?? '',
      'owner',
    );

    final algorithm = _parseAlgorithm(
      input.values['algorithm']?.toString() ?? '',
    );
    final permissions = _parsePermissions(
      input.values['permissions']?.toString() ?? '',
    );

    const toolkit = ScannerPdfToolkitService();
    final path = await toolkit.protect(
      inputPath: input.inputPaths.first,
      outputPath: input.outputPath,
      userPassword: user,
      ownerPassword: owner,
      algorithm: algorithm,
      permissions: permissions,
    );
    return <String>[path];
  }

  /// Validates that [a] and [b] are non-empty and equal.
  static String _requireMatch(String a, String b, String label) {
    if (a.isEmpty || b.isEmpty) {
      throw ScannerPdfToolkitException(
        'protect: $label password is required.',
      );
    }
    if (a != b) {
      throw ScannerPdfToolkitException(
        'protect: $label passwords do not match.',
      );
    }
    return a;
  }

  static PdfEncryptionAlgorithmChoice _parseAlgorithm(String raw) {
    final normalized = raw.trim().toLowerCase();

    switch (normalized) {
      case 'rc4 40':
        return PdfEncryptionAlgorithmChoice.rc4x40Bit;
      case 'rc4 128':
        return PdfEncryptionAlgorithmChoice.rc4x128Bit;
      case 'aes 128':
        return PdfEncryptionAlgorithmChoice.aesx128Bit;
      case 'aes 256':
        return PdfEncryptionAlgorithmChoice.aesx256Bit;
      case 'aes 256 r6':
        return PdfEncryptionAlgorithmChoice.aesx256BitRevision6;
      default:
        throw ScannerPdfToolkitException(
          'protect: "$raw" is not a valid algorithm. '
          'Use RC4 40, RC4 128, AES 128, AES 256, or AES 256 R6.',
        );
    }
  }

  /// Returns `null` for the Standard preset, a fixed list for the
  /// Print and Print + Copy presets, or a parsed list for Custom.
  static List<PdfPermission>? _parsePermissions(String raw) {
    final normalized = raw.trim().toLowerCase();

    if (normalized.isEmpty || normalized == 'standard') {
      return null;
    }
    if (normalized == 'print') {
      return const <PdfPermission>[PdfPermission.print];
    }
    if (normalized == 'print + copy') {
      return const <PdfPermission>[
        PdfPermission.print,
        PdfPermission.copyContent,
        PdfPermission.accessibilityCopyContent,
        PdfPermission.fullQualityPrint,
      ];
    }
    if (normalized == 'custom') {
      throw const ScannerPdfToolkitException(
        'protect: Custom permissions require comma-separated '
        'PdfPermission names after "Custom", e.g. '
        '"Custom: print, copyContent".',
      );
    }
    if (normalized.startsWith('custom:')) {
      final tail = raw.trim().substring('Custom:'.length).trim();
      if (tail.isEmpty) {
        throw const ScannerPdfToolkitException(
          'protect: Custom permissions list is empty.',
        );
      }
      final result = <PdfPermission>[];
      for (final part in tail.split(',')) {
        final name = part.trim();
        if (name.isEmpty) continue;
        final match = _permissionByName(name);
        if (match == null) {
          throw ScannerPdfToolkitException(
            'protect: "$name" is not a valid PdfPermission name.',
          );
        }
        result.add(match);
      }
      if (result.isEmpty) {
        throw const ScannerPdfToolkitException(
          'protect: Custom permissions list is empty.',
        );
      }
      return result;
    }

    throw ScannerPdfToolkitException(
      'protect: "$raw" is not a valid permissions preset. '
      'Use Standard, Print, Print + Copy, or Custom.',
    );
  }

  static PdfPermission? _permissionByName(String name) {
    for (final value in PdfPermission.values) {
      if (value.name.toLowerCase() == name.toLowerCase()) {
        return value;
      }
    }
    return null;
  }
}