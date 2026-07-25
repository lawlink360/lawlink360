import 'package:flutter/material.dart';

import '../widgets/scanner_category_header.dart';
import '../widgets/scanner_feature_card.dart';

class ScannerConverterHomeScreen extends StatelessWidget {
  const ScannerConverterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scanner & Converter 360",
          style: TextStyle(
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const ScannerCategoryHeader(
            title: "Scanner",
          ),

          ScannerFeatureCard(
            icon: Icons.document_scanner_outlined,
            title: "Scan Document",
            subtitle: "Camera Scanner",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.photo_library_outlined,
            title: "Import Images",
            subtitle: "Gallery Import",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.qr_code_scanner,
            title: "QR Code Scanner",
            subtitle: "Scan QR Codes",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.folder_open,
            title: "My Case Files",
            subtitle: "Manage scanned documents",
            onTap: () {},
          ),

          const ScannerCategoryHeader(
            title: "PDF & Converter",
          ),

          ScannerFeatureCard(
            icon: Icons.picture_as_pdf_outlined,
            title: "Word → PDF",
            subtitle: "Convert documents",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.description_outlined,
            title: "PDF → Word",
            subtitle: "Editable documents",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.image_outlined,
            title: "Image ↔ PDF",
            subtitle: "Convert images & PDFs",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.build_circle_outlined,
            title: "PDF Tools",
            subtitle: "Merge • Split • Compress",
            onTap: () {},
          ),

          const ScannerCategoryHeader(
            title: "Utilities",
          ),

          ScannerFeatureCard(
            icon: Icons.text_snippet_outlined,
            title: "OCR Text Extraction",
            subtitle: "Extract text from images",
            onTap: () {},
          ),

          ScannerFeatureCard(
            icon: Icons.share_outlined,
            title: "Share & Print",
            subtitle: "Share or print documents",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}