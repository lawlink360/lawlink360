import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:lawlink360/core/services/pdf_service.dart';

class DownloadService {
  Future<String> saveTranslationAsPdf(
    String text,
    String fileName,
  ) async {
    final pdf = await PdfService.generatePdf(
      title: fileName,
      body: text,
      rtl: true,
    );

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