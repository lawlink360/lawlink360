import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/scanner_mode.dart';
import '../widgets/scanner_category_header.dart';
import '../widgets/scanner_feature_card.dart';
import '../screens/my_case_files_screen.dart';
import '../screens/smart_camera_screen.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchField(),
            const SizedBox(height: AppSpacing.sm),

            const ScannerCategoryHeader(title: 'Scanner'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Quick Scan',
                  subtitle: '',
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
                  title: 'ID Scan',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.photo_library_outlined,
                  title: 'Gallery',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.qr_code_scanner,
                  title: 'QR Scan',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.menu_book_outlined,
                  title: 'Scan Book',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.dashboard_customize_outlined,
                  title: 'Whiteboard',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.badge_outlined,
                  title: 'ID Photo',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.text_snippet_outlined,
                  title: 'Extract Text',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.badge_outlined,
                  title: 'Time Stamp',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const ScannerCategoryHeader(title: 'Case Management'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.folder_open_outlined,
                  title: 'My Cases',
                  subtitle: '',
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

            const ScannerCategoryHeader(title: 'Converters'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Word → PDF',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.description_outlined,
                  title: 'PDF → Word',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.image_outlined,
                  title: 'Image ↔ PDF',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.table_chart_outlined,
                  title: 'Excel → PDF',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.slideshow_outlined,
                  title: 'PPT → PDF',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const ScannerCategoryHeader(title: 'Smart Editor'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.layers_outlined,
                  title: 'PDF Tools',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Add Watermark',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.auto_fix_high_outlined,
                  title: 'Smart Erase',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.merge_type_outlined,
                  title: 'Merge PDF',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.compress_outlined,
                  title: 'Compress',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.text_snippet_outlined,
                  title: 'OCR',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.reorder_outlined,
                  title: 'Reorder Pages',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.lock_outline,
                  title: 'Protect PDF',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const ScannerCategoryHeader(title: 'Imports Center'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.photo_library_outlined,
                  title: 'Import Images',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.file_open_outlined,
                  title: 'Import Files',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),

            const ScannerCategoryHeader(title: 'Quick Actions & Share'),
            _buildFeatureWrap(
              context,
              [
                ScannerFeatureCard(
                  icon: Icons.qr_code_scanner_outlined,
                  title: 'Scan Code',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.share_outlined,
                  title: 'Share',
                  subtitle: '',
                  onTap: () {},
                ),
                ScannerFeatureCard(
                  icon: Icons.print_outlined,
                  title: 'Print',
                  subtitle: '',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureWrap(
    BuildContext context,
    List<Widget> children,
  ) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: children,
    );
  }
}

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.body.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Search tools...',
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}