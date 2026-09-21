import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/theme/app_colors.dart';
import '../models/ocr_result.dart';
import '../widgets/ocr/scanner_ocr_result_view.dart';
import '../widgets/shared/scanner_empty_view.dart';

/// OCR result screen for Scanner 360.
///
/// Displays an [OcrResult] with search, copy and share actions.
class ScannerOcrResultScreen extends ConsumerStatefulWidget {
  const ScannerOcrResultScreen({
    super.key,
    required this.initialResult,
  });

  final OcrResult initialResult;

  @override
  ConsumerState<ScannerOcrResultScreen> createState() =>
      _ScannerOcrResultScreenState();
}

class _ScannerOcrResultScreenState
    extends ConsumerState<ScannerOcrResultScreen> {
  late OcrResult _result;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _result = widget.initialResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('OCR Text'),
        actions: [
          IconButton(
            onPressed: _result.text.trim().isEmpty
                ? null
                : _handleCopy,
            icon: const Icon(Icons.copy_outlined),
            tooltip: 'Copy text',
          ),
          IconButton(
            onPressed: _result.text.trim().isEmpty
                ? null
                : _handleShare,
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share text',
          ),
        ],
      ),
      body: _result.text.trim().isEmpty
          ? const ScannerEmptyView(
              icon: Icons.text_fields,
              title: 'No text detected',
              subtitle:
                  'The document did not contain readable text.',
            )
          : ScannerOcrResultView(
              result: _result,
              searchQuery: _searchQuery,
              onSearchChanged: (q) =>
                  setState(() => _searchQuery = q),
            ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  Future<void> _handleCopy() async {
    await Clipboard.setData(
      ClipboardData(text: _result.text),
    );
    if (!mounted) return;
    _showSnackBar('Copied');
  }

  Future<void> _handleShare() async {
    final shareResult = await Share.share(
      _result.text,
      subject: 'OCR Text',
    );
    if (!mounted) return;
    if (shareResult.status == ShareResultStatus.success) {
      _showSnackBar('Shared');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}