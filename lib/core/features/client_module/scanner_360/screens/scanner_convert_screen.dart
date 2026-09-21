import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../widgets/tools/scanner_tool_tile.dart';
import 'convert/scanner_images_to_pdf_screen.dart';

/// Convert home for Scanner 360.
class ScannerConvertScreen extends StatelessWidget {
  const ScannerConvertScreen({super.key});

  static const List<_ConvertTask> _tasks = [
    _ConvertTask(
      icon: Icons.image_outlined,
      title: 'Images → PDF',
      subtitle: 'Combine images into a single PDF.',
      implemented: true,
    ),
    _ConvertTask(
      icon: Icons.picture_as_pdf_outlined,
      title: 'PDF → Images',
      subtitle: 'Export PDF pages as images.',
    ),
    _ConvertTask(
      icon: Icons.text_fields,
      title: 'Image → Text',
      subtitle: 'Extract text from an image.',
    ),
    _ConvertTask(
      icon: Icons.text_snippet_outlined,
      title: 'PDF → Text',
      subtitle: 'Extract text from a PDF.',
    ),
    _ConvertTask(
      icon: Icons.search,
      title: 'Searchable PDF',
      subtitle: 'Create a searchable PDF from a scan.',
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
        title: const Text('Convert'),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: _tasks.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return ScannerToolTile(
              icon: task.icon,
              title: task.title,
              subtitle: task.subtitle,
              onTap: () => _handleTaskTap(context, task),
            );
          },
        ),
      ),
    );
  }

  void _handleTaskTap(BuildContext context, _ConvertTask task) {
    if (task.implemented) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ScannerImagesToPdfScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${task.title} will be available in a later phase.',
        ),
      ),
    );
  }
}

class _ConvertTask {
  const _ConvertTask({
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