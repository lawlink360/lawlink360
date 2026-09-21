import 'package:meta/meta.dart';

import 'scan_filter.dart';
import 'scanner_export_format.dart';
import 'scanner_language.dart';

enum ScannerFlashMode {
  off,
  auto,
  on,
}

enum ScannerImageQuality {
  low,
  medium,
  high,
}

enum ScannerPdfQuality {
  low,
  medium,
  high,
}

@immutable
class ScanSettings {
  const ScanSettings({
    this.autoCapture = false,
    this.defaultFlash = ScannerFlashMode.auto,
    this.defaultFilter = ScanFilter.original,
    this.imageQuality = ScannerImageQuality.high,
    this.pdfQuality = ScannerPdfQuality.high,
    this.ocrLanguage = ScannerLanguage.latin,
    this.autoEnhance = true,
    this.saveFormat = ScannerExportFormat.pdf,
  });

  final bool autoCapture;
  final ScannerFlashMode defaultFlash;
  final ScanFilter defaultFilter;
  final ScannerImageQuality imageQuality;
  final ScannerPdfQuality pdfQuality;
  final ScannerLanguage ocrLanguage;
  final bool autoEnhance;
  final ScannerExportFormat saveFormat;

  ScanSettings copyWith({
    bool? autoCapture,
    ScannerFlashMode? defaultFlash,
    ScanFilter? defaultFilter,
    ScannerImageQuality? imageQuality,
    ScannerPdfQuality? pdfQuality,
    ScannerLanguage? ocrLanguage,
    bool? autoEnhance,
    ScannerExportFormat? saveFormat,
  }) {
    return ScanSettings(
      autoCapture: autoCapture ?? this.autoCapture,
      defaultFlash: defaultFlash ?? this.defaultFlash,
      defaultFilter: defaultFilter ?? this.defaultFilter,
      imageQuality: imageQuality ?? this.imageQuality,
      pdfQuality: pdfQuality ?? this.pdfQuality,
      ocrLanguage: ocrLanguage ?? this.ocrLanguage,
      autoEnhance: autoEnhance ?? this.autoEnhance,
      saveFormat: saveFormat ?? this.saveFormat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autoCapture': autoCapture,
      'defaultFlash': defaultFlash.name,
      'defaultFilter': defaultFilter.name,
      'imageQuality': imageQuality.name,
      'pdfQuality': pdfQuality.name,
      'ocrLanguage': ocrLanguage.name,
      'autoEnhance': autoEnhance,
      'saveFormat': saveFormat.name,
    };
  }

  factory ScanSettings.fromMap(Map<String, dynamic> map) {
    return ScanSettings(
      autoCapture: map['autoCapture'] as bool? ?? false,
      defaultFlash: ScannerFlashMode.values.firstWhere(
        (e) => e.name == map['defaultFlash'],
        orElse: () => ScannerFlashMode.auto,
      ),
      defaultFilter: ScanFilter.values.firstWhere(
        (e) => e.name == map['defaultFilter'],
        orElse: () => ScanFilter.original,
      ),
      imageQuality: ScannerImageQuality.values.firstWhere(
        (e) => e.name == map['imageQuality'],
        orElse: () => ScannerImageQuality.high,
      ),
      pdfQuality: ScannerPdfQuality.values.firstWhere(
        (e) => e.name == map['pdfQuality'],
        orElse: () => ScannerPdfQuality.high,
      ),
      ocrLanguage: ScannerLanguage.values.firstWhere(
        (e) => e.name == map['ocrLanguage'],
        orElse: () => ScannerLanguage.latin,
      ),
      autoEnhance: map['autoEnhance'] as bool? ?? true,
      saveFormat: ScannerExportFormat.values.firstWhere(
        (e) => e.name == map['saveFormat'],
        orElse: () => ScannerExportFormat.pdf,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanSettings &&
        other.autoCapture == autoCapture &&
        other.defaultFlash == defaultFlash &&
        other.defaultFilter == defaultFilter &&
        other.imageQuality == imageQuality &&
        other.pdfQuality == pdfQuality &&
        other.ocrLanguage == ocrLanguage &&
        other.autoEnhance == autoEnhance &&
        other.saveFormat == saveFormat;
  }

  @override
  int get hashCode => Object.hash(
        autoCapture,
        defaultFlash,
        defaultFilter,
        imageQuality,
        pdfQuality,
        ocrLanguage,
        autoEnhance,
        saveFormat,
      );
}