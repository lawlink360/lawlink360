import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_firm_model.dart';

/// Maximum number of law firms retained in the recently viewed list.
///
/// This mirrors the lawyer provider's retention cap of 5. The Find Lawyer
/// home screen shows a smaller preview (3); the full retained history is
/// available via the combined Recently Viewed screen.
const int _maxRecentlyViewedFirms = 5;

class RecentlyViewedFirmsNotifier extends Notifier<List<LawFirm>> {
  @override
  List<LawFirm> build() {
    return const [];
  }

  /// Records a law firm as recently viewed.
  ///
  /// The most recently opened firm is always placed first.
  /// Existing entries are removed before re-inserting the firm, preventing
  /// duplicate cards.
  void add(LawFirm firm) {
    final updated = [
      firm,
      ...state.where((item) => item.id != firm.id),
    ];

    state = updated.take(_maxRecentlyViewedFirms).toList();
  }

  /// Removes one law firm from the recently viewed list.
  void remove(String firmId) {
    state = state.where((firm) => firm.id != firmId).toList();
  }

  /// Clears the entire recently viewed list.
  void clear() {
    state = const [];
  }
}

final recentlyViewedFirmsProvider =
    NotifierProvider<RecentlyViewedFirmsNotifier, List<LawFirm>>(
  RecentlyViewedFirmsNotifier.new,
);