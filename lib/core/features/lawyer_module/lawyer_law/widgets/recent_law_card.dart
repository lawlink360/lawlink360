import 'package:flutter/material.dart';

import '../models/law_model.dart';

class RecentLawCard extends StatelessWidget {
  const RecentLawCard({
    super.key,
    required this.law,
    this.onTap,
    this.onRemove,
  });

  final LawModel law;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

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
          width: 245,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: _buildContent(),
              ),
              if (onRemove != null)
                IconButton(
                  onPressed: onRemove,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                  ),
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.grey.shade400,
                    size: 17,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: gold.withValues(alpha:0.11),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.history_rounded,
        color: navy,
        size: 20,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          law.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: navy,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 5),
        if (law.shortTitle.isNotEmpty)
          Text(
            law.shortTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              law.year.toString(),
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 9.5,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                law.categoryName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 9.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}