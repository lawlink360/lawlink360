import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

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

  void _onSearchChanged(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}