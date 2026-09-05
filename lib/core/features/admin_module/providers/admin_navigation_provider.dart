import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls the currently selected section of the Admin Module.
final adminNavigationProvider =
    StateNotifierProvider<AdminNavigationNotifier, int>((ref) {
  return AdminNavigationNotifier();
});

/// Manages Admin navigation state.
class AdminNavigationNotifier extends StateNotifier<int> {
  AdminNavigationNotifier() : super(0);

  /// Changes the currently selected Admin navigation index.
  void setIndex(int index) {
    state = index;
  }

  /// Resets navigation to the Dashboard.
  void reset() {
    state = 0;
  }
}