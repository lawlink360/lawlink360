import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crop_data.dart';
import '../models/scan_settings.dart';
import '../models/scanner_page.dart';
import '../services/scanner_orchestrator_service.dart';

/// Async orchestration of the per-page processing pipeline.
///
/// The state holds the last page produced by
/// [processCapturedPage], or null if nothing has been processed.
class ScannerProcessingNotifier extends AsyncNotifier<ScannerPage?> {
  final ScannerOrchestratorService _orchestrator =
      ScannerOrchestratorService();

  @override
  Future<ScannerPage?> build() async => null;

  /// Runs the processing pipeline on a freshly captured page
  /// image and returns the resulting [ScannerPage].
  ///
  /// Phase 9 Batch 9.5 — [sessionId] identifies the current
  /// scanning session. The orchestrator uses it to write page
  /// images under `sessions/<sessionId>/pages/`. The provider does
  /// not read session state itself; the caller supplies the id.
  Future<ScannerPage?> processCapturedPage({
    required String sessionId,
    required String capturedFilePath,
    required String pageId,
    required ScanSettings settings,
    CropData? cropData,
    double rotationDegrees = 0.0,
  }) async {
    state = const AsyncLoading();

    try {
      final page = await _orchestrator.processCapturedPage(
        sessionId: sessionId,
        capturedFilePath: capturedFilePath,
        pageId: pageId,
        settings: settings,
        cropData: cropData,
        rotationDegrees: rotationDegrees,
      );
      state = AsyncData(page);
      return page;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final scannerProcessingProvider =
    AsyncNotifierProvider<ScannerProcessingNotifier, ScannerPage?>(
  ScannerProcessingNotifier.new,
);