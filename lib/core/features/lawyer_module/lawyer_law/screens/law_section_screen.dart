import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/law_model.dart';
import '../models/law_section_model.dart';

class LawSectionScreen extends StatefulWidget {
  const LawSectionScreen({
    super.key,
    required this.law,
    required this.section,
    this.previousSection,
    this.nextSection,
  });

  final LawModel law;
  final LawSectionModel section;
  final LawSectionModel? previousSection;
  final LawSectionModel? nextSection;

  @override
  State<LawSectionScreen> createState() => _LawSectionScreenState();
}

class _LawSectionScreenState extends State<LawSectionScreen> {
  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  bool isBookmarked = false;
  double textScale = 1.0;

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
          'Section ${widget.section.sectionNumber}',
          style: const TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Text Size',
            icon: const Icon(
              Icons.text_fields_rounded,
              color: navy,
            ),
            onPressed: _showTextSizeOptions,
          ),
          IconButton(
            tooltip: 'Copy',
            icon: const Icon(
              Icons.copy_outlined,
              color: navy,
            ),
            onPressed: _copySection,
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLawReference(),
                    const SizedBox(height: 16),
                    _buildSectionHeader(),
                    const SizedBox(height: 16),
                    _buildSectionText(),
                    if (widget.section.keywords.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildKeywords(),
                    ],
                    const SizedBox(height: 24),
                    _buildSourceNotice(),
                  ],
                ),
              ),
            ),
            _buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildLawReference() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: gold.withValues(alpha:0.15),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: gold,
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.law.shortTitle.isNotEmpty
                      ? widget.law.shortTitle
                      : widget.law.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.law.year} • ${widget.law.jurisdiction}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.65),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: gold.withValues(alpha:0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'SECTION ${widget.section.sectionNumber}',
              style: const TextStyle(
                color: navy,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          if (widget.section.title.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              widget.section.title,
              style: const TextStyle(
                color: navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionText() {
    final fontSize = 15 * textScale;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: SelectableText(
        widget.section.text,
        style: TextStyle(
          color: const Color(0xFF252525),
          fontSize: fontSize,
          height: 1.65,
        ),
      ),
    );
  }

  Widget _buildKeywords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Keywords',
          style: TextStyle(
            color: navy,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: widget.section.keywords.map((keyword) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: gold.withValues(alpha:0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                keyword,
                style: const TextStyle(
                  color: navy,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSourceNotice() {
    return Container(
      padding: const EdgeInsets.all(14),
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
          Icon(
            Icons.info_outline_rounded,
            color: Colors.grey.shade600,
            size: 19,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'For legal proceedings and professional advice, '
              'verify the current provision against the applicable '
              'official source and amendments.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _navigationButton(
              icon: Icons.arrow_back_rounded,
              label: 'Previous',
              enabled: widget.previousSection != null,
              onTap: widget.previousSection == null
                  ? null
                  : () => _openSection(widget.previousSection!),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _navigationButton(
              icon: Icons.arrow_forward_rounded,
              label: 'Next',
              enabled: widget.nextSection != null,
              forward: true,
              onTap: widget.nextSection == null
                  ? null
                  : () => _openSection(widget.nextSection!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationButton({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback? onTap,
    bool forward = false,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: enabled ? navy : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!forward)
              Icon(
                icon,
                size: 17,
                color: enabled ? gold : Colors.grey.shade400,
              ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: enabled ? Colors.white : Colors.grey.shade400,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (forward) ...[
              const SizedBox(width: 6),
              Icon(
                icon,
                size: 17,
                color: enabled ? gold : Colors.grey.shade400,
              ),
            ],
          ],
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
          ? 'Section added to bookmarks'
          : 'Section removed from bookmarks',
    );
  }

  void _copySection() {
    final text = '''
${widget.law.title}

Section ${widget.section.sectionNumber}
${widget.section.title}

${widget.section.text}
''';

    Clipboard.setData(
      ClipboardData(text: text),
    );

    _showMessage('Section copied to clipboard');
  }

  void _showTextSizeOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Text Size',
                  style: TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _textSizeOption(
                  title: 'Small',
                  scale: 0.9,
                ),
                _textSizeOption(
                  title: 'Normal',
                  scale: 1.0,
                ),
                _textSizeOption(
                  title: 'Large',
                  scale: 1.15,
                ),
                _textSizeOption(
                  title: 'Extra Large',
                  scale: 1.3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textSizeOption({
    required String title,
    required double scale,
  }) {
    final selected = textScale == scale;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          color: navy,
          fontSize: 14 * scale,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: selected
          ? const Icon(
              Icons.check_circle_rounded,
              color: gold,
            )
          : null,
      onTap: () {
        setState(() {
          textScale = scale;
        });

        Navigator.pop(context);
      },
    );
  }

  void _openSection(LawSectionModel section) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LawSectionScreen(
          law: widget.law,
          section: section,
        ),
      ),
    );
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
}