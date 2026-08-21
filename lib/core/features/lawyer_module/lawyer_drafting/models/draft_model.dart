
class DraftModel {
  final String id;

  // ======================================================
  // BASIC INFORMATION
  // ======================================================

  final String title;
  final String category;
  final String? clientId;
  final String? clientName;
  final String? caseId;
  final String? caseTitle;

  // ======================================================
  // CONTENT
  // ======================================================

  final String content;

  // ======================================================
  // STATUS
  // ======================================================

  final String status;

  // ======================================================
  // DATES
  // ======================================================

  final DateTime createdAt;
  final DateTime updatedAt;

  const DraftModel({
    required this.id,
    required this.title,
    required this.category,
    this.clientId,
    this.clientName,
    this.caseId,
    this.caseTitle,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // ======================================================
  // COPY WITH
  // ======================================================

  DraftModel copyWith({
    String? id,
    String? title,
    String? category,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    String? content,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DraftModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      content: content ?? this.content,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
