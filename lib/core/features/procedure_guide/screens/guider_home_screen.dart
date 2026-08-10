import 'package:flutter/material.dart';

import '../data/procedure_data.dart';

import '../widgets/guider_header.dart';
import '../widgets/guider_search_bar.dart';
import '../widgets/procedure_category_card.dart';
import 'procedure_category_screen.dart';


class GuiderHomeScreen extends StatefulWidget {
  const GuiderHomeScreen({super.key});

  @override
  State<GuiderHomeScreen> createState() => _GuiderHomeScreenState();
}

class _GuiderHomeScreenState extends State<GuiderHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {}

  @override
  Widget build(BuildContext context) {
    final categories = ProcedureData.categories;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Procedure Guider"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        children: [
          const GuiderHeader(),

          GuiderSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: ProcedureCategoryCard(
                    icon: category.icon,
                    color: category.color,
                    title: category.title,
                    description: category.description,
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProcedureCategoryScreen(
        categoryId: category.id,
        title: category.title,
      ),
    ),
  );
},
                  ),
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