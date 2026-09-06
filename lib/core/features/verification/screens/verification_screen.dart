import 'package:flutter/material.dart';

import '../widgets/category/header_section.dart';
import '../widgets/category/search_bar_widget.dart';
import '../widgets/category/statistics_cards.dart';
import '../widgets/category/category_grid.dart';
import '../widgets/category/recent_services.dart';
import '../widgets/category/important_notice.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PremiumHeader(),

              SearchBarWidget(
                controller: _searchController,
                onChanged: _onSearchChanged,
              ),

              const StatisticsCards(),

              const CategoryGrid(),

              const RecentServices(),

              const ImportantNotice(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
