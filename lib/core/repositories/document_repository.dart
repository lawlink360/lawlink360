import 'package:lawlink360/core/features/client_module/documents/data/document_data.dart';
import 'package:lawlink360/core/features/client_module/documents/models/document_model.dart';
import 'package:lawlink360/core/features/client_module/documents/models/document_type.dart';

/// Read-only data access for the user-owned documents feature.
///
/// The current data source is a static in-memory list
/// (`DocumentData.documents`). This repository wraps that source so
/// higher layers can depend on a single, explicit access point
/// without reading the data file directly.
///
/// No Firebase, Firestore, file storage, upload, or remote data
/// source is used at this stage. This class is synchronous.
class DocumentRepository {
  const DocumentRepository();

  /// Returns a copy of the full document list.
  ///
  /// The returned list is a new list; mutating it does not affect
  /// the underlying data source.
  List<DocumentModel> getAllDocuments() {
    return List<DocumentModel>.from(
      DocumentData.documents,
    );
  }

  /// Returns the document with [documentId],
  /// or `null` when no such document exists.
  DocumentModel? getDocumentById(String documentId) {
    for (final document in DocumentData.documents) {
      if (document.id == documentId) {
        return document;
      }
    }
    return null;
  }

  /// Returns every document whose type is [type].
  List<DocumentModel> getDocumentsByType(DocumentType type) {
    return DocumentData.documents
        .where((document) => document.type == type)
        .toList();
  }

  /// Returns every document flagged as favorite.
  List<DocumentModel> getFavoriteDocuments() {
    return DocumentData.documents
        .where((document) => document.favorite)
        .toList();
  }

  /// Returns every document flagged as verified.
  List<DocumentModel> getVerifiedDocuments() {
    return DocumentData.documents
        .where((document) => document.verified)
        .toList();
  }

  /// Returns every document whose fileName matches [fileName] exactly.
  ///
  /// Exact match is used because the current model has no path and
  /// the file name is the only stable reference to a stored file.
  DocumentModel? getDocumentByFileName(String fileName) {
    for (final document in DocumentData.documents) {
      if (document.fileName == fileName) {
        return document;
      }
    }
    return null;
  }

  /// Returns the total number of documents currently available.
  int getTotalCount() {
    return DocumentData.documents.length;
  }
}