import '../enums/content_type.dart';
import '../models/related_resource_model.dart';

/// Resolves related legal resources for a given
/// (contentType, contentId) context.
///
/// This is intentionally a synchronous, in-memory resolver for the
/// current static phase. No Firebase, Firestore, or network access
/// is introduced. When a real dataset for a content type does not
/// exist yet, an empty list is returned so callers fail gracefully
/// instead of showing fabricated content.
class RelatedResourceService {
  const RelatedResourceService();

  List<RelatedResourceModel> resolve({
    required ContentType contentType,
    required String contentId,
  }) {
    final trimmedId = contentId.trim();
    if (trimmedId.isEmpty) return const <RelatedResourceModel>[];

    switch (contentType) {
      case ContentType.procedure:
        // No real related-resource dataset exists yet for procedures.
        // Returning an empty list keeps the navigator honest and
        // prevents fabricated relationships.
        return _relatedForProcedure(trimmedId);

      case ContentType.law:
      case ContentType.judgment:
      case ContentType.application:
      case ContentType.drafting:
      case ContentType.document:
      case ContentType.faq:
      case ContentType.lawyer:
        return const <RelatedResourceModel>[];
    }
  }

  /// Hook for future real data. Currently returns an empty list.
  List<RelatedResourceModel> _relatedForProcedure(String procedureId) {
    return const <RelatedResourceModel>[];
  }
}