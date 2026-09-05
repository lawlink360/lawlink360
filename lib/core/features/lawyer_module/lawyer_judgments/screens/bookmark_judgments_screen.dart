import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/judgment_bookmark_provider.dart';
import '../widgets/judgment_card.dart';
import 'judgment_detail_screen.dart';

class BookmarkJudgmentsScreen extends ConsumerWidget {
  const BookmarkJudgmentsScreen({super.key});

  static const Color navy = Color(0xFF13294B);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(judgmentBookmarkProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: navy,
        ),
        title: const Text(
          'Bookmarked Judgments',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: bookmarks.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final judgment = bookmarks[index];

                return JudgmentCard(
                  judgment: judgment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JudgmentDetailScreen(
                          judgment: judgment,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border_rounded,
              color: Colors.grey.shade400,
              size: 52,
            ),
            const SizedBox(height: 14),
            Text(
              'No bookmarked judgments',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Save important judgments to access them quickly later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}