import 'package:flutter/material.dart';

import '../models/law_section_model.dart';

class LawSectionCard extends StatelessWidget {
  const LawSectionCard({
    super.key,
    required this.section,
    this.onTap,
    this.onBookmark,
    this.isBookmarked = false,
  });

  final LawSectionModel section;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildTitle(),
              if (section.text.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildPreview(),
              ],
              if (section.keywords.isNotEmpty) ...[
                const SizedBox(height: 10),
                _buildKeywords(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: navy,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Section ${section.sectionNumber}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onBookmark,
          tooltip: isBookmarked ? 'Remove Bookmark' : 'Bookmark',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 34,
            minHeight: 34,
          ),
          icon: Icon(
            isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_outline_rounded,
            color: isBookmarked ? gold : Colors.grey.shade500,
            size: 20,
          ),
        ),
        const Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    if (section.title.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      section.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: navy,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.35,
      ),
    );
  }

  Widget _buildPreview() {
    return Text(
      _cleanText(section.text),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 12,
        height: 1.45,
      ),
    );
  }

  Widget _buildKeywords() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: section.keywords.take(4).map((keyword) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: gold.withOpacity(0.09),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            keyword,
            style: const TextStyle(
              color: navy,
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _cleanText(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}