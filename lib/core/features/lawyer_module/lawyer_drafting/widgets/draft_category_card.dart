import 'package:flutter/material.dart';

import '../models/draft_category_model.dart';

class DraftCategoryCard extends StatelessWidget {
  const DraftCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final DraftCategoryModel category;
  final VoidCallback onTap;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // ====================================================
              // CATEGORY ICON
              // ====================================================
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(_getIcon(category.iconName), color: gold, size: 24),
              ),

              const SizedBox(width: 13),

              // ====================================================
              // CATEGORY INFORMATION
              // ====================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      category.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.3,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // ====================================================
                    // DRAFT COUNT
                    // ====================================================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: navy.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${category.draftCount} drafts',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: navy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ====================================================
              // ARROW
              // ====================================================
              const Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // ICON MAPPER
  // ==============================================================

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'application':
        return Icons.description_outlined;

      case 'notice':
        return Icons.mail_outline_rounded;

      case 'bail':
        return Icons.gavel_outlined;

      case 'civil':
        return Icons.account_balance_outlined;

      case 'family':
        return Icons.family_restroom_outlined;

      case 'criminal':
        return Icons.local_police_outlined;

      case 'agreement':
        return Icons.handshake_outlined;

      case 'petition':
        return Icons.article_outlined;

      case 'contract':
        return Icons.assignment_outlined;

      default:
        return Icons.folder_outlined;
    }
  }
}
