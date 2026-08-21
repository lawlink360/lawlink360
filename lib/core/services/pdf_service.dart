import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:lawlink360/core/features/lawyer_module/digital_clerk/models/fee_structure_model.dart';

class PdfService {
  PdfService._();

  // ============================================================
  // COLORS
  // ============================================================

  static const PdfColor navy = PdfColor.fromInt(0xFF13294B);
  static const PdfColor gold = PdfColor.fromInt(0xFFD4AF37);
  static const PdfColor grey = PdfColor.fromInt(0xFF6B7280);
  static const PdfColor lightGrey = PdfColor.fromInt(0xFFE5E7EB);
  static const PdfColor veryLightGrey = PdfColor.fromInt(0xFFF5F7FB);

  // ============================================================
  // DEFAULT URDU / ARABIC FONT
  // ============================================================

  static Future<pw.Font> _loadFont() async {
    return pw.Font.ttf(
      await rootBundle.load(
        'assets/fonts/NotoNaskhArabic-Regular.ttf',
      ),
    );
  }

  // ============================================================
  // EXISTING GENERIC PDF
  // DO NOT REMOVE
  // USED BY TRANSLATION
  // ============================================================

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
            textDirection: rtl ? pw.TextDirection.rtl : pw.TextDirection.ltr,
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

  // ============================================================
  // TRANSLATION PREVIEW / PRINT
  // ============================================================

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
      name: '$title.pdf',
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // ============================================================
  // EXISTING PDF BYTES
  // ============================================================

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

  // ============================================================
  // SIMPLE FEE STRUCTURE PDF
  // ============================================================

  static Future<pw.Document> generateFeeStructurePdf({
    required String title,
    required String body,
  }) async {
    final pdf = pw.Document();

    final font = await _loadFont();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(20, 12, 20, 12),
        build: (context) => [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: font,
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 3),
          pw.Divider(thickness: 0.4),
          pw.SizedBox(height: 3),
          pw.Directionality(
            textDirection: pw.TextDirection.ltr,
            child: pw.Text(
              body,
              style: pw.TextStyle(
                font: font,
                fontSize: 6.5,
                lineSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );

    return pdf;
  }

  // ============================================================
  // COMPLETE FEE STRUCTURE PDF
  //
  // IMPORTANT:
  // This version is specifically designed to remain
  // on ONE A4 PAGE.
  // ============================================================

  static Future<pw.Document> generateCompleteFeeStructurePdf({
    required FeeStructureModel feeStructure,

    required String firmName,
    required String address,
    required String phone,
    required String email,
    required String website,

    required String natureOfCase,

    required String dueDate,
  }) async {
    final pdf = pw.Document();

    final font = await _loadFont();

    // ==========================================================
    // LOAD LAWLINK360 LOGO
    // ==========================================================

    pw.MemoryImage? logo;

    try {
      final logoBytes = await rootBundle.load(
        'assets/images/lawlink360_logo.png',
      );

      logo = pw.MemoryImage(
        logoBytes.buffer.asUint8List(),
      );
    } catch (_) {
      logo = null;
    }

    // ==========================================================
    // A4 CONTENT WIDTH
    // ==========================================================

    const double pageHorizontalMargin = 28;

    final double contentWidth =
        PdfPageFormat.a4.width -
            (pageHorizontalMargin * 2);

    // ==========================================================
    // ONE A4 PAGE ONLY
    //
    // We intentionally use pw.Page instead of MultiPage.
    //
    // The complete content is placed inside FittedBox.
    // If the content is slightly too tall, the PDF package
    // automatically scales it down proportionally so that
    // everything remains on the same A4 page.
    // ==========================================================

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,

        margin: const pw.EdgeInsets.fromLTRB(
          pageHorizontalMargin,
          22,
          pageHorizontalMargin,
          22,
        ),

        build: (context) {
          return pw.FittedBox(
            fit: pw.BoxFit.contain,
            alignment: pw.Alignment.topCenter,
            child: pw.SizedBox(
              width: contentWidth,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                  // ==================================================
                  // HEADER
                  // ==================================================

                  _feePdfHeader(
                    font: font,
                    logo: logo,
                    firmName: firmName,
                    address: address,
                    phone: phone,
                    email: email,
                    website: website,
                  ),

                  _pdfDivider(),

                  pw.SizedBox(height: 5),

                  // ==================================================
                  // CLIENT INFORMATION
                  // ==================================================

                  _pdfSectionTitle(
                    'CLIENT INFORMATION',
                    font,
                  ),

                  pw.SizedBox(height: 6),

                  _pdfInfoLine(
                    label: 'Client Name:',
                    value: feeStructure.clientName ?? '',
                    font: font,
                  ),

                  pw.SizedBox(height: 5),

                  // ==================================================
                  // CASE TITLE
                  // ==================================================

                  _caseTitleLine(
                    font: font,
                    caseTitle: feeStructure.caseTitle ?? '',
                    oppositeParty: feeStructure.oppositeParty ?? '',
                  ),

                  pw.SizedBox(height: 5),

                  _pdfInfoLine(
                    label: 'Nature of Case:',
                    value: natureOfCase,
                    font: font,
                  ),

                  pw.SizedBox(height: 5),

                  _pdfInfoLine(
                    label: 'Case No.:',
                    value: feeStructure.caseNumber ?? '',
                    font: font,
                  ),

                  pw.SizedBox(height: 5),

                  _pdfInfoLine(
                    label: 'Date:',
                    value: _formatDate(
                      feeStructure.createdAt,
                    ),
                    font: font,
                  ),

                  _pdfDivider(),

                  pw.SizedBox(height: 2),

                  // ==================================================
                  // FEE DETAILS
                  // ==================================================

                  _pdfSectionTitle(
                    'FEE DETAILS',
                    font,
                  ),

                  pw.SizedBox(height: 6),

                  _feeItemsTable(
                    feeStructure.items,
                    font,
                  ),

                  pw.SizedBox(height: 7),

                  // ==================================================
                  // TOTALS
                  // ==================================================

                  _totalsTable(
                    feeStructure: feeStructure,
                    font: font,
                  ),

                  pw.SizedBox(height: 8),

                  // ==================================================
                  // DUE DATE
                  // ==================================================

                  if (feeStructure.remainingAmount > 0 ||
                      dueDate.trim().isNotEmpty)
                    _dueDateBox(
                      dueDate: dueDate,
                      font: font,
                    ),

                  pw.SizedBox(height: 8),

                  // ==================================================
                  // NOTES
                  // ==================================================

                  if (feeStructure.notes.trim().isNotEmpty) ...[
                    _pdfDivider(),

                    pw.SizedBox(height: 5),

                    _pdfSectionTitle(
                      'NOTES',
                      font,
                    ),

                    pw.SizedBox(height: 5),

                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(7),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: lightGrey,
                        ),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Text(
                        feeStructure.notes,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: 8.5,
                          color: navy,
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 8),
                  ],

                  // ==================================================
                  // SIGNATURES
                  // ==================================================

                  _signatureSection(font),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf;
  }

  // ============================================================
  // FEE PDF HEADER
  // ============================================================

  static pw.Widget _feePdfHeader({
    required pw.Font font,
    required pw.MemoryImage? logo,
    required String firmName,
    required String address,
    required String phone,
    required String email,
    required String website,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        // ======================================================
        // LEFT - LAW FIRM INFORMATION
        // ======================================================

        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              if (firmName.trim().isNotEmpty)
                pw.Text(
                  firmName,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: navy,
                  ),
                ),

              if (firmName.trim().isNotEmpty)
                pw.SizedBox(height: 5),

              if (address.trim().isNotEmpty)
                _headerInfo(
                  'Address:',
                  address,
                  font,
                ),

              if (phone.trim().isNotEmpty)
                _headerInfo(
                  'Phone:',
                  phone,
                  font,
                ),

              if (email.trim().isNotEmpty)
                _headerInfo(
                  'Email:',
                  email,
                  font,
                ),

              if (website.trim().isNotEmpty)
                _headerInfo(
                  'Website:',
                  website,
                  font,
                ),
            ],
          ),
        ),

        pw.SizedBox(width: 15),

        // ======================================================
        // RIGHT - LAWLINK360
        // ======================================================

        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [

            if (logo != null)
              pw.SizedBox(
                width: 58,
                height: 58,
                child: pw.Image(
                  logo,
                  fit: pw.BoxFit.contain,
                ),
              )
            else
              pw.Container(
                width: 58,
                height: 58,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: gold,
                    width: 1,
                  ),
                  borderRadius: pw.BorderRadius.circular(7),
                ),
                child: pw.Text(
                  'LL360',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: navy,
                  ),
                ),
              ),

            pw.SizedBox(height: 2),

            pw.Text(
              'LawLink360',
              style: pw.TextStyle(
                font: font,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: navy,
              ),
            ),

            pw.Text(
              'Legal Super App',
              style: pw.TextStyle(
                font: font,
                fontSize: 6.5,
                color: grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // HEADER INFO
  // ============================================================

  static pw.Widget _headerInfo(
    String label,
    String value,
    pw.Font font,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            '$label ',
            style: pw.TextStyle(
              font: font,
              fontSize: 7.5,
              fontWeight: pw.FontWeight.bold,
              color: navy,
            ),
          ),

          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                font: font,
                fontSize: 7.5,
                color: grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  static pw.Widget _pdfSectionTitle(
    String title,
    pw.Font font,
  ) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        font: font,
        fontSize: 9.5,
        fontWeight: pw.FontWeight.bold,
        color: navy,
      ),
    );
  }

  // ============================================================
  // INFORMATION LINE
  // ============================================================

  static pw.Widget _pdfInfoLine({
    required String label,
    required String value,
    required pw.Font font,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [

        pw.Text(
          label,
          style: pw.TextStyle(
            font: font,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
            color: grey,
          ),
        ),

        pw.SizedBox(width: 6),

        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.only(
              bottom: 1,
            ),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: grey,
                  width: 0.5,
                ),
              ),
            ),
            child: pw.Text(
              value.isEmpty ? ' ' : value,
              style: pw.TextStyle(
                font: font,
                fontSize: 8,
                color: navy,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CASE TITLE + V/S
  //
  // Result:
  //
  // Case Title: ____________________ V / S ____________________
  //
  // V / S remains centered between both parties.
  // ============================================================

  static pw.Widget _caseTitleLine({
    required pw.Font font,
    required String caseTitle,
    required String oppositeParty,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [

        pw.Text(
          'Case Title:',
          style: pw.TextStyle(
            font: font,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
            color: grey,
          ),
        ),

        pw.SizedBox(width: 6),

        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [

              // LEFT PARTY
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.only(
                    bottom: 1,
                  ),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: pw.Text(
                    caseTitle.isEmpty ? ' ' : caseTitle,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 8,
                      color: navy,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              // CENTER V/S
              pw.Container(
                width: 42,
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'V / S',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 7.5,
                    fontWeight: pw.FontWeight.bold,
                    color: navy,
                  ),
                ),
              ),

              // RIGHT PARTY
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.only(
                    bottom: 1,
                  ),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: pw.Text(
                    oppositeParty.isEmpty ? ' ' : oppositeParty,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 8,
                      color: navy,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FEE ITEMS TABLE
  // ============================================================

  static pw.Widget _feeItemsTable(
    List items,
    pw.Font font,
  ) {
    return pw.Table(
      border: pw.TableBorder(
        top: pw.BorderSide(
          color: lightGrey,
          width: 0.5,
        ),
        bottom: pw.BorderSide(
          color: lightGrey,
          width: 0.5,
        ),
        horizontalInside: pw.BorderSide(
          color: lightGrey,
          width: 0.3,
        ),
      ),

      columnWidths: {
        0: const pw.FlexColumnWidth(3.8),
        1: const pw.FlexColumnWidth(1.5),
      },

      children: [

        // HEADER
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: veryLightGrey,
          ),
          children: [

            _tableHeader(
              'Description',
              font,
              align: pw.TextAlign.left,
            ),

            _tableHeader(
              'Amount',
              font,
              align: pw.TextAlign.right,
            ),
          ],
        ),

        // EMPTY
        if (items.isEmpty)
          pw.TableRow(
            children: [

              _tableCell(
                'No fee entered',
                font,
              ),

              _tableCell(
                'Rs. 0.00/-',
                font,
                align: pw.TextAlign.right,
              ),
            ],
          ),

        // ITEMS
        ...items.map(
          (item) {
            return pw.TableRow(
              children: [

                _tableCell(
                  item.description,
                  font,
                ),

                _tableCell(
                  _formatAmount(
                    item.amount,
                  ),
                  font,
                  align: pw.TextAlign.right,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // TABLE HEADER
  // ============================================================

  static pw.Widget _tableHeader(
    String text,
    pw.Font font, {
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          font: font,
          fontSize: 7.5,
          fontWeight: pw.FontWeight.bold,
          color: navy,
        ),
      ),
    );
  }

  // ============================================================
  // TABLE CELL
  // ============================================================

  static pw.Widget _tableCell(
    String text,
    pw.Font font, {
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          font: font,
          fontSize: 7.5,
          color: navy,
        ),
      ),
    );
  }

  // ============================================================
  // TOTALS
  // ============================================================

  static pw.Widget _totalsTable({
    required FeeStructureModel feeStructure,
    required pw.Font font,
  }) {
    return pw.Column(
      children: [

        _amountSummaryRow(
          label: 'Total Amount:',
          amount: feeStructure.totalAmount,
          font: font,
        ),

        pw.SizedBox(height: 3),

        _amountSummaryRow(
          label: 'Paid Amount:',
          amount: feeStructure.paidAmount,
          font: font,
        ),

        pw.SizedBox(height: 3),

        pw.Container(
          padding: const pw.EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 5,
          ),
          decoration: pw.BoxDecoration(
            color: veryLightGrey,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: _amountSummaryRow(
            label: 'Pending Amount:',
            amount: feeStructure.remainingAmount,
            font: font,
            highlight: true,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // AMOUNT SUMMARY ROW
  // ============================================================

  static pw.Widget _amountSummaryRow({
    required String label,
    required double amount,
    required pw.Font font,
    bool highlight = false,
  }) {
    return pw.Row(
      children: [

        pw.Expanded(
          child: pw.Text(
            label,
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              font: font,
              fontSize: highlight ? 8.5 : 8,
              fontWeight: pw.FontWeight.bold,
              color: navy,
            ),
          ),
        ),

        pw.SizedBox(width: 8),

        pw.SizedBox(
          width: 90,
          child: pw.Text(
            _formatAmount(amount),
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              font: font,
              fontSize: highlight ? 9 : 8,
              fontWeight: pw.FontWeight.bold,
              color: highlight ? gold : navy,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DUE DATE BOX
  // ============================================================

  static pw.Widget _dueDateBox({
    required String dueDate,
    required pw.Font font,
  }) {
    return pw.Container(
      width: double.infinity,

      padding: const pw.EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: gold,
          width: 0.7,
        ),
        borderRadius: pw.BorderRadius.circular(4),
      ),

      child: pw.Text(
        dueDate.trim().isEmpty
            ? 'Kindly pay the remaining amount within due date.'
            : 'Kindly pay the remaining amount within due date: $dueDate',

        style: pw.TextStyle(
          font: font,
          fontSize: 8,
          fontWeight: pw.FontWeight.bold,
          color: navy,
        ),
      ),
    );
  }

  // ============================================================
  // SIGNATURE SECTION
  // ============================================================

  static pw.Widget _signatureSection(
    pw.Font font,
  ) {
    return pw.Row(
      children: [

        pw.Expanded(
          child: _signatureLine(
            'Signature of Counsel',
            font,
          ),
        ),

        pw.SizedBox(width: 30),

        pw.Expanded(
          child: _signatureLine(
            'Signature of Client',
            font,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SIGNATURE LINE
  // ============================================================

  static pw.Widget _signatureLine(
    String title,
    pw.Font font,
  ) {
    return pw.Column(
      children: [

        pw.SizedBox(height: 18),

        pw.Container(
          height: 0.6,
          color: grey,
        ),

        pw.SizedBox(height: 3),

        pw.Text(
          title,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            font: font,
            fontSize: 7,
            color: grey,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  static pw.Widget _pdfDivider() {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: pw.Container(
        height: 0.6,
        color: lightGrey,
      ),
    );
  }

  // ============================================================
  // FORMAT AMOUNT
  //
  // Examples:
  //
  // 20000
  // Rs. 20,000.00/-
  //
  // 5000
  // Rs. 5,000.00/-
  //
  // 1250000.50
  // Rs. 1,250,000.50/-
  // ============================================================

  static String _formatAmount(
    double amount,
  ) {
    final fixed = amount.toStringAsFixed(2);

    final parts = fixed.split('.');

    final integerPart = parts[0];

    final decimalPart = parts.length > 1 ? parts[1] : '00';

    final buffer = StringBuffer();

    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        buffer.write(',');
      }

      buffer.write(integerPart[i]);
    }

    return 'Rs. ${buffer.toString()}.$decimalPart/-';
  }

  // ============================================================
  // FORMAT DATE
  // ============================================================

  static String _formatDate(
    DateTime date,
  ) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}