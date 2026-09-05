import 'package:flutter/material.dart';

import '../models/law_model.dart';
import '../widgets/law_card.dart';
import 'law_detail_screen.dart';

class LawBookmarkScreen extends StatelessWidget {
  const LawBookmarkScreen({
    super.key,
    this.bookmarkedLaws = const [],
  });

  final List<LawModel> bookmarkedLaws;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: navy,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bookmarked Laws',
          style: TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (bookmarkedLaws.isNotEmpty)
            IconButton(
              tooltip: 'Clear All',
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: navy,
              ),
              onPressed: () => _showClearConfirmation(context),
            ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: bookmarkedLaws.isEmpty
            ? _buildEmptyState(context)
            : _buildBookmarkList(context),
      ),
    );
  }

  Widget _buildBookmarkList(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              14,
            ),
            child: _buildSummary(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            32,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final law = bookmarkedLaws[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: LawCard(
                    law: law,
                    onTap: () => _openLaw(
                      context,
                      law,
                    ),
                  ),
                );
              },
              childCount: bookmarkedLaws.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: gold.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.bookmark_rounded,
              color: gold,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saved Laws',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${bookmarkedLaws.length} '
                  '${bookmarkedLaws.length == 1 ? 'law' : 'laws'} '
                  'saved for quick access.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: gold.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_outline_rounded,
                color: navy,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Bookmarks Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Save important laws for quick access '
              'while researching or preparing your case.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 22),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.menu_book_rounded,
                size: 18,
              ),
              label: const Text(
                'Browse Law Library',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: navy,
                side: const BorderSide(
                  color: navy,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLaw(
    BuildContext context,
    LawModel law,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawDetailScreen(
          law: law,
        ),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Clear Bookmarks?',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'This will remove all saved laws from your bookmarks.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Bookmark clearing will be connected '
                      'to the bookmark provider.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}