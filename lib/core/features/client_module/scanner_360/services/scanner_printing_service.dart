import 'dart:io';

import 'package:printing/printing.dart';

/// Raised when a print job cannot be started.
class ScannerPrintingException implements Exception {
  const ScannerPrintingException(this.message);
  final String message;

  @override
  String toString() => 'ScannerPrintingException: $message';
}

/// Sends a PDF file to the OS print dialog.
class ScannerPrintingService {
  const ScannerPrintingService();

  /// Opens the OS print dialog for the PDF at [filePath].
  ///
  /// Returns true if the print job was completed, false otherwise.
  Future<bool> printPdfFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw ScannerPrintingException(
        'PDF file does not exist: $filePath',
      );
    }

    final bytes = await file.readAsBytes();
    return Printing.layoutPdf(
      onLayout: (_) async => bytes,
    );
  }
}