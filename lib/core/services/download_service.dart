import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:lawlink360/core/services/pdf_service.dart';

class DownloadService {
  const DownloadService();

  // ============================================================
  // GENERIC PDF SAVE
  // ============================================================

  Future<String> savePdf({
    required String title,
    required String body,
    bool rtl = false,
  }) async {
    final pdfBytes = await PdfService.pdfBytes(
      title: title,
      body: body,
      rtl: rtl,
    );

    final directory =
        await getApplicationDocumentsDirectory();

    final safeFileName = _sanitizeFileName(title);

    final file = File(
      '${directory.path}/$safeFileName.pdf',
    );

    await file.writeAsBytes(
      pdfBytes,
      flush: true,
    );

    return file.path;
  }

  // ============================================================
  // TRANSLATION COMPATIBILITY
  // ============================================================

  Future<String> saveTranslationAsPdf(
    String text,
    String fileName,
  ) async {
    return savePdf(
      title: fileName,
      body: text,
      rtl: true,
    );
  }

  // ============================================================
  // SAFE FILE NAME
  // ============================================================

  String _sanitizeFileName(String fileName) {
    final cleaned = fileName
        .trim()
        .replaceAll(
          RegExp(r'[\\/:*?"<>|]'),
          '_',
        );

    if (cleaned.isEmpty) {
      return 'LawLink360_Document';
    }

    return cleaned;
  }
}