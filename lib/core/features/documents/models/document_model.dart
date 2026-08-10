import 'document_type.dart';

class DocumentModel {
  final String id;
  final String title;
  final String fileName;
  final DocumentType type;

  final DateTime createdAt;

  final bool favorite;
  final bool verified;

  const DocumentModel({
    required this.id,
    required this.title,
    required this.fileName,
    required this.type,
    required this.createdAt,
    required this.favorite,
    required this.verified,
  });
}