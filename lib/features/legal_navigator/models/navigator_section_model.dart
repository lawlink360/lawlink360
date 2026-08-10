/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : navigator_section_model.dart
/// Purpose : Represents a section inside Legal Navigator.
/// ------------------------------------------------------------

import 'navigator_item_model.dart';

class NavigatorSectionModel {
  final String title;
  final List<NavigatorItemModel> items;

  const NavigatorSectionModel({
    required this.title,
    required this.items,
  });
}