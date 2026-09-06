import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/judgment_category_provider.dart';
import '../provider/judgment_search_provider.dart';
import '../widgets/judgment_card.dart';
import '../widgets/judgment_search_bar.dart';

class JudgmentSearchScreen extends ConsumerStatefulWidget {
  final String? initialCourt;
  final String? initialCategory;
  final String? initialLawReport;

  const JudgmentSearchScreen({
    super.key,
    this.initialCourt,
    this.initialCategory,
    this.initialLawReport,
  });

  @override
  ConsumerState<JudgmentSearchScreen> createState() =>
      _JudgmentSearchScreenState();
}

class _JudgmentSearchScreenState
    extends ConsumerState<JudgmentSearchScreen> {
  late final TextEditingController _searchController;

  String? _selectedCourt;
  String? _selectedCategory;
  String? _selectedLawReport;

  static const Color navy = Color(0xFF13294B);

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    _selectedCourt = widget.initialCourt;
    _selectedCategory = widget.initialCategory;
    _selectedLawReport = widget.initialLawReport;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    ref.read(judgmentSearchProvider.notifier).search(
          query: _searchController.text,
          court: _selectedCourt,
          category: _selectedCategory,
          lawReport: _selectedLawReport,
        );
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _selectedCourt = null;
      _selectedCategory = null;
      _selectedLawReport = null;
    });

    ref.read(judgmentSearchProvider.notifier).clearSearch();
  }

  void _showFilters() {
    final courts = ref.read(judgmentCourtsProvider);
    final categories = ref.read(judgmentCategoriesProvider);
    final lawReports = ref.read(judgmentLawReportsProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Filter Judgments',
                            style: TextStyle(
                              color: navy,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _buildFilterLabel('Court'),
                    const SizedBox(height: 8),
                    _buildDropdown<String>(
                      value: _selectedCourt,
                      items: courts,
                      hint: 'All Courts',
                      onChanged: (value) {
                        setModalState(() {
                          _selectedCourt = value;
                        });
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFilterLabel('Category'),
                    const SizedBox(height: 8),
                    _buildDropdown<String>(
                      value: _selectedCategory,
                      items: categories,
                      hint: 'All Categories',
                      onChanged: (value) {
                        setModalState(() {
                          _selectedCategory = value;
                        });
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildFilterLabel('Law Report'),
                    const SizedBox(height: 8),
                    _buildDropdown<String>(
                      value: _selectedLawReport,
                      items: lawReports,
                      hint: 'All Reports',
                      onChanged: (value) {
                        setModalState(() {
                          _selectedLawReport = value;
                        });
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                _selectedCourt = null;
                                _selectedCategory = null;
                                _selectedLawReport = null;
                              });

                              setState(() {
                                _selectedCourt = null;
                                _selectedCategory = null;
                                _selectedLawReport = null;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: navy,
                              side: const BorderSide(color: navy),
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Reset'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _performSearch();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: navy,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required List<T> items,
    required String hint,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
      ),
      items: [
        DropdownMenuItem<T>(
          value: null,
          child: Text(hint),
        ),
        ...items.map(
          (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildFilterLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: navy,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(judgmentSearchProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search Judgments',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: JudgmentSearchBar(
                controller: _searchController,
                onChanged: (_) => _performSearch(),
                onClear: _clearSearch,
                onFilterTap: _showFilters,
              ),
            ),
            if (_selectedCourt != null ||
                _selectedCategory != null ||
                _selectedLawReport != null)
              _buildActiveFilters(),
            Expanded(
              child: results.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        12,
                        16,
                        20,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final judgment = results[index];

                        return JudgmentCard(
                          judgment: judgment,
                          onTap: () {
                            // Detail navigation will be connected
                            // after the detail screen is completed.
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
  final filters = <String>[
    ?_selectedCourt,
    ?_selectedCategory,
    ?_selectedLawReport,
  ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(
              filters[index],
              style: const TextStyle(
                color: navy,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: navy.withValues(alpha: 0.08),
            side: BorderSide.none,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.grey.shade400,
              size: 52,
            ),
            const SizedBox(height: 14),
            Text(
              'No judgments found',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try a different search term or adjust your filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}