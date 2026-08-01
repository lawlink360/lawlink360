import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<pw.Document> generatePdf(String text) async {
    final pdf = pw.Document();

    final font = pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/NotoNaskhArabic-Regular.ttf',
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Text(
                text,
                style: pw.TextStyle(
                  font: font,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}