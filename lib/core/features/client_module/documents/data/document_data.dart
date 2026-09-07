import '../models/document_model.dart';
import '../models/document_type.dart';

class DocumentData {
  static final List<DocumentModel> documents = [
    DocumentModel(
      id: "DOC001",
      title: "Property Mutation",
      fileName: "mutation.pdf",
      type: DocumentType.legal,
      createdAt: DateTime.now(),
      favorite: true,
      verified: true,
    ),

    DocumentModel(
      id: "DOC002",
      title: "Sale Agreement",
      fileName: "sale_agreement.pdf",
      type: DocumentType.application,
      createdAt: DateTime.now(),
      favorite: false,
      verified: false,
    ),

    DocumentModel(
      id: "DOC003",
      title: "CNIC Translation",
      fileName: "cnic_translation.pdf",
      type: DocumentType.translated,
      createdAt: DateTime.now(),
      favorite: true,
      verified: false,
    ),
  ];
}