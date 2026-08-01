import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:lawlink360/core/features/translation/services/pdf_service.dart';

class DownloadService {
  final PdfService _pdfService = PdfService();

  Future<String> saveTranslationAsPdf(
    String text,
    String fileName,
  ) async {
    final pdf = await _pdfService.generatePdf(text);

    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/$fileName.pdf',
    );

    await file.writeAsBytes(
      await pdf.save(),
    );

    return file.path;
  }
}