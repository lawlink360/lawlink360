import 'package:flutter/material.dart';

import '../widgets/scanner_category_header.dart';
import '../widgets/scanner_feature_card.dart';
import 'my_case_files_screen.dart';
import '../screens/smart_camera_screen.dart';
import '../models/scanner_mode.dart';

class ScannerConverterHomeScreen extends StatelessWidget {
  const ScannerConverterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scanner & Converter 360",
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search tools...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Scanner"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.start,
              children: [
                ScannerFeatureCard(
                  icon: Icons.document_scanner_outlined,
                  title: "Quick Scan",
                  subtitle: "",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SmartCameraScreen(
                          initialMode: ScannerMode.document,
                        ),
                      ),
                    );
                  },
                ),

                ScannerFeatureCard(
                  icon: Icons.badge_outlined,
                  title: "Id Scan",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.photo_library_outlined,
                  title: "Gallery",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.qr_code_scanner,
                  title: "QR Scan",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.menu_book_outlined,
                  title: "Scan Book",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.dashboard_customize_outlined,
                  title: "Whiteboard",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.badge_outlined,
                  title: "ID Photo",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.text_snippet_outlined,
                  title: "Extract Text",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.badge_outlined,
                  title: "Time Stamp",
                  subtitle: "",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Case Management"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ScannerFeatureCard(
                  icon: Icons.folder_open,
                  title: "My Cases",
                  subtitle: "",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyCaseFilesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Converters"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ScannerFeatureCard(
                  icon: Icons.picture_as_pdf_outlined,
                  title: "Word → PDF",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.description_outlined,
                  title: "PDF → Word",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.image_outlined,
                  title: "Image ↔ PDF",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.table_chart_outlined,
                  title: "Excel → PDF",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.slideshow_outlined,
                  title: "PPT → PDF",
                  subtitle: "",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Smart Editor"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "PDF Tools",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Add Watermark",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Smart Erase",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Merge Pdf",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Copmress",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.text_snippet_outlined,
                  title: "OCR",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Reorder Pages",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Protect Pdf",
                  subtitle: "",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Imports Center"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Import Images",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Import Files",
                  subtitle: "",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 26),

            const ScannerCategoryHeader(title: "Quick Actions & Share"),

            const SizedBox(height: 14),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: "Scan Code",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.share_outlined,
                  title: "Share",
                  subtitle: "",
                  onTap: () {},
                ),

                ScannerFeatureCard(
                  icon: Icons.print_outlined,
                  title: "Print",
                  subtitle: "",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
