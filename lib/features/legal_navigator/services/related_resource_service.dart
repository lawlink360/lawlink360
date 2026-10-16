import 'package:lawlink360/core/features/client_module/procedure_guide/data/procedure_data.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/models/procedure_model.dart';
import 'package:lawlink360/core/repositories/procedure_repository.dart';

import '../enums/content_type.dart';
import '../models/related_resource_model.dart';

/// The four distinct states a Legal Navigator resource lookup
/// can produce.
///
/// * [available]    – the lookup succeeded and returned one or more items.
/// * [empty]        – the lookup succeeded and returned no items.
/// * [unavailable]  – the required dataset or relationship mapping is
///                    not yet implemented, or the procedure could not
///                    be resolved safely.
/// * [error]        – an unexpected failure occurred during the lookup.
enum RelatedResourceStatus {
  available,
  empty,
  unavailable,
  error,
}

/// Result of resolving related procedures for a given procedure.
///
/// Always carries a [status]. When [status] is
/// [RelatedResourceStatus.available], [items] contains the related
/// procedures. Otherwise, [items] is empty. When [status] is
/// [RelatedResourceStatus.unavailable] or
/// [RelatedResourceStatus.error], [message] holds a user-facing
/// message suitable for display in an empty-state widget.
class RelatedProceduresResult {
  final RelatedResourceStatus status;
  final List<ProcedureModel> items;
  final String? message;

  const RelatedProceduresResult._(
    this.status,
    this.items,
    this.message,
  );

  const RelatedProceduresResult.available(
    List<ProcedureModel> items,
  ) : this._(RelatedResourceStatus.available, items, null);

  const RelatedProceduresResult.empty()
      : this._(RelatedResourceStatus.empty, const [], null);

  const RelatedProceduresResult.unavailable(String message)
      : this._(RelatedResourceStatus.unavailable, const [], message);

  const RelatedProceduresResult.error(String message)
      : this._(RelatedResourceStatus.error, const [], message);
}

/// Result of resolving required documents for a given procedure.
///
/// Uses the same [RelatedResourceStatus] enum but carries a
/// `List<String>` of document descriptions rather than a list of
/// [ProcedureModel].
///
/// * [available]   – the procedure resolved uniquely and its
///                   `requiredDocuments` list is non-empty.
/// * [empty]       – the procedure resolved uniquely but its
///                   `requiredDocuments` list is empty.
/// * [unavailable] – the procedure id is empty, unknown, or
///                   duplicated across categories.
/// * [error]       – an unexpected failure occurred during the
///                   lookup.
class RelatedDocumentsResult {
  final RelatedResourceStatus status;
  final List<String> documents;
  final String? message;

  const RelatedDocumentsResult._(
    this.status,
    this.documents,
    this.message,
  );

  const RelatedDocumentsResult.available(
    List<String> documents,
  ) : this._(RelatedResourceStatus.available, documents, null);

  const RelatedDocumentsResult.empty()
      : this._(RelatedResourceStatus.empty, const [], null);

  const RelatedDocumentsResult.unavailable(String message)
      : this._(RelatedResourceStatus.unavailable, const [], message);

  const RelatedDocumentsResult.error(String message)
      : this._(RelatedResourceStatus.error, const [], message);
}

class RelatedResourceService {
  const RelatedResourceService();

  /// Existing resolver. Preserved unchanged so that
  /// [relatedResourcesProvider] and any other current consumer
  /// continues to compile and behave exactly as before.
  List<RelatedResourceModel> resolve({
    required ContentType contentType,
    required String contentId,
  }) {
    final trimmedId = contentId.trim();
    if (trimmedId.isEmpty) return const <RelatedResourceModel>[];

    switch (contentType) {
      case ContentType.procedure:
        return _relatedForProcedure(trimmedId);

      case ContentType.law:
      case ContentType.judgment:
      case ContentType.application:
      case ContentType.drafting:
      case ContentType.document:
      case ContentType.faq:
      case ContentType.lawyer:
        return const <RelatedResourceModel>[];
    }
  }

  List<RelatedResourceModel> _relatedForProcedure(String procedureId) {
    return const <RelatedResourceModel>[];
  }

  // ============================================================
  // RELATED PROCEDURES
  // ============================================================

  /// Resolves the "Related Procedures" list for [procedureId].
  ///
  /// Resolution rules:
  ///
  /// 1. If [procedureId] is empty, returns `unavailable`.
  /// 2. If the id is unknown, returns `unavailable`.
  /// 3. If the id is duplicated across categories, returns
  ///    `unavailable`. The resolver cannot safely disambiguate
  ///    which category's procedure the user is viewing.
  /// 4. If the id resolves to exactly one procedure, returns all
  ///    other procedures that share the same `categoryId`,
  ///    excluding the current procedure itself.
  /// 5. If the same-category list is empty, returns `empty`.
  ///
  /// The lookup is synchronous. No exceptions are thrown.
  RelatedProceduresResult resolveRelatedProcedures(String procedureId) {
    final trimmed = procedureId.trim();

    if (trimmed.isEmpty) {
      return const RelatedProceduresResult.unavailable(
        'This information is being updated. Please check back later.',
      );
    }

    final duplicateCount = _countById(trimmed);

    if (duplicateCount == 0) {
      return const RelatedProceduresResult.unavailable(
        'This information is being updated. Please check back later.',
      );
    }

    if (duplicateCount > 1) {
      // The id appears in more than one category. Selecting the
      // first match would risk showing procedures from a
      // different category than the one the user is viewing.
      return const RelatedProceduresResult.unavailable(
        'This information is being updated. Please check back later.',
      );
    }

    final repository = const ProcedureRepository();
    final current = repository.getProcedureById(trimmed);

    if (current == null) {
      return const RelatedProceduresResult.unavailable(
        'This information is being updated. Please check back later.',
      );
    }

    final sameCategory = repository.getProceduresByCategory(
      current.categoryId,
    );

    final related = sameCategory
        .where((procedure) => procedure.id != current.id)
        .toList(growable: false);

    if (related.isEmpty) {
      return const RelatedProceduresResult.empty();
    }

    return RelatedProceduresResult.available(related);
  }

  // ============================================================
  // RELATED APPLICATIONS
  // ============================================================

  /// Resolves the "Relevant Applications" list for [procedureId].
  ///
  /// No reliable procedure-to-template mapping exists in the
  /// current source. Rather than fabricating a relationship or
  /// matching by title, this method always returns `unavailable`
  /// with a user-facing message. When a real mapping dataset is
  /// introduced, this method can be updated to return `available`
  /// items.
  ///
  /// The method does not read any application data. It does not
  /// use string matching. It does not call
  /// [resolveRelatedProcedures].
  RelatedProceduresResult resolveRelatedApplications(String procedureId) {
    // Deliberately ignores the id. Every procedure currently
    // returns the same unavailable state because no mapping exists.
    return const RelatedProceduresResult.unavailable(
      'Applications relevant to this procedure are being updated. '
      'Please check back later.',
    );
  }

  // ============================================================
  // REQUIRED DOCUMENTS
  // ============================================================

  /// Resolves the "Required Documents" list for [procedureId].
  ///
  /// Resolution rules:
  ///
  /// 1. If [procedureId] is empty, returns `unavailable`.
  /// 2. If the id is unknown, returns `unavailable`.
  /// 3. If the id is duplicated across categories, returns
  ///    `unavailable`. The resolver cannot safely disambiguate
  ///    which category's procedure the user is viewing.
  /// 4. If the id resolves to exactly one procedure, returns
  ///    `available` with the procedure's `requiredDocuments` list
  ///    when that list is non-empty.
  /// 5. If the resolved procedure's `requiredDocuments` list is
  ///    empty, returns `empty`.
  /// 6. If an unexpected exception is thrown during the lookup,
  ///    returns `error` with a user-facing message.
  ///
  /// The lookup is synchronous. Exceptions are caught and returned
  /// as an `error` result; they do not escape this method.
  RelatedDocumentsResult resolveRequiredDocuments(String procedureId) {
    try {
      final trimmed = procedureId.trim();

      if (trimmed.isEmpty) {
        return const RelatedDocumentsResult.unavailable(
          'This information is being updated. Please check back later.',
        );
      }

      final duplicateCount = _countById(trimmed);

      if (duplicateCount == 0) {
        return const RelatedDocumentsResult.unavailable(
          'This information is being updated. Please check back later.',
        );
      }

      if (duplicateCount > 1) {
        // The id appears in more than one category. Selecting the
        // first match would risk showing documents for a
        // different procedure than the one the user is viewing.
        return const RelatedDocumentsResult.unavailable(
          'This information is being updated. Please check back later.',
        );
      }

      final repository = const ProcedureRepository();
      final current = repository.getProcedureById(trimmed);

      if (current == null) {
        return const RelatedDocumentsResult.unavailable(
          'This information is being updated. Please check back later.',
        );
      }

      if (current.requiredDocuments.isEmpty) {
        return const RelatedDocumentsResult.empty();
      }

      return RelatedDocumentsResult.available(current.requiredDocuments);
    } catch (_) {
      return const RelatedDocumentsResult.error(
        "We couldn't load this information. Please try again.",
      );
    }
  }

  int _countById(String procedureId) {
    var count = 0;
    for (final procedure in ProcedureData.procedures) {
      if (procedure.id == procedureId) {
        count++;
      }
    }
    return count;
  }
}