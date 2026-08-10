import '../models/navigator_item_model.dart';

class VisibilityHelper {
  static List<NavigatorItemModel> visibleItems(
      List<NavigatorItemModel> items) {
    return items.where((e) => e.isVisible).toList();
  }
}