import 'navigator_item_model.dart';

class NavigatorSectionModel {
  final String title;
  final List<NavigatorItemModel> items;

  const NavigatorSectionModel({
    required this.title,
    required this.items,
  });
}