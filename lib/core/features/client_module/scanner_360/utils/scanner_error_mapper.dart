import 'dart:io';

/// Converts low-level exceptions raised by installed dependencies
/// into short, user-facing strings.
///
/// Per spec section 18, raw technical exceptions must never reach
/// users. Every service should route its exception through this
/// mapper before surfacing an error message.
class ScannerErrorMapper {
  ScannerErrorMapper._();

  // ============================================================
  // Fixed user-facing messages
  // ============================================================

  static const String cameraUnavailable =
      'Camera is not available on this device.';
  static const String cameraPermissionDenied =
      'Camera permission was denied. Please allow camera access to scan documents.';
  static const String storagePermissionDenied =
      'Storage permission was denied. Please allow file access to save documents.';
  static const String captureFailed =
      'Failed to capture the image. Please try again.';
  static const String invalidImage =
      'The selected file is not a valid image.';
  static const String imageProcessingFailed =
      'Failed to process the image.';
  static const String ocrFailed =
      'Failed to extract text from the document.';
  static const String pdfGenerationFailed =
      'Failed to create the PDF.';
  static const String storageFailed =
      'Failed to save or read the document.';
  static const String sharingFailed =
      'Failed to share the document.';
  static const String printingFailed =
      'Failed to print the document.';
  static const String unsupportedFormat =
      'This file format is not supported.';
  static const String insufficientMemory =
      'Not enough memory to complete this operation.';
  static const String operationCancelled =
      'Operation was cancelled.';
  static const String unknownError =
      'Something went wrong. Please try again.';

  // ============================================================
  // Mapping
  // ============================================================

  /// Maps [error] to a user-facing message.
  ///
  /// [fallback] overrides the generic message returned when [error]
  /// is not recognised.
  static String map(
    Object error, {
    String fallback = unknownError,
  }) {
    if (error is FileSystemException) {
      return storageFailed;
    }
    if (error is FormatException) {
      return invalidImage;
    }
    if (error is UnsupportedError) {
      return unsupportedFormat;
    }
    if (error is OutOfMemoryError) {
      return insufficientMemory;
    }
    return fallback;
  }
}