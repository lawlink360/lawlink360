import 'package:flutter/material.dart';

import '../models/law_category_model.dart';

class LawCategoryCard extends StatelessWidget {
  const LawCategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  final LawCategoryModel category;
  final VoidCallback? onTap;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  static const Map<String, IconData> _icons = {
    'gavel': Icons.gavel_rounded,
    'account_balance': Icons.account_balance_rounded,
    'security': Icons.security_rounded,
    'family_restroom': Icons.family_restroom_rounded,
    'home_work': Icons.home_work_rounded,
    'fact_check': Icons.fact_check_rounded,
    'description': Icons.description_rounded,
    'account_balance_wallet': Icons.account_balance_wallet_rounded,
    'business': Icons.business_rounded,
    'payments': Icons.payments_rounded,
    'engineering': Icons.engineering_rounded,
    'badge': Icons.badge_rounded,
    'how_to_vote': Icons.how_to_vote_rounded,
    'location_city': Icons.location_city_rounded,
    'library_books': Icons.library_books_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.035),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const Spacer(),
              _buildTitle(),
              const SizedBox(height: 4),
              _buildBottomRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final icon = _icons[category.iconName] ?? Icons.menu_book_rounded;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: gold.withValues(alpha:0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: navy,
        size: 22,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      category.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: navy,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            category.lawCount > 0
                ? '${category.lawCount} Laws'
                : 'Browse Laws',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: gold,
          size: 12,
        ),
      ],
    );
  }
}