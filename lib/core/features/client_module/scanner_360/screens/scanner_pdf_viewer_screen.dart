import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pdf_format;
import 'package:printing/printing.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/pdf_document.dart';

/// Full-screen PDF viewer for Scanner 360.
///
/// Reads the saved PDF bytes from [PdfDocument.filePath] and
/// renders them through the installed `printing` package's
/// [PdfPreview]. Uses [PdfPreview]'s built-in share and print
/// actions.
///
/// Note: PdfPreview is configured without a custom `onError`
/// callback. If the PDF bytes fail to load, the loading indicator
/// remains visible until the user navigates back.
class ScannerPdfViewerScreen extends StatelessWidget {
  const ScannerPdfViewerScreen({
    super.key,
    required this.pdfDocument,
    this.documentName,
  });

  final PdfDocument pdfDocument;
  final String? documentName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: Text(
          documentName?.trim().isNotEmpty == true
              ? documentName!.trim()
              : 'PDF',
          style: AppTextStyles.title,
        ),
      ),
      body: PdfPreview(
        build: _loadBytes,
        useActions: true,
        allowSharing: true,
        allowPrinting: true,
        pdfFileName: _pdfFileName,
        loadingWidget: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _loadBytes(
    pdf_format.PdfPageFormat format,
  ) async {
    final file = File(pdfDocument.filePath);

    if (!await file.exists()) {
      throw Exception(
        'PDF not found: ${pdfDocument.filePath}',
      );
    }

    return await file.readAsBytes();
  }

  String get _pdfFileName {
    final name = documentName?.trim();

    if (name == null || name.isEmpty) {
      return 'document.pdf';
    }

    if (name.toLowerCase().endsWith('.pdf')) {
      return name;
    }

    return '$name.pdf';
  }
}