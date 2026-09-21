import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scan_settings.dart';
import '../models/scanner_mode.dart';
import '../models/scanner_session.dart';

/// Session state for Scanner 360.
///
/// The state holds the current [ScannerSession], or null if no
/// session is active.
///
/// This notifier is synchronous by contract. Consumers access the
/// current session as `ScannerSession?`:
///
///     final ScannerSession? session = ref.read(scannerSessionProvider);
///
/// Phase 9 Batch 9.7 — the cross-session cleanup coordination lives
/// in [ScannerHomeScreen], which reads the previous session,
/// awaits [ScannerPagesNotifier.resetForNewSession] on the pages
/// provider, and then calls [startSession] synchronously. This
/// provider is not responsible for asynchronous cleanup and does
/// not depend on the pages provider.
class ScannerSessionNotifier extends Notifier<ScannerSession?> {
  @override
  ScannerSession? build() => null;

  /// Starts a new scanning session.
  ///
  /// Synchronous by design. The caller is responsible for any
  /// asynchronous cleanup of a previous session before invoking
  /// this method.
  void startSession({
    required ScannerMode mode,
    required ScanSettings settings,
  }) {
    final now = DateTime.now();
    state = ScannerSession(
      id: 'session_${now.microsecondsSinceEpoch}',
      mode: mode,
      pages: const [],
      settings: settings,
      startedAt: now,
      isDirty: false,
    );
  }

  /// Updates the current session's [ScannerMode] while preserving
  /// all other session fields.
  ///
  /// If no session is active, this is a no-op.
  void updateMode(ScannerMode mode) {
    final current = state;
    if (current == null) return;
    state = current.copyWith(mode: mode);
  }

  /// Marks the current session as saved (clears the dirty flag).
  void markSaved() {
    final current = state;
    if (current == null) return;
    state = current.copyWith(isDirty: false);
  }

  /// Clears the current session.
  void clearSession() {
    state = null;
  }
}

final scannerSessionProvider =
    NotifierProvider<ScannerSessionNotifier, ScannerSession?>(
  ScannerSessionNotifier.new,
);