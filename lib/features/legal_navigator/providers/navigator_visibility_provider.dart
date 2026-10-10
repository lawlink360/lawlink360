import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/default_navigator_items.dart';
import '../models/navigator_item_model.dart';

/// Items from [defaultNavigatorItems] whose [NavigatorItemModel.isVisible]
/// flag is true.
///
/// This provider does not perform content-type filtering and does not
/// manage the "expanded" flag. Current-content filtering is applied by
/// `NavigatorHelper.filterCurrentCategory(...)` inside the widget, and
/// the expanded flag remains local to the widget's state.
final visibleNavigatorItemsProvider =
    Provider<List<NavigatorItemModel>>((ref) {
  return defaultNavigatorItems
      .where((item) => item.isVisible)
      .toList(growable: false);
});