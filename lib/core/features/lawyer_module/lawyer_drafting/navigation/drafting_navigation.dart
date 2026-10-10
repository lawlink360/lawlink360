import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client_module/help_support/screens/help_support_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_judgments/screens/judgment_home_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_law/screens/law_dashboard_screen.dart';

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

  // Legal Navigator destinations.
  static const String laws = '/laws';
  static const String judgments = '/judgments';
  static const String procedures = '/procedure-guide';
  static const String applications = '/applications';
  // Required Documents is routed to the Procedure Guide workflow.
  static const String documents = '/documents';
  static const String findLawyer = '/find-lawyer';
  static const String faqs = '/faqs';

  // ============================================================
  // ROUTE GENERATOR
  // ============================================================

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ----------------------------------------------------------
      // Existing drafting routes (unchanged).
      // ----------------------------------------------------------
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

      // ----------------------------------------------------------
      // Legal Navigator destinations.
      // ----------------------------------------------------------
      case laws:
        return MaterialPageRoute(
          builder: (_) => const LawDashboardScreen(),
          settings: settings,
        );

      case judgments:
        return MaterialPageRoute(
          builder: (_) => const JudgmentHomeScreen(),
          settings: settings,
        );

      case procedures:
        return MaterialPageRoute(
          builder: (_) => const GuiderHomeScreen(),
          settings: settings,
        );

      case applications:
        return MaterialPageRoute(
          builder: (_) => const ApplicationHomeScreen(),
          settings: settings,
        );

      case documents:
        // Required Documents -> Procedure Guide workflow.
        // Not the user-owned My Documents screen.
        return MaterialPageRoute(
          builder: (_) => const GuiderHomeScreen(),
          settings: settings,
        );

      case findLawyer:
        return MaterialPageRoute(
          builder: (_) => const FindLawyerScreen(),
          settings: settings,
        );

      case faqs:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportScreen(),
          settings: settings,
        );

      // ----------------------------------------------------------
      // Unregistered destinations.
      // Search Related Content and AI Legal Assistant are not
      // routed. Returning null is the existing behaviour; the
      // Legal Navigator handles the resulting FlutterError with
      // a "not available yet" SnackBar.
      // ----------------------------------------------------------
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