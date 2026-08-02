import 'package:printing/printing.dart';
import 'package:lawlink360/core/services/pdf_service.dart';

class DocumentService {
  Future<void> printTranslation(String text) async {
    final pdf = await PdfService.generatePdf(
      title: "Translated Document",
      body: text,
      rtl: true,
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}