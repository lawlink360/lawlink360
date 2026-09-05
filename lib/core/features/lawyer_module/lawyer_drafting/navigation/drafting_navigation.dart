
import 'package:flutter/material.dart';

import '../screens/create_draft_screen.dart';
import '../screens/draft_categories_screen.dart';
import '../screens/draft_editor_screen.dart';
import '../screens/draft_preview_screen.dart';
import '../screens/drafting_dashboard_screen.dart';
import '../screens/my_drafts_screen.dart';

class DraftingNavigation {
  DraftingNavigation._();

  // ============================================================
  // ROUTE NAMES
  // ============================================================

  static const String dashboard = '/drafting';
  static const String categories = '/drafting/categories';
  static const String createDraft = '/drafting/create';
  static const String myDrafts = '/drafting/my-drafts';
  static const String editor = '/drafting/editor';
  static const String preview = '/drafting/preview';

  // ============================================================
  // ROUTE GENERATOR
  // ============================================================

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DraftingDashboardScreen(),
          settings: settings,
        );

      case categories:
        return MaterialPageRoute(
          builder: (_) => const DraftCategoriesScreen(),
          settings: settings,
        );

      case createDraft:
        return MaterialPageRoute(
          builder: (_) => const CreateDraftScreen(),
          settings: settings,
        );

      case myDrafts:
        return MaterialPageRoute(
          builder: (_) => const MyDraftsScreen(),
          settings: settings,
        );

      case editor:
        return MaterialPageRoute(
          builder: (_) => const DraftEditorScreen(),
          settings: settings,
        );

      case preview:
        return MaterialPageRoute(
          builder: (_) => const DraftPreviewScreen(),
          settings: settings,
        );

      default:
        return null;
    }
  }

  // ============================================================
  // NAVIGATION HELPERS
  // ============================================================

  static void openDashboard(BuildContext context) {
    Navigator.pushNamed(
      context,
      dashboard,
    );
  }

  static void openCategories(BuildContext context) {
    Navigator.pushNamed(
      context,
      categories,
    );
  }

  static void openCreateDraft(BuildContext context) {
    Navigator.pushNamed(
      context,
      createDraft,
    );
  }

  static void openMyDrafts(BuildContext context) {
    Navigator.pushNamed(
      context,
      myDrafts,
    );
  }

  static void openEditor(
    BuildContext context, {
    String? draftId,
  }) {
    Navigator.pushNamed(
      context,
      editor,
      arguments: draftId,
    );
  }

  static void openPreview(
    BuildContext context, {
    String? draftId,
  }) {
    Navigator.pushNamed(
      context,
      preview,
      arguments: draftId,
    );
  }
}
