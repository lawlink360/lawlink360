import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../providers/scanner_documents_provider.dart';
import '../shared/scanner_empty_view.dart';
import '../shared/scanner_error_view.dart';
import '../shared/scanner_section_header.dart';
import 'scanner_home_recent_card.dart';

/// Presentation component that renders the provider's document
/// list state.
///
/// This widget does not trigger any initial load. The owning screen
/// is responsible for calling `loadRecent()` in its own
/// post-frame callback.
class ScannerHomeRecentSection extends ConsumerWidget {
  const ScannerHomeRecentSection({
    super.key,
    required this.onOpenDocument,
    required this.onSeeAll,
  });

  /// Called with the id of a tapped document.
  final void Function(String id) onOpenDocument;

  /// Called when the user taps "View all".
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerDocumentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScannerSectionHeader(
          title: 'Recent Documents',
          actionLabel: 'View all',
          onAction: onSeeAll,
        ),
        const SizedBox(height: AppSpacing.md),
        state.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: ScannerErrorView(
              title: 'Unable to load documents',
              message: e.toString(),
            ),
          ),
          data: (docs) {
            if (docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: ScannerEmptyView(
                  icon: Icons.folder_outlined,
                  title: 'No documents yet',
                  subtitle: 'Your scanned documents will appear here.',
                ),
              );
            }

            final recent = docs.take(5).toList(growable: false);

            return SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recent.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  final doc = recent[index];
                  return SizedBox(
                    width: 200,
                    child: ScannerHomeRecentCard(
                      document: doc,
                      onTap: () => onOpenDocument(doc.id),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}