import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/navigator_state.dart';

/// Holds the current lifecycle state of the Legal Navigator.
///
/// This is a synchronous, in-memory state for the current static phase.
/// Callers set the state directly; nothing in the current architecture
/// loads the Legal Navigator asynchronously.
class NavigatorStateNotifier extends Notifier<NavigatorState> {
  @override
  NavigatorState build() => NavigatorState.initial;

  /// Replaces the current state with [next].
  void set(NavigatorState next) {
    state = next;
  }

  /// Resets the state back to [NavigatorState.initial].
  void reset() {
    state = NavigatorState.initial;
  }
}

final navigatorStateProvider =
    NotifierProvider<NavigatorStateNotifier, NavigatorState>(
  NavigatorStateNotifier.new,
);