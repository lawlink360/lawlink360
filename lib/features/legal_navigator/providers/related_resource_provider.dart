import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/content_type.dart';
import '../models/related_resource_model.dart';
import '../services/related_resource_service.dart';

/// Exposes a single [RelatedResourceService] instance.
final relatedResourceServiceProvider =
    Provider<RelatedResourceService>((ref) {
  return const RelatedResourceService();
});

/// Resolves related resources for a given (contentType, contentId)
/// context. Synchronous for the current static phase.
final relatedResourcesProvider = Provider.family<
    List<RelatedResourceModel>,
    ({ContentType contentType, String contentId})>((ref, context) {
  final service = ref.watch(relatedResourceServiceProvider);
  return service.resolve(
    contentType: context.contentType,
    contentId: context.contentId,
  );
});