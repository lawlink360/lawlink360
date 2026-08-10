/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : related_resource_model.dart
/// Purpose : Represents a related legal resource.
/// ------------------------------------------------------------

import '../enums/content_type.dart';

class RelatedResourceModel {
  final String id;
  final String title;
  final ContentType contentType;
  final String route;
  final String? description;

  const RelatedResourceModel({
    required this.id,
    required this.title,
    required this.contentType,
    required this.route,
    this.description,
  });
}