import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/content_type.dart';
import '../models/related_resource_model.dart';
import '../services/related_resource_service.dart';

/// Exposes a single [RelatedResourceService] instance.
final relatedResourceServiceProvider =
    Provider<RelatedResourceService>((ref) {
  return const RelatedResourceService();
});

/// Existing family provider. Preserved unchanged.
final relatedResourcesProvider = Provider.family<
    List<RelatedResourceModel>,
    ({ContentType contentType, String contentId})>((ref, context) {
  final service = ref.watch(relatedResourceServiceProvider);
  return service.resolve(
    contentType: context.contentType,
    contentId: context.contentId,
  );
});

/// Resolves the "Related Procedures" list for a given procedure id.
///
/// Synchronous. Returns a [RelatedProceduresResult] describing
/// whether related procedures exist, whether the lookup succeeded
/// with no results, or whether the necessary data or relationship
/// mapping is not yet available.
final relatedProceduresProvider = Provider.family<
    RelatedProceduresResult,
    String>((ref, procedureId) {
  final service = ref.watch(relatedResourceServiceProvider);
  return service.resolveRelatedProcedures(procedureId);
});

/// Resolves the "Relevant Applications" list for a given procedure id.
///
/// Synchronous. Currently always returns the `unavailable` state
/// because no reliable procedure-to-template mapping exists.
/// When a real mapping dataset is introduced, this provider's
/// underlying service method can be updated; the provider itself
/// does not need to change.
final relatedApplicationsProvider = Provider.family<
    RelatedProceduresResult,
    String>((ref, procedureId) {
  final service = ref.watch(relatedResourceServiceProvider);
  return service.resolveRelatedApplications(procedureId);
});

/// Resolves the "Required Documents" list for a given procedure id.
///
/// Synchronous. Returns a [RelatedDocumentsResult] describing
/// whether documents exist, whether the lookup succeeded with an
/// empty list, or whether the procedure could not be resolved
/// safely (empty, unknown, or duplicated id).
final relatedDocumentsProvider = Provider.family<
    RelatedDocumentsResult,
    String>((ref, procedureId) {
  final service = ref.watch(relatedResourceServiceProvider);
  return service.resolveRequiredDocuments(procedureId);
});