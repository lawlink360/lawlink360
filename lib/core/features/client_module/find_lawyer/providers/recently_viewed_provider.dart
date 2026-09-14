import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_model.dart';

/// Maximum number of lawyers retained in the recently viewed list.
const int _maxRecentlyViewed = 5;

class RecentlyViewedNotifier extends Notifier<List<Lawyer>> {
  @override
  List<Lawyer> build() {
    return const [];
  }

  /// Records a lawyer as recently viewed.
  ///
  /// The most recently opened lawyer is always placed first.
  /// Existing entries are removed before re-inserting the lawyer, preventing
  /// duplicate cards.
  void add(Lawyer lawyer) {
    final updated = [
      lawyer,
      ...state.where((item) => item.id != lawyer.id),
    ];

    state = updated.take(_maxRecentlyViewed).toList();
  }

  /// Removes one lawyer from the recently viewed list.
  void remove(String lawyerId) {
    state = state.where((lawyer) => lawyer.id != lawyerId).toList();
  }

  /// Clears the entire recently viewed list.
  void clear() {
    state = const [];
  }
}

final recentlyViewedProvider =
    NotifierProvider<RecentlyViewedNotifier, List<Lawyer>>(
  RecentlyViewedNotifier.new,
);