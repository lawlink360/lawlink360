import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scan_filter.dart';
import '../models/scan_settings.dart';
import '../models/scanner_export_format.dart';
import '../models/scanner_language.dart';

/// Manages the current [ScanSettings] used for new sessions.
///
/// Phase 5 keeps these settings in memory only. Persistence is
/// deferred to a later phase.
class ScannerSettingsNotifier extends Notifier<ScanSettings> {
  @override
  ScanSettings build() => const ScanSettings();

  /// Replaces the entire settings object.
  void update(ScanSettings settings) {
    state = settings;
  }

  void setAutoCapture(bool value) {
    state = state.copyWith(autoCapture: value);
  }

  void setDefaultFlash(ScannerFlashMode value) {
    state = state.copyWith(defaultFlash: value);
  }

  void setDefaultFilter(ScanFilter value) {
    state = state.copyWith(defaultFilter: value);
  }

  void setOcrLanguage(ScannerLanguage value) {
    state = state.copyWith(ocrLanguage: value);
  }

  void setSaveFormat(ScannerExportFormat value) {
    state = state.copyWith(saveFormat: value);
  }

  void setAutoEnhance(bool value) {
    state = state.copyWith(autoEnhance: value);
  }

  void setImageQuality(ScannerImageQuality value) {
    state = state.copyWith(imageQuality: value);
  }

  void setPdfQuality(ScannerPdfQuality value) {
    state = state.copyWith(pdfQuality: value);
  }

  /// Restores default settings.
  void reset() {
    state = const ScanSettings();
  }
}

final scannerSettingsProvider =
    NotifierProvider<ScannerSettingsNotifier, ScanSettings>(
  ScannerSettingsNotifier.new,
);