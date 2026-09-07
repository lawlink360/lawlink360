import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'scanner_category_header.dart';
import 'scanner_feature_card.dart';

class ScannerConverterHomeScreen extends StatelessWidget {
  const ScannerConverterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Scanner & Converter 360',
          style: AppTextStyles.title.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xxl,
        ),
        children: [
          const ScannerCategoryHeader(
            title: 'Scanner',
          ),
          _FeatureSection(
            children: [
              ScannerFeatureCard(
                icon: Icons.document_scanner_outlined,
                title: 'Scan Document',
                subtitle: 'Camera Scanner',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.photo_library_outlined,
                title: 'Import Images',
                subtitle: 'Gallery Import',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.qr_code_scanner,
                title: 'QR Code Scanner',
                subtitle: 'Scan QR Codes',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.folder_open_outlined,
                title: 'My Case Files',
                subtitle: 'Manage scanned documents',
                onTap: () {},
              ),
            ],
          ),
          const ScannerCategoryHeader(
            title: 'PDF & Converter',
          ),
          _FeatureSection(
            children: [
              ScannerFeatureCard(
                icon: Icons.picture_as_pdf_outlined,
                title: 'Word → PDF',
                subtitle: 'Convert documents',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.description_outlined,
                title: 'PDF → Word',
                subtitle: 'Editable documents',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.image_outlined,
                title: 'Image ↔ PDF',
                subtitle: 'Convert images & PDFs',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.build_circle_outlined,
                title: 'PDF Tools',
                subtitle: 'Merge • Split • Compress',
                onTap: () {},
              ),
            ],
          ),
          const ScannerCategoryHeader(
            title: 'Utilities',
          ),
          _FeatureSection(
            children: [
              ScannerFeatureCard(
                icon: Icons.text_snippet_outlined,
                title: 'OCR Text Extraction',
                subtitle: 'Extract text from images',
                onTap: () {},
              ),
              ScannerFeatureCard(
                icon: Icons.share_outlined,
                title: 'Share & Print',
                subtitle: 'Share or print documents',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  final List<Widget> children;

  const _FeatureSection({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassDark,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.sm,
        children: children,
      ),
    );
  }
}