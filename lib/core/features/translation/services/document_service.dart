import 'package:printing/printing.dart';
import 'package:lawlink360/core/features/translation/services/pdf_service.dart';

class DocumentService {
  final PdfService _pdfService = PdfService();

  Future<void> printTranslation(String text) async {
    final pdf = await _pdfService.generatePdf(text);

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}