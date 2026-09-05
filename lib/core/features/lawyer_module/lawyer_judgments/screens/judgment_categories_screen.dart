import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/judgment_category_provider.dart';
import '../widgets/judgment_category_card.dart';
import 'judgment_search_screen.dart';

class JudgmentCategoriesScreen extends ConsumerWidget {
  const JudgmentCategoriesScreen({super.key});

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courts = ref.watch(judgmentCourtsProvider);
    final categories = ref.watch(judgmentCategoriesProvider);
    final lawReports = ref.watch(judgmentLawReportsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Judgment Categories',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: navy,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Courts'),
            const SizedBox(height: 10),
            ...courts.map(
              (court) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: JudgmentCategoryCard(
                  title: court,
                  subtitle: 'Browse judgments from $court',
                  icon: Icons.account_balance_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JudgmentSearchScreen(
                          initialCourt: court,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Legal Categories'),
            const SizedBox(height: 10),
            ...categories.map(
              (category) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: JudgmentCategoryCard(
                  title: category,
                  subtitle: 'Browse $category judgments',
                  icon: Icons.gavel_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JudgmentSearchScreen(
                          initialCategory: category,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Law Reports'),
            const SizedBox(height: 10),
            ...lawReports.map(
              (report) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: JudgmentCategoryCard(
                  title: report,
                  subtitle: 'Browse judgments reported in $report',
                  icon: Icons.menu_book_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JudgmentSearchScreen(
                          initialLawReport: report,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildResearchTip(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: navy,
        fontSize: 17,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildResearchTip() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: navy.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: navy.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: gold,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Tip: You can combine court, category and law-report filters from the search screen for more precise case-law research.',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}