import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document.dart';
import '../../providers/scanner_documents_provider.dart';
import '../../widgets/shared/scanner_empty_view.dart';
import '../../widgets/shared/scanner_error_view.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Lists scanner documents that have a saved PDF and returns the
/// selected PDF's file path to the caller via `Navigator.pop`.
class ScannerPdfLibraryPickerScreen extends ConsumerStatefulWidget {
  const ScannerPdfLibraryPickerScreen({super.key});

  @override
  ConsumerState<ScannerPdfLibraryPickerScreen> createState() =>
      _ScannerPdfLibraryPickerScreenState();
}

class _ScannerPdfLibraryPickerScreenState
    extends ConsumerState<ScannerPdfLibraryPickerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scannerDocumentsProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerDocumentsProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Scanner Library'),
      ),
      body: Stack(
        children: [
          state.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => ScannerErrorView(
              title: 'Unable to load library',
              message: e.toString(),
              onRetry: () =>
                  ref.read(scannerDocumentsProvider.notifier).refresh(),
              retryLabel: 'Retry',
            ),
            data: (docs) {
              final withPdf = docs
                  .where((d) => d.pdfDocument != null)
                  .toList(growable: false);

              if (withPdf.isEmpty) {
                return const ScannerEmptyView(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'No PDFs yet',
                  subtitle:
                      'Saved documents that contain a PDF will appear here.',
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: withPdf.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final doc = withPdf[index];
                  return _LibraryTile(
                    document: doc,
                    onTap: () => _handleTap(doc),
                  );
                },
              );
            },
          ),
          state.isLoading
              ? const ScannerLoadingOverlay(
                  label: 'Loading library…',
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  void _handleTap(ScannerDocument document) {
    final path = document.pdfDocument?.filePath;
    if (path == null || path.isEmpty) return;
    Navigator.of(context).pop(path);
  }
}

class _LibraryTile extends StatelessWidget {
  const _LibraryTile({
    required this.document,
    required this.onTap,
  });

  final ScannerDocument document;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final meta = document.metadata;
    return Material(
      color: AppColors.lightSurface,
      child: ListTile(
        onTap: onTap,
        leading: const Icon(
          Icons.picture_as_pdf_outlined,
          color: AppColors.primary,
        ),
        title: Text(
          meta.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body,
        ),
        subtitle: Text(
          '${meta.pageCount} page${meta.pageCount == 1 ? '' : 's'}',
          style: AppTextStyles.caption,
        ),
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
      ),
    );
  }
}