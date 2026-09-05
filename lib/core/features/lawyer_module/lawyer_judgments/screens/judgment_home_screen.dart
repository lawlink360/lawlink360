import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/judgment_provider.dart';
import '../provider/judgment_recent_provider.dart';
import '../widgets/judgment_card.dart';
import '../widgets/recent_judgment_card.dart';
import 'bookmark_judgments_screen.dart';
import 'judgment_categories_screen.dart';
import 'judgment_search_screen.dart';
import 'recent_judgments_screen.dart';

class JudgmentHomeScreen extends ConsumerWidget {
  const JudgmentHomeScreen({super.key});

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final judgments = ref.watch(judgmentProvider);
    final recentJudgments = ref.watch(judgmentRecentProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Judgments',
          style: TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Bookmarks',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookmarkJudgmentsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.bookmark_outline_rounded,
              color: navy,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(judgmentProvider);
            ref.invalidate(judgmentRecentProvider);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildSearchButton(context),
              const SizedBox(height: 22),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              if (recentJudgments.isNotEmpty) ...[
                _buildSectionHeader(
                  context,
                  title: 'Recently Viewed',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RecentJudgmentsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 155,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentJudgments.length,
                    itemBuilder: (context, index) {
                      final judgment = recentJudgments[index];

                      return RecentJudgmentCard(
                        judgment: judgment,
                        onTap: () {
                          // Detail navigation will be connected
                          // after the detail screen is completed.
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
              _buildSectionHeader(
                context,
                title: 'Judgments',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JudgmentSearchScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              if (judgments.isEmpty)
                _buildEmptyState()
              else
                ...judgments.map(
                  (judgment) => JudgmentCard(
                    judgment: judgment,
                    onTap: () {
                      // Detail navigation will be connected
                      // after the detail screen is completed.
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Case Law Research',
          style: TextStyle(
            color: navy,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Search Pakistani judgments, citations and relevant laws.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const JudgmentSearchScreen(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: navy,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search judgments, citations, laws...',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),
            ),
            const Icon(
              Icons.tune_rounded,
              color: gold,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickAction(
            icon: Icons.account_balance_rounded,
            title: 'Courts',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JudgmentCategoriesScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildQuickAction(
            icon: Icons.category_rounded,
            title: 'Categories',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JudgmentCategoriesScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildQuickAction(
            icon: Icons.bookmark_rounded,
            title: 'Saved',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BookmarkJudgmentsScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: navy,
              size: 22,
            ),
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'View All',
            style: TextStyle(
              color: gold,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            Icons.gavel_rounded,
            color: Colors.grey.shade400,
            size: 42,
          ),
          const SizedBox(height: 12),
          Text(
            'No judgments available',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}