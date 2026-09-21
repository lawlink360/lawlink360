import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ocr_result.dart';
import '../models/scanner_language.dart';
import '../models/scanner_page.dart';
import '../services/scanner_orchestrator_service.dart';

/// Async OCR state for Scanner 360.
///
/// The state holds the last produced [OcrResult], or null if no
/// OCR has been run in this session.
class ScannerOcrNotifier extends AsyncNotifier<OcrResult?> {
  final ScannerOrchestratorService _orchestrator =
      ScannerOrchestratorService();

  @override
  Future<OcrResult?> build() async => null;

  /// Runs OCR on [page] using [language] and returns the result.
  Future<OcrResult?> runOcrOnPage({
    required ScannerPage page,
    required ScannerLanguage language,
  }) async {
    state = const AsyncLoading();

    try {
      final updatedPage = await _orchestrator.runOcrOnPage(
        page: page,
        language: language,
      );
      final result = updatedPage.ocrResult;
      state = AsyncData(result);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final scannerOcrProvider =
    AsyncNotifierProvider<ScannerOcrNotifier, OcrResult?>(
  ScannerOcrNotifier.new,
);