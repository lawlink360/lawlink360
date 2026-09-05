import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/judgment_bookmark_provider.dart';

class JudgmentBookmarkButton extends ConsumerWidget {
  final String judgmentId;

  const JudgmentBookmarkButton({
    super.key,
    required this.judgmentId,
  });

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(
      isJudgmentBookmarkedProvider(judgmentId),
    );

    return IconButton(
      onPressed: () {
        ref
            .read(judgmentBookmarkProvider.notifier)
            .toggleBookmark(judgmentId);
      },
      tooltip: isBookmarked ? 'Remove Bookmark' : 'Bookmark Judgment',
      icon: Icon(
        isBookmarked
            ? Icons.bookmark_rounded
            : Icons.bookmark_border_rounded,
        color: isBookmarked ? gold : navy,
      ),
    );
  }
}