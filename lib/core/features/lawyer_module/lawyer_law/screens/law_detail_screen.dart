import 'package:flutter/material.dart';

import '../models/law_model.dart';
import '../models/law_section_model.dart';
import '../widgets/law_section_card.dart';
import 'law_section_screen.dart';

class LawDetailScreen extends StatefulWidget {
  const LawDetailScreen({
    super.key,
    required this.law,
  });

  final LawModel law;

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen> {
  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  bool isBookmarked = false;

  late final List<LawSectionModel> sections;

  @override
  void initState() {
    super.initState();
    sections = _createPreviewSections();
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
        title: const Text(
          'Law Details',
          style: TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Share',
            icon: const Icon(
              Icons.share_outlined,
              color: navy,
            ),
            onPressed: _shareLaw,
          ),
          IconButton(
            tooltip: 'Bookmark',
            icon: Icon(
              isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              color: isBookmarked ? gold : navy,
            ),
            onPressed: _toggleBookmark,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    _buildLawHeader(),
                    const SizedBox(height: 16),
                    _buildQuickActions(),
                    const SizedBox(height: 24),
                    _buildSectionHeader(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final section = sections[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LawSectionCard(
                        section: section,
                        onTap: () => _openSection(section),
                      ),
                    );
                  },
                  childCount: sections.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLawHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha:0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: navy,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.law.title,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (widget.law.shortTitle.isNotEmpty)
            Text(
              widget.law.shortTitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _metadataChip(
                Icons.calendar_today_outlined,
                widget.law.year.toString(),
              ),
              _metadataChip(
                Icons.account_balance_outlined,
                widget.law.jurisdiction,
              ),
              _metadataChip(
                Icons.category_outlined,
                widget.law.categoryName,
              ),
              if (widget.law.lawNumber != null)
                _metadataChip(
                  Icons.tag_rounded,
                  widget.law.lawNumber!,
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            widget.law.description,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metadataChip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: navy,
            size: 13,
          ),
          const SizedBox(width: 5),
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

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.search_rounded,
            title: 'Search',
            onTap: _searchWithinLaw,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _actionButton(
            icon: Icons.bookmark_outline_rounded,
            title: 'Bookmarks',
            onTap: _showBookmarks,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _actionButton(
            icon: Icons.share_outlined,
            title: 'Share',
            onTap: _shareLaw,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: navy,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: gold,
              size: 20,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Sections',
            style: TextStyle(
              color: navy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          '${widget.law.totalSections} Sections',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _openSection(LawSectionModel section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawSectionScreen(
          law: widget.law,
          section: section,
        ),
      ),
    );
  }

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    _showMessage(
      isBookmarked
          ? 'Law added to bookmarks'
          : 'Law removed from bookmarks',
    );
  }

  void _searchWithinLaw() {
    _showMessage('Law search will be connected next.');
  }

  void _showBookmarks() {
    _showMessage('Section bookmarks will be connected next.');
  }

  void _shareLaw() {
    _showMessage('Law sharing will be connected next.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  List<LawSectionModel> _createPreviewSections() {
    final lawId = widget.law.id;

    return [
      LawSectionModel(
        id: '${lawId}_section_1',
        lawId: lawId,
        sectionNumber: '1',
        title: 'Short title, extent and commencement',
        text:
            'Preview section content will be loaded from the structured legal database.',
        keywords: const [
          'short title',
          'extent',
          'commencement',
        ],
      ),
      LawSectionModel(
        id: '${lawId}_section_2',
        lawId: lawId,
        sectionNumber: '2',
        title: 'Definitions',
        text:
            'Preview section content will be loaded from the structured legal database.',
        keywords: const [
          'definitions',
          'interpretation',
        ],
      ),
      LawSectionModel(
        id: '${lawId}_section_3',
        lawId: lawId,
        sectionNumber: '3',
        title: 'General provisions',
        text:
            'Preview section content will be loaded from the structured legal database.',
        keywords: const [
          'provisions',
          'application',
        ],
      ),
      LawSectionModel(
        id: '${lawId}_section_4',
        lawId: lawId,
        sectionNumber: '4',
        title: 'Jurisdiction and powers',
        text:
            'Preview section content will be loaded from the structured legal database.',
        keywords: const [
          'jurisdiction',
          'powers',
        ],
      ),
    ];
  }
}