import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Represents a locally selected attachment.
///
/// The file path is kept locally for now. Firebase Storage integration
/// can be added later without changing the Post Case UI architecture.
class DocumentAttachment {
  final String name;
  final String path;
  final String type;

  const DocumentAttachment({
    required this.name,
    required this.path,
    required this.type,
  });

  bool get isImage => type == 'image';

  bool get isDocument => type == 'document';
}

/// Manages local document/image selections for client uploads.
///
/// This provider intentionally does not upload anything to Firebase yet.
/// It only handles file selection and local attachment state.
class DocumentUploadNotifier
    extends StateNotifier<List<DocumentAttachment>> {
  DocumentUploadNotifier() : super(const []);

  final ImagePicker _imagePicker = ImagePicker();

  /// Opens the device camera and adds the captured image.
  Future<void> takePhoto() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (image == null) {
      return;
    }

    _addAttachment(
      DocumentAttachment(
        name: image.name,
        path: image.path,
        type: 'image',
      ),
    );
  }

  /// Opens the gallery and allows multiple images to be selected.
  Future<void> pickImages() async {
    final images = await _imagePicker.pickMultiImage(
      imageQuality: 90,
    );

    if (images.isEmpty) {
      return;
    }

    for (final image in images) {
      _addAttachment(
        DocumentAttachment(
          name: image.name,
          path: image.path,
          type: 'image',
        ),
      );
    }
  }

  /// Opens the document picker for PDF, DOC and DOCX files.
  Future<void> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const [
        'pdf',
        'doc',
        'docx',
      ],
    );

    if (result == null) {
      return;
    }

    for (final file in result.files) {
      final path = file.path;

      if (path == null || path.isEmpty) {
        continue;
      }

      _addAttachment(
        DocumentAttachment(
          name: file.name,
          path: path,
          type: 'document',
        ),
      );
    }
  }

  /// Removes one selected attachment.
  void removeAttachment(int index) {
    if (index < 0 || index >= state.length) {
      return;
    }

    final updated = List<DocumentAttachment>.from(state)
      ..removeAt(index);

    state = List.unmodifiable(updated);
  }

  /// Removes all selected attachments.
  void clearAll() {
    state = const [];
  }

  void _addAttachment(DocumentAttachment attachment) {
    final alreadyAdded = state.any(
      (existing) => existing.path == attachment.path,
    );

    if (alreadyAdded) {
      return;
    }

    state = List.unmodifiable([
      ...state,
      attachment,
    ]);
  }
}

final documentUploadProvider = StateNotifierProvider<
    DocumentUploadNotifier,
    List<DocumentAttachment>>(
  (ref) => DocumentUploadNotifier(),
);