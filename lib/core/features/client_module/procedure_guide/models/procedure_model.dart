import 'procedure_step.dart';

class ProcedureModel {
  final String id;
  final String categoryId;

  final String title;
  final String overview;

  /// New Fields
  final String governmentDepartment;
  final String eligibility;

  final List<String> requiredDocuments;
  final List<String> applicableLaws;

  final List<String> importantNotes;
  final List<String> commonMistakes;

  final String estimatedFee;
  final String estimatedTime;

  final List<ProcedureStep> steps;

  const ProcedureModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.overview,

    /// New Fields
    required this.governmentDepartment,
    required this.eligibility,

    required this.requiredDocuments,
    required this.applicableLaws,

    required this.importantNotes,
    required this.commonMistakes,

    required this.estimatedFee,
    required this.estimatedTime,

    required this.steps,
  });
}