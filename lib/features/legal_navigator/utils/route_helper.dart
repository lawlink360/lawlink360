import '../data/navigator_routes.dart';
import '../enums/navigator_item_type.dart';

/// Resolves a [NavigatorItemType] to an application route path.
///
/// Returns `null` when the destination is not yet implemented in the
/// application. Callers must treat `null` as "no navigation available"
/// and fail gracefully instead of pushing a non-existent route.
class RouteHelper {
  const RouteHelper();

  /// Returns the route for [type], or null if unimplemented.
  String? resolve(NavigatorItemType type) {
    switch (type) {
      case NavigatorItemType.relevantLaws:
        return NavigatorRoutes.laws;
      case NavigatorItemType.relatedJudgments:
        return NavigatorRoutes.judgments;
      case NavigatorItemType.relatedProcedures:
        return NavigatorRoutes.procedures;
      case NavigatorItemType.relatedApplications:
        return NavigatorRoutes.applications;
      case NavigatorItemType.drafting:
        return NavigatorRoutes.drafting;
      case NavigatorItemType.requiredDocuments:
        return NavigatorRoutes.documents;
      case NavigatorItemType.findLawyer:
        return NavigatorRoutes.lawyers;
      case NavigatorItemType.faqs:
        return NavigatorRoutes.faqs;
      case NavigatorItemType.searchRelatedContent:
        return NavigatorRoutes.search;
      case NavigatorItemType.aiLegalAssistant:
        return null;
    }
  }

  /// Backward-compatible passthrough kept for callers that already
  /// used the previous static shape.
  static String getRoute(String route) => route;
}