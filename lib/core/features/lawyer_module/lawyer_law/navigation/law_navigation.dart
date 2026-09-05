import 'package:flutter/material.dart';

import '../models/law_category_model.dart';
import '../models/law_model.dart';
import '../screens/law_az_screen.dart';
import '../screens/law_bookmark_screen.dart';
import '../screens/law_categories_screen.dart';
import '../screens/law_category_law_screen.dart';
import '../screens/law_detail_screen.dart';
import '../screens/law_dashboard_screen.dart';
import '../screens/law_search_screen.dart';

class LawNavigation {
  const LawNavigation._();

  /// Opens the main Law Dashboard.
  static void openLawDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LawDashboardScreen(),
      ),
    );
  }

  /// Opens the A-Z Law Index.
  static void openLawAZ(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LawAzScreen(),
      ),
    );
  }

  /// Opens the law categories screen.
  static void openCategories(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LawCategoriesScreen(),
      ),
    );
  }

  /// Opens laws belonging to a category.
  static void openCategoryLaws(
    BuildContext context,
    LawCategoryModel category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawCategoryLawsScreen(
          category: category,
        ),
      ),
    );
  }

  /// Opens the law search screen.
  static void openSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LawSearchScreen(),
      ),
    );
  }

  /// Opens a specific law.
  static void openLawDetail(
    BuildContext context,
    LawModel law,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawDetailScreen(
          law: law,
        ),
      ),
    );
  }

  /// Opens bookmarked laws.
  static void openBookmarks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LawBookmarkScreen(),
      ),
    );
  }

  /// Returns a route for the Law section.
  static Route<dynamic> route(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case '/law':
        return MaterialPageRoute(
          builder: (_) => const LawDashboardScreen(),
          settings: settings,
        );

      case '/law/az':
        return MaterialPageRoute(
          builder: (_) => const LawAzScreen(),
          settings: settings,
        );

      case '/law/categories':
        return MaterialPageRoute(
          builder: (_) => const LawCategoriesScreen(),
          settings: settings,
        );

      case '/law/search':
        return MaterialPageRoute(
          builder: (_) => const LawSearchScreen(),
          settings: settings,
        );

      case '/law/bookmarks':
        return MaterialPageRoute(
          builder: (_) => const LawBookmarkScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const LawDashboardScreen(),
          settings: settings,
        );
    }
  }
}