
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/draft_model.dart';
import '../data/drafting_data.dart';

class DraftProvider extends Notifier<List<DraftModel>> {
  @override
List<DraftModel> build() {
  return List<DraftModel>.from(
    DraftingData.drafts,
  );
}

  // ======================================================
  // ADD DRAFT
  // ======================================================

  void addDraft(DraftModel draft) {
    state = [...state, draft];
  }

  // ======================================================
  // UPDATE DRAFT
  // ======================================================

  void updateDraft(DraftModel updatedDraft) {
    state = [
      for (final draft in state)
        if (draft.id == updatedDraft.id)
          updatedDraft
        else
          draft,
    ];
  }

  // ======================================================
  // DELETE DRAFT
  // ======================================================

  void deleteDraft(String draftId) {
    state = state
        .where((draft) => draft.id != draftId)
        .toList();
  }

  // ======================================================
  // GET DRAFT
  // ======================================================

  DraftModel? getDraft(String draftId) {
    for (final draft in state) {
      if (draft.id == draftId) {
        return draft;
      }
    }

    return null;
  }
}

final draftProvider =
    NotifierProvider<DraftProvider, List<DraftModel>>(
  DraftProvider.new,
);
