import 'package:flutter/material.dart';

import '../models/judgment_model.dart';
import '../screens/bookmark_judgments_screen.dart';
import '../screens/judgment_categories_screen.dart';
import '../screens/judgment_detail_screen.dart';
import '../screens/judgment_home_screen.dart';
import '../screens/judgment_search_screen.dart';
import '../screens/recent_judgments_screen.dart';

class JudgmentNavigation {
  const JudgmentNavigation._();

  static Route<void> home() {
    return MaterialPageRoute(
      builder: (_) => const JudgmentHomeScreen(),
    );
  }

  static Route<void> categories() {
    return MaterialPageRoute(
      builder: (_) => const JudgmentCategoriesScreen(),
    );
  }

  static Route<void> search({
    String? initialCourt,
    String? initialCategory,
    String? initialLawReport,
  }) {
    return MaterialPageRoute(
      builder: (_) => JudgmentSearchScreen(
        initialCourt: initialCourt,
        initialCategory: initialCategory,
        initialLawReport: initialLawReport,
      ),
    );
  }

  static Route<void> detail(JudgmentModel judgment) {
    return MaterialPageRoute(
      builder: (_) => JudgmentDetailScreen(
        judgment: judgment,
      ),
    );
  }

  static Route<void> recent() {
    return MaterialPageRoute(
      builder: (_) => const RecentJudgmentsScreen(),
    );
  }

  static Route<void> bookmarks() {
    return MaterialPageRoute(
      builder: (_) => const BookmarkJudgmentsScreen(),
    );
  }

  static void pushHome(BuildContext context) {
    Navigator.push(
      context,
      home(),
    );
  }

  static void pushCategories(BuildContext context) {
    Navigator.push(
      context,
      categories(),
    );
  }

  static void pushSearch(
    BuildContext context, {
    String? initialCourt,
    String? initialCategory,
    String? initialLawReport,
  }) {
    Navigator.push(
      context,
      search(
        initialCourt: initialCourt,
        initialCategory: initialCategory,
        initialLawReport: initialLawReport,
      ),
    );
  }

  static void pushDetail(
    BuildContext context,
    JudgmentModel judgment,
  ) {
    Navigator.push(
      context,
      detail(judgment),
    );
  }

  static void pushRecent(BuildContext context) {
    Navigator.push(
      context,
      recent(),
    );
  }

  static void pushBookmarks(BuildContext context) {
    Navigator.push(
      context,
      bookmarks(),
    );
  }
}