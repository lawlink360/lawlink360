import 'package:flutter/material.dart';

import '../models/judgment_model.dart';
import '../widgets/judgment_bookmark_button.dart';
import '../widgets/relevant_law_card.dart';

class JudgmentDetailScreen extends StatelessWidget {
  final JudgmentModel judgment;

  const JudgmentDetailScreen({
    super.key,
    required this.judgment,
  });

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: navy,
        ),
        title: const Text(
          'Judgment',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          JudgmentBookmarkButton(
            judgmentId: judgment.id,
          ),
          IconButton(
            tooltip: 'Share',
            onPressed: () {
              _showComingSoon(context, 'Share');
            },
            icon: const Icon(
              Icons.share_outlined,
              color: navy,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCaseHeader(),
              const SizedBox(height: 20),
              _buildCaseInformation(),
              const SizedBox(height: 20),
              _buildSubjectSection(),
              const SizedBox(height: 20),
              _buildRelevantLaws(context),
              const SizedBox(height: 20),
              _buildKeywords(),
              const SizedBox(height: 24),
              _buildJudgmentText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaseHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: gold.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              judgment.category,
              style: const TextStyle(
                color: gold,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            judgment.title,
            style: const TextStyle(
              color: navy,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            judgment.citation,
            style: const TextStyle(
              color: gold,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            judgment.court,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseInformation() {
    return _buildSectionCard(
      title: 'Case Information',
      icon: Icons.info_outline_rounded,
      child: Column(
        children: [
          _buildInfoRow(
            'Case Number',
            judgment.caseNumber,
          ),
          _buildDivider(),
          _buildInfoRow(
            'Date',
            judgment.judgmentDate,
          ),
          _buildDivider(),
          _buildInfoRow(
            'Judge(s)',
            judgment.judges,
          ),
          _buildDivider(),
          _buildInfoRow(
            'Court',
            judgment.court,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectSection() {
    return _buildSectionCard(
      title: 'Subject / Summary',
      icon: Icons.subject_rounded,
      child: Text(
        judgment.summary,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 13,
          height: 1.55,
        ),
      ),
    );
  }

  Widget _buildRelevantLaws(BuildContext context) {
    if (judgment.relevantLaws.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSectionCard(
      title: 'Relevant Laws',
      icon: Icons.menu_book_rounded,
      child: Column(
        children: judgment.relevantLaws.map(
          (law) {
            return RelevantLawCard(
              law: law,
              onTap: () {
                _showComingSoon(
                  context,
                  'Law navigation',
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildKeywords() {
    if (judgment.keywords.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSectionCard(
      title: 'Keywords',
      icon: Icons.label_outline_rounded,
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        children: judgment.keywords.map(
          (keyword) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                keyword,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildJudgmentText() {
    return _buildSectionCard(
      title: 'Judgment',
      icon: Icons.gavel_rounded,
      child: SelectableText(
        judgment.judgmentText,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 14,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: gold,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  void _showComingSoon(
    BuildContext context,
    String feature,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature will be connected in the next step.',
        ),
      ),
    );
  }
}