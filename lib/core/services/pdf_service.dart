import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  PdfService._();

  /// Default Urdu/Arabic font
  static Future<pw.Font> _loadFont() async {
    return pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/NotoNaskhArabic-Regular.ttf',
      ),
    );
  }

  /// Generate PDF document
  static Future<pw.Document> generatePdf({
    required String title,
    required String body,
    bool rtl = false,
  }) async {
    final pdf = pw.Document();

    final font = await _loadFont();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (context) => [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: font,
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Directionality(
            textDirection:
                rtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
            child: pw.Text(
              body,
              style: pw.TextStyle(
                font: font,
                fontSize: 15,
                lineSpacing: 5,
              ),
            ),
          ),
        ],
      ),
    );

    return pdf;
  }

  /// Preview / Print / Save PDF
  static Future<void> previewPdf({
    required String title,
    required String body,
    bool rtl = false,
  }) async {
    final pdf = await generatePdf(
      title: title,
      body: body,
      rtl: rtl,
    );

    await Printing.layoutPdf(
      name: "$title.pdf",
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  /// Return PDF bytes (for future file saving)
  static Future<Uint8List> pdfBytes({
    required String title,
    required String body,
    bool rtl = false,
  }) async {
    final pdf = await generatePdf(
      title: title,
      body: body,
      rtl: rtl,
    );

    return pdf.save();
  }
}