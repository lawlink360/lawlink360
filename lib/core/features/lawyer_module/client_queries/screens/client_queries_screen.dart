import 'package:flutter/material.dart';

import '../data/client_queries_data.dart';
import '../models/client_query_model.dart';

import '../widgets/client_queries_header.dart';
import '../widgets/client_query_search_bar.dart';
import '../widgets/client_query_filter_tabs.dart';
import '../widgets/client_query_cards.dart';
import '../widgets/client_query_empty_stats.dart';

class ClientQueriesScreen extends StatefulWidget {
  const ClientQueriesScreen({super.key});

  @override
  State<ClientQueriesScreen> createState() => _ClientQueriesScreenState();
}

class _ClientQueriesScreenState extends State<ClientQueriesScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClientQueryModel> get _filteredQueries {
    final searchText = _searchController.text.trim().toLowerCase();

    return ClientQueriesData.queries.where((query) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          query.category == _selectedCategory;

      final matchesSearch =
          searchText.isEmpty ||
          query.title.toLowerCase().contains(searchText) ||
          query.description.toLowerCase().contains(searchText) ||
          query.category.toLowerCase().contains(searchText) ||
          query.location.toLowerCase().contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {});
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _openQuery(ClientQueryModel query) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${query.title} details will be available soon.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queries = _filteredQueries;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Client Queries',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF13294B),
        elevation: 0,
      ),

      body: ListView(
        children: [
          const ClientQueriesHeader(),

          ClientQuerySearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),

          ClientQueryFilterTabs(
            selectedCategory: _selectedCategory,
            onCategoryChanged: _onCategoryChanged,
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Available Queries',
                  style: TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Text(
                  '${queries.length} found',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: queries.isEmpty
                ? const ClientQueryEmptyState()
                : Column(
                    children: queries.map((query) {
                      return ClientQueryCard(
                        query: query,
                        onTap: () => _openQuery(query),
                      );
                    }).toList(),
                  ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}