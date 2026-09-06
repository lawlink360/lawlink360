import 'package:flutter/material.dart';

import '../data/law_data.dart';
import '../models/law_category_model.dart';
import '../models/law_model.dart';
import '../widgets/law_card.dart';
import 'law_detail_screen.dart';
import 'law_search_screen.dart';

class LawCategoryLawsScreen extends StatefulWidget {
  const LawCategoryLawsScreen({
    super.key,
    required this.category,
  });

  final LawCategoryModel category;

  @override
  State<LawCategoryLawsScreen> createState() =>
      _LawCategoryLawsScreenState();
}

class _LawCategoryLawsScreenState
    extends State<LawCategoryLawsScreen> {
  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  String searchQuery = '';

  List<LawModel> get categoryLaws {
    final laws = LawData.getByCategory(widget.category.id);

    if (searchQuery.trim().isEmpty) {
      return laws;
    }

    final query = searchQuery.trim().toLowerCase();

    return laws.where((law) {
      return law.title.toLowerCase().contains(query) ||
          law.shortTitle.toLowerCase().contains(query) ||
          law.description.toLowerCase().contains(query);
    }).toList();
  }

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
        title: Text(
          widget.category.name,
          style: const TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Search All Laws',
            icon: const Icon(
              Icons.search_rounded,
              color: navy,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LawSearchScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryHeader(),
                    const SizedBox(height: 16),
                    _buildSearchField(),
                    const SizedBox(height: 18),
                    _buildResultsHeader(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                32,
              ),
              sliver: categoryLaws.isEmpty
                  ? SliverToBoxAdapter(
                      child: _buildEmptyState(),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final law = categoryLaws[index];

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: LawCard(
                              law: law,
                              onTap: () => _openLaw(law),
                            ),
                          );
                        },
                        childCount: categoryLaws.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: gold.withValues(alpha:0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _getCategoryIcon(),
              color: gold,
              size: 26,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.category.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.68),
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search within this category...',
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: navy,
          size: 21,
        ),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.clear_rounded,
                  size: 19,
                ),
                onPressed: () {
                  setState(() {
                    searchQuery = '';
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: navy,
            width: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Available Laws',
            style: TextStyle(
              color: navy,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          '${categoryLaws.length} Laws',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 36,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: Colors.grey.shade400,
            size: 38,
          ),
          const SizedBox(height: 12),
          Text(
            searchQuery.isEmpty
                ? 'No laws available in this category.'
                : 'No laws match your search.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (widget.category.iconName) {
      case 'gavel':
        return Icons.gavel_rounded;
      case 'account_balance':
        return Icons.account_balance_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'family_restroom':
        return Icons.family_restroom_rounded;
      case 'home_work':
        return Icons.home_work_rounded;
      case 'fact_check':
        return Icons.fact_check_rounded;
      case 'description':
        return Icons.description_rounded;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet_rounded;
      case 'business':
        return Icons.business_rounded;
      case 'payments':
        return Icons.payments_rounded;
      case 'engineering':
        return Icons.engineering_rounded;
      case 'badge':
        return Icons.badge_rounded;
      case 'how_to_vote':
        return Icons.how_to_vote_rounded;
      case 'location_city':
        return Icons.location_city_rounded;
      default:
        return Icons.menu_book_rounded;
    }
  }

  void _openLaw(LawModel law) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawDetailScreen(
          law: law,
        ),
      ),
    );
  }
}