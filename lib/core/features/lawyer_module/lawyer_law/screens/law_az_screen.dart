import 'package:flutter/material.dart';

import '../data/law_index_data.dart';
import '../models/law_model.dart';
import '../widgets/law_az_index.dart';
import '../widgets/law_az_section.dart';
import 'law_detail_screen.dart';
import 'law_search_screen.dart';

class LawAzScreen extends StatefulWidget {
  const LawAzScreen({super.key});

  @override
  State<LawAzScreen> createState() => _LawAzScreenState();
}

class _LawAzScreenState extends State<LawAzScreen> {
  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  late String selectedLetter;

  @override
  void initState() {
    super.initState();

    selectedLetter =
        LawIndexData.firstAvailableLetter ?? LawIndexData.alphabet.first;
  }

  List<LawModel> get selectedLaws {
    return LawIndexData.getLawsByLetter(selectedLetter);
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
          'A–Z Law Index',
          style: TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Search Laws',
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntro(),
                    const SizedBox(height: 18),
                    _buildSearchBar(),
                    const SizedBox(height: 18),
                    _buildIndexHeader(),
                    const SizedBox(height: 12),
                    LawAzIndex(
                      selectedLetter: selectedLetter,
                      onLetterSelected: _selectLetter,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              sliver: SliverToBoxAdapter(
                child: LawAzSection(
                  letter: selectedLetter,
                  laws: selectedLaws,
                  onLawTap: _openLaw,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Find a Law',
          style: TextStyle(
            color: navy,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Browse Pakistani laws alphabetically by their title.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const LawSearchScreen(),
          ),
        );
      },
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: navy,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              'Search by law name...',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Alphabetical Index',
            style: TextStyle(
              color: navy,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: gold.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${LawIndexData.totalLawCount} Laws',
            style: const TextStyle(
              color: navy,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  void _selectLetter(String letter) {
    setState(() {
      selectedLetter = letter;
    });
  }

  void _openLaw(LawModel law) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawDetailScreen(law: law),
      ),
    );
  }
}