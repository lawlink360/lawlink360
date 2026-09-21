import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../widgets/tools/scanner_tool_tile.dart';
import 'pdf_tools/tools/scanner_compress_pdf_screen.dart';
import 'pdf_tools/tools/scanner_delete_pages_screen.dart';
import 'pdf_tools/tools/scanner_extract_pages_screen.dart';
import 'pdf_tools/tools/scanner_merge_pdf_screen.dart';
import 'pdf_tools/tools/scanner_page_numbers_pdf_screen.dart';
import 'pdf_tools/tools/scanner_protect_pdf_screen.dart';
import 'pdf_tools/tools/scanner_reorder_pages_screen.dart';
import 'pdf_tools/tools/scanner_rotate_pdf_screen.dart';
import 'pdf_tools/tools/scanner_split_pdf_screen.dart';
import 'pdf_tools/tools/scanner_watermark_pdf_screen.dart';
import 'pdf_tools/tools/scanner_metadata_pdf_screen.dart';

/// PDF Tools home for Scanner 360.
///
/// Phase 8 final wiring: each tile navigates to its tool wrapper,
/// which drives the generic [ScannerPdfToolFlowScreen].
class ScannerPdfToolsScreen extends StatelessWidget {
  const ScannerPdfToolsScreen({super.key});

  static final List<_PdfTool> _tools = [
    _PdfTool(
      icon: Icons.merge_type,
      title: 'Merge PDF',
      subtitle: 'Combine multiple PDFs into one.',
      builder: (_) => const ScannerMergePdfScreen(),
    ),
    _PdfTool(
      icon: Icons.call_split,
      title: 'Split PDF',
      subtitle: 'Split a PDF by pages or ranges.',
      builder: (_) => const ScannerSplitPdfScreen(),
    ),
    _PdfTool(
      icon: Icons.file_copy_outlined,
      title: 'Extract Pages',
      subtitle: 'Create a new PDF from selected pages.',
      builder: (_) => const ScannerExtractPagesScreen(),
    ),
    _PdfTool(
      icon: Icons.reorder,
      title: 'Reorder Pages',
      subtitle: 'Change the order of PDF pages.',
      builder: (_) => const ScannerReorderPagesScreen(),
    ),
    _PdfTool(
      icon: Icons.delete_outline,
      title: 'Delete Pages',
      subtitle: 'Remove pages from a PDF.',
      builder: (_) => const ScannerDeletePagesScreen(),
    ),
    _PdfTool(
      icon: Icons.rotate_90_degrees_cw,
      title: 'Rotate PDF',
      subtitle: 'Rotate one or more PDF pages.',
      builder: (_) => const ScannerRotatePdfScreen(),
    ),
    _PdfTool(
      icon: Icons.compress,
      title: 'Compress PDF',
      subtitle: 'Reduce PDF file size.',
      builder: (_) => const ScannerCompressPdfScreen(),
    ),
    _PdfTool(
      icon: Icons.lock_outline,
      title: 'Protect PDF',
      subtitle: 'Add password protection.',
      builder: (_) => const ScannerProtectPdfScreen(),
    ),
    _PdfTool(
      icon: Icons.branding_watermark_outlined,
      title: 'Add Watermark',
      subtitle: 'Overlay a text watermark.',
      builder: (_) => const ScannerWatermarkPdfScreen(),
    ),
    _PdfTool(
      icon: Icons.format_list_numbered,
      title: 'Add Page Numbers',
      subtitle: 'Insert page numbers.',
      builder: (_) => const ScannerPageNumbersPdfScreen(),
    ),
    _PdfTool(
      icon: Icons.info_outline,
      title: 'PDF Metadata',
      subtitle: 'Edit document information.',
      builder: (_) => const ScannerMetadataPdfScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('PDF Tools'),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: _tools.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final tool = _tools[index];
            return ScannerToolTile(
              icon: tool.icon,
              title: tool.title,
              subtitle: tool.subtitle,
              onTap: () => _handleToolTap(context, tool),
            );
          },
        ),
      ),
    );
  }

  void _handleToolTap(BuildContext context, _PdfTool tool) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: tool.builder),
    );
  }
}

class _PdfTool {
  const _PdfTool({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.builder,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final WidgetBuilder builder;
}