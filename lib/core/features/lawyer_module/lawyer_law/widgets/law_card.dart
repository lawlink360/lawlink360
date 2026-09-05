import 'package:flutter/material.dart';

import '../models/law_model.dart';

class LawCard extends StatelessWidget {
  const LawCard({
    super.key,
    required this.law,
    this.onTap,
    this.onBookmark,
    this.isBookmarked = false,
  });

  final LawModel law;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.035),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopRow(),
              const SizedBox(height: 12),
              _buildLawTitle(),
              const SizedBox(height: 6),
              _buildDescription(),
              const SizedBox(height: 14),
              _buildMetadata(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: gold.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: navy,
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              if (law.isFeatured) _buildBadge('Featured'),
              if (law.isNew) ...[
                if (law.isFeatured) const SizedBox(width: 6),
                _buildBadge('New'),
              ],
            ],
          ),
        ),
        IconButton(
          onPressed: onBookmark,
          splashRadius: 20,
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
            size: 21,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: text == 'New'
            ? navy.withOpacity(0.08)
            : gold.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: text == 'New' ? navy : gold,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildLawTitle() {
    return Text(
      law.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: navy,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      law.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 12,
        height: 1.4,
      ),
    );
  }

  Widget _buildMetadata() {
    return Wrap(
      spacing: 8,
      runSpacing: 7,
      children: [
        _buildMetadataItem(
          Icons.calendar_today_outlined,
          law.year.toString(),
        ),
        _buildMetadataItem(
          Icons.account_balance_outlined,
          law.jurisdiction,
        ),
        _buildMetadataItem(
          Icons.category_outlined,
          law.categoryName,
        ),
        if (law.totalSections > 0)
          _buildMetadataItem(
            Icons.format_list_numbered_rounded,
            '${law.totalSections} Sections',
          ),
      ],
    );
  }

  Widget _buildMetadataItem(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: navy,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}