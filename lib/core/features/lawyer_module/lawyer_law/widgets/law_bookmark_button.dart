import 'package:flutter/material.dart';

class LawBookmarkButton extends StatelessWidget {
  const LawBookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
    this.size = 22,
  });

  final bool isBookmarked;
  final VoidCallback onPressed;
  final double size;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: isBookmarked
          ? 'Remove Bookmark'
          : 'Bookmark Law',
      splashRadius: 22,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Icon(
          isBookmarked
              ? Icons.bookmark_rounded
              : Icons.bookmark_outline_rounded,
          key: ValueKey<bool>(isBookmarked),
          color: isBookmarked ? gold : navy,
          size: size,
        ),
      ),
    );
  }
}