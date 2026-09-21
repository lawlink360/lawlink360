import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../widgets/tools/scanner_tool_tile.dart';
import 'document_tools/scanner_document_ocr_screen.dart';
import 'document_tools/scanner_document_print_screen.dart';

/// Document Tools home for Scanner 360.
///
/// Phase 7D establishes the screen and the tool grid. Each tool
/// shows a placeholder SnackBar until its real implementation
/// phase.
class ScannerDocumentToolsScreen extends StatelessWidget {
  const ScannerDocumentToolsScreen({super.key});

  static const List<_DocumentTool> _tools = [
    _DocumentTool(
      icon: Icons.text_fields,
      title: 'OCR',
      subtitle: 'Extract text from the document.',
      implemented: true,
    ),
    _DocumentTool(
      icon: Icons.draw_outlined,
      title: 'Annotate',
      subtitle: 'Add notes, highlights and shapes.',
    ),
    _DocumentTool(
      icon: Icons.gesture,
      title: 'Sign',
      subtitle: 'Add a handwritten signature.',
    ),
    _DocumentTool(
      icon: Icons.edit_note,
      title: 'Fill',
      subtitle: 'Fill in form fields on a document.',
    ),
    _DocumentTool(
      icon: Icons.print_outlined,
      title: 'Print',
      subtitle: 'Send the document to a printer.',
      implemented: true,
    ),
    _DocumentTool(
      icon: Icons.share_outlined,
      title: 'Share',
      subtitle: 'Share the document with others.',
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
        title: const Text('Document Tools'),
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

  void _handleToolTap(BuildContext context, _DocumentTool tool) {
    if (tool.title == 'OCR') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ScannerDocumentOcrScreen(),
        ),
      );
      return;
    }
    if (tool.title == 'Print') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ScannerDocumentPrintScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${tool.title} will be available in a later phase.',
        ),
      ),
    );
  }
}

class _DocumentTool {
  const _DocumentTool({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.implemented = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool implemented;
}