
class DocumentModel {
  final String id;
  final String name;
  final String category;
  final String? caseId;
  final String? caseTitle;
  final String? clientId;
  final String? clientName;
  final String filePath;
  final String fileType;
  final int? fileSize;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DocumentModel({
    required this.id,
    required this.name,
    required this.category,
    this.caseId,
    this.caseTitle,
    this.clientId,
    this.clientName,
    required this.filePath,
    required this.fileType,
    this.fileSize,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  DocumentModel copyWith({
    String? id,
    String? name,
    String? category,
    String? caseId,
    String? caseTitle,
    String? clientId,
    String? clientName,
    String? filePath,
    String? fileType,
    int? fileSize,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}