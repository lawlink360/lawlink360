import '../models/draft_model.dart';

class DraftingService {
  DraftingService._();

  // ============================================================
  // CREATE DRAFT
  // ============================================================

  static DraftModel createDraft({
    required String title,
    required String category,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    String content = '',
    String status = 'Draft',
  }) {
    final now = DateTime.now();

    return DraftModel(
      id: 'draft_${now.microsecondsSinceEpoch}',
      title: title,
      category: category,
      clientId: clientId,
      clientName: clientName,
      caseId: caseId,
      caseTitle: caseTitle,
      content: content,
      status: status,
      createdAt: now,
      updatedAt: now,
    );
  }

  // ============================================================
  // UPDATE DRAFT
  // ============================================================

  static DraftModel updateDraft({
    required DraftModel draft,
    String? title,
    String? category,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    String? content,
    String? status,
  }) {
    return draft.copyWith(
      title: title,
      category: category,
      clientId: clientId,
      clientName: clientName,
      caseId: caseId,
      caseTitle: caseTitle,
      content: content,
      status: status,
      updatedAt: DateTime.now(),
    );
  }

  // ============================================================
  // DUPLICATE DRAFT
  // ============================================================

  static DraftModel duplicateDraft(DraftModel draft) {
    final now = DateTime.now();

    return DraftModel(
      id: 'draft_${now.microsecondsSinceEpoch}',
      title: '${draft.title} - Copy',
      category: draft.category,
      clientId: draft.clientId,
      clientName: draft.clientName,
      caseId: draft.caseId,
      caseTitle: draft.caseTitle,
      content: draft.content,
      status: 'Draft',
      createdAt: now,
      updatedAt: now,
    );
  }

  // ============================================================
  // MARK AS FINALIZED
  // ============================================================

  static DraftModel finalizeDraft(DraftModel draft) {
    return draft.copyWith(
      status: 'Finalized',
      updatedAt: DateTime.now(),
    );
  }

  // ============================================================
  // MARK AS SENT
  // ============================================================

  static DraftModel markAsSent(DraftModel draft) {
    return draft.copyWith(
      status: 'Sent',
      updatedAt: DateTime.now(),
    );
  }

  // ============================================================
  // SEARCH DRAFTS
  // ============================================================

  static List<DraftModel> searchDrafts(
    List<DraftModel> drafts,
    String query,
  ) {
    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      return drafts;
    }

    return drafts.where((draft) {
      return draft.title.toLowerCase().contains(searchQuery) ||
          draft.category.toLowerCase().contains(searchQuery) ||
          (draft.clientName?.toLowerCase().contains(searchQuery) ?? false) ||
          (draft.caseTitle?.toLowerCase().contains(searchQuery) ?? false);
    }).toList();
  }

  // ============================================================
  // FILTER BY CATEGORY
  // ============================================================

  static List<DraftModel> filterByCategory(
    List<DraftModel> drafts,
    String category,
  ) {
    return drafts.where(
      (draft) => draft.category == category,
    ).toList();
  }

  // ============================================================
  // FILTER BY STATUS
  // ============================================================

  static List<DraftModel> filterByStatus(
    List<DraftModel> drafts,
    String status,
  ) {
    return drafts.where(
      (draft) => draft.status.toLowerCase() == status.toLowerCase(),
    ).toList();
  }

  // ============================================================
  // SORT BY UPDATED DATE
  // ============================================================

  static List<DraftModel> sortByUpdatedDate(
    List<DraftModel> drafts, {
    bool descending = true,
  }) {
    final sortedDrafts = List<DraftModel>.from(drafts);

    sortedDrafts.sort(
      (a, b) => descending
          ? b.updatedAt.compareTo(a.updatedAt)
          : a.updatedAt.compareTo(b.updatedAt),
    );

    return sortedDrafts;
  }

  // ============================================================
  // GET RECENT DRAFTS
  // ============================================================

  static List<DraftModel> getRecentDrafts(
    List<DraftModel> drafts, {
    int limit = 5,
  }) {
    final sortedDrafts = sortByUpdatedDate(drafts);

    return sortedDrafts.take(limit).toList();
  }
}