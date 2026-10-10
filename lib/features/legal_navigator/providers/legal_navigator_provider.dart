import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/navigator_state.dart';
import '../models/navigator_item_model.dart';
import 'navigator_state_provider.dart';
import 'navigator_visibility_provider.dart';

/// Read-only snapshot of the Legal Navigator's current view inputs.
///
/// Combines the visible items list with the current [NavigatorState].
/// It does not carry related-resource data and does not manage
/// per-widget flags such as "expanded".
class LegalNavigatorView {
  const LegalNavigatorView({
    required this.items,
    required this.state,
  });

  final List<NavigatorItemModel> items;
  final NavigatorState state;
}

/// Aggregate provider consumed by callers that want a single `watch`.
///
/// The underlying providers remain the source of truth:
/// * [visibleNavigatorItemsProvider] supplies [LegalNavigatorView.items].
/// * [navigatorStateProvider] supplies [LegalNavigatorView.state].
final legalNavigatorProvider = Provider<LegalNavigatorView>((ref) {
  final items = ref.watch(visibleNavigatorItemsProvider);
  final state = ref.watch(navigatorStateProvider);

  return LegalNavigatorView(
    items: items,
    state: state,
  );
});