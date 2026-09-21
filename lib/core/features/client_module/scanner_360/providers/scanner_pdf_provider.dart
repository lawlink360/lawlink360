import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scanner_document.dart';
import '../models/scanner_document_category.dart';
import '../models/scanner_export_format.dart';
import '../models/scanner_session.dart';
import '../services/scanner_orchestrator_service.dart';

/// Async PDF / document export state.
///
/// The state holds the last produced [ScannerDocument], or null if
/// no export has been performed in this session.
class ScannerPdfNotifier extends AsyncNotifier<ScannerDocument?> {
  final ScannerOrchestratorService _orchestrator =
      ScannerOrchestratorService();

  @override
  Future<ScannerDocument?> build() async => null;

  /// Exports the given [session] and returns the produced document.
  Future<ScannerDocument?> exportDocument({
    required String documentId,
    required ScannerSession session,
    required ScannerExportFormat format,
    ScannerDocumentCategory? category,
    List<String> tags = const [],
    String? nameOverride,
  }) async {
    state = const AsyncLoading();

    try {
      final document = await _orchestrator.exportDocument(
        documentId: documentId,
        session: session,
        format: format,
        category: category,
        tags: tags,
        nameOverride: nameOverride,
      );
      state = AsyncData(document);
      return document;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

final scannerPdfProvider =
    AsyncNotifierProvider<ScannerPdfNotifier, ScannerDocument?>(
  ScannerPdfNotifier.new,
);