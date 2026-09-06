import '../enums/content_type.dart';
import '../models/navigator_item_model.dart';
import '../enums/navigator_item_type.dart';

class NavigatorHelper {
  static List<NavigatorItemModel> filterCurrentCategory({
    required ContentType contentType,
    required List<NavigatorItemModel> items,
  }) {
    return items.where((item) {
      switch (contentType) {
        case ContentType.law:
          return item.type != NavigatorItemType.relevantLaws;

        case ContentType.judgment:
          return item.type != NavigatorItemType.relatedJudgments;

        case ContentType.procedure:
          return item.type != NavigatorItemType.relatedProcedures;

        case ContentType.application:
          return item.type != NavigatorItemType.relatedApplications;

        case ContentType.drafting:
          return item.type != NavigatorItemType.drafting;

        default:
          return true;
      }
    }).toList();
  }
}