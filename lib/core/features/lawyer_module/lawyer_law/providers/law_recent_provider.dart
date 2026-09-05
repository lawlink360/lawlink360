import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_model.dart';

final lawRecentProvider =
    StateNotifierProvider<LawRecentNotifier, LawRecentState>(
  (ref) {
    return LawRecentNotifier();
  },
);

class LawRecentNotifier extends StateNotifier<LawRecentState> {
  LawRecentNotifier()
      : super(const LawRecentState());

  static const int maxRecentLaws = 10;

  /// Adds a law to the recently viewed list.
  ///
  /// If the law already exists, it is moved to the top.
  void addRecentLaw(LawModel law) {
    final updatedLaws = List<LawModel>.from(
      state.recentLaws,
    );

    updatedLaws.removeWhere(
      (item) => item.id == law.id,
    );

    updatedLaws.insert(0, law);

    if (updatedLaws.length > maxRecentLaws) {
      updatedLaws.removeRange(
        maxRecentLaws,
        updatedLaws.length,
      );
    }

    state = state.copyWith(
      recentLaws: updatedLaws,
    );
  }

  /// Removes a single law from recent history.
  void removeRecentLaw(String lawId) {
    final updatedLaws = state.recentLaws
        .where((law) => law.id != lawId)
        .toList();

    state = state.copyWith(
      recentLaws: updatedLaws,
    );
  }

  /// Clears all recently viewed laws.
  void clearRecentLaws() {
    state = const LawRecentState();
  }

  /// Checks whether a law exists in recent history.
  bool contains(String lawId) {
    return state.recentLaws.any(
      (law) => law.id == lawId,
    );
  }
}

class LawRecentState {
  const LawRecentState({
    this.recentLaws = const [],
  });

  final List<LawModel> recentLaws;

  LawRecentState copyWith({
    List<LawModel>? recentLaws,
  }) {
    return LawRecentState(
      recentLaws: recentLaws ?? this.recentLaws,
    );
  }
}