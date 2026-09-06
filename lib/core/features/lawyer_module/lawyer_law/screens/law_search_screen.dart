import 'package:flutter/material.dart';

import '../data/law_data.dart';
import '../models/law_model.dart';
import '../widgets/law_card.dart';
import 'law_detail_screen.dart';

class LawSearchScreen extends StatefulWidget {
  const LawSearchScreen({super.key});

  @override
  State<LawSearchScreen> createState() => _LawSearchScreenState();
}

class _LawSearchScreenState extends State<LawSearchScreen> {
  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  final TextEditingController _searchController =
      TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  String searchQuery = '';

  List<LawModel> get results {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return const [];
    }

    return LawData.search(query);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
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
          'Search Laws',
          style: TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchArea(),
            Expanded(
              child: _buildResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search law name, title, year...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: navy,
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear_rounded,
                        size: 20,
                      ),
                      onPressed: () {
                        _searchController.clear();

                        setState(() {
                          searchQuery = '';
                        });

                        _searchFocusNode.requestFocus();
                      },
                    )
                  : null,
              filled: true,
              fillColor: background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
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
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                borderSide: BorderSide(
                  color: navy,
                  width: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildSearchHint(),
        ],
      ),
    );
  }

  Widget _buildSearchHint() {
    if (searchQuery.trim().isNotEmpty) {
      return Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: navy,
            size: 15,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${results.length} ${results.length == 1 ? 'law' : 'laws'} found',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      );
    }

    return Text(
      'Try searching by law name, short title, category, '
      'description or year.',
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 11.5,
      ),
    );
  }

  Widget _buildResults() {
    if (searchQuery.trim().isEmpty) {
      return _buildInitialState();
    }

    if (results.isEmpty) {
      return _buildNoResults();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final law = results[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LawCard(
            law: law,
            onTap: () => _openLaw(law),
          ),
        );
      },
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: gold.withValues(alpha:0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.manage_search_rounded,
                color: navy,
                size: 35,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Search the Law Library',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: navy,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find laws quickly by entering a title, '
              'keyword, category or year.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade400,
              size: 45,
            ),
            const SizedBox(height: 14),
            const Text(
              'No laws found',
              style: TextStyle(
                color: navy,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Try a different law name, keyword or year.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
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