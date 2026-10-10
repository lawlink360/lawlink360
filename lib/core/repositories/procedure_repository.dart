import 'package:lawlink360/core/features/client_module/procedure_guide/data/procedure_data.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/models/procedure_category.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/models/procedure_model.dart';

/// Read-only data access for Procedure Guide content.
///
/// The current procedure data source is a pair of static in-memory
/// collections in `ProcedureData`. This repository wraps that source
/// so higher layers can depend on a single, explicit access point
/// without reading the data file directly.
///
/// No Firebase, Firestore, or remote data source is used at this
/// stage. This class is synchronous.
class ProcedureRepository {
  const ProcedureRepository();

  // ============================================================
  // Procedures
  // ============================================================

  /// Returns a copy of the full procedure list.
  ///
  /// The returned list is a new list; mutating it does not affect
  /// the underlying data source.
  List<ProcedureModel> getAllProcedures() {
    return List<ProcedureModel>.from(
      ProcedureData.procedures,
    );
  }

  /// Returns the first procedure whose id matches [procedureId],
  /// or `null` when no such procedure exists.
  ///
  /// If more than one procedure shares the same id, the first match
  /// in `ProcedureData.procedures` is returned.
  ProcedureModel? getProcedureById(String procedureId) {
    for (final procedure in ProcedureData.procedures) {
      if (procedure.id == procedureId) {
        return procedure;
      }
    }
    return null;
  }

  /// Returns every procedure whose categoryId matches [categoryId].
  List<ProcedureModel> getProceduresByCategory(String categoryId) {
    return ProcedureData.procedures
        .where((procedure) => procedure.categoryId == categoryId)
        .toList();
  }

  /// Returns the total number of procedures currently available.
  int getTotalProcedureCount() {
    return ProcedureData.procedures.length;
  }

  // ============================================================
  // Categories
  // ============================================================

  /// Returns a copy of the full procedure category list.
  List<ProcedureCategory> getAllCategories() {
    return List<ProcedureCategory>.from(
      ProcedureData.categories,
    );
  }

  /// Returns the category whose id matches [categoryId],
  /// or `null` when no such category exists.
  ProcedureCategory? getCategoryById(String categoryId) {
    for (final category in ProcedureData.categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }

  /// Returns the total number of procedure categories.
  int getTotalCategoryCount() {
    return ProcedureData.categories.length;
  }
}