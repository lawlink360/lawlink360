import 'dart:io';

import 'package:pdf/pdf.dart';

/// Scanner 360 constants that are not already covered by the
/// existing LawLink360 theme system (AppColors, AppSpacing,
/// AppRadius, AppTextStyles).
///
/// No colors, spacing, radius, or typography values belong here.
class ScannerConstants {
  ScannerConstants._();

  // ============================================================
  // Storage layout
  // ============================================================

  /// Root folder name inside the application documents directory.
  static const String scannerRootFolder = 'scanner_360';

  /// Sub-folder for page images inside the scanner root.
  static const String pagesFolder = 'pages';

  /// Sub-folder for thumbnails inside the scanner root.
  static const String thumbnailsFolder = 'thumbnails';

  /// Sub-folder for generated PDFs inside the scanner root.
  static const String pdfsFolder = 'pdfs';

  /// Prefix for page image files.
  static const String pageFilePrefix = 'page_';

  /// Prefix for thumbnail image files.
  static const String thumbnailFilePrefix = 'thumb_';

  /// Prefix for PDF files.
  static const String pdfFilePrefix = 'doc_';

  /// Key inside shared_preferences where the scanner document
  /// index is stored.
  static const String documentIndexKey = 'scanner_360_documents_index_v1';

  // ------------------------------------------------------------
  // Session / document ownership layout (Phase 9)
  // ------------------------------------------------------------
  //
  // The constants below name the directories used by the new
  // session-scoped and document-scoped ownership model.
  //
  // They are additive. No existing path is migrated or renamed
  // by the presence of these constants.

  /// Sub-folder holding per-session working directories.
  static const String sessionsFolder = 'sessions';

  /// Sub-folder holding per-document owned directories.
  static const String documentsFolder = 'documents';

  /// Sub-folder inside a session directory holding raw camera
  /// captures before processing.
  static const String capturesFolder = 'captures';

  /// Folder name for page images inside a session directory.
  static const String sessionPagesFolder = 'pages';

  /// Folder name for page images inside a document directory.
  static const String documentPagesFolder = 'pages';

  /// Folder name for thumbnails inside a document directory.
  static const String documentThumbnailsFolder = 'thumbnails';

  /// File name for the PDF inside a document directory.
  static const String documentPdfFileName = 'document.pdf';

  // ============================================================
  // Image / output defaults
  // ============================================================

  /// Default JPEG/PNG quality for exported page images (0-100).
  static const int defaultImageQuality = 90;

  /// Maximum width or height, in pixels, for generated thumbnails.
  static const int thumbnailMaxDimension = 240;

  /// Default PDF page format.
  static PdfPageFormat get defaultPdfPageFormat => PdfPageFormat.a4;

  // ============================================================
  // Document naming
  // ============================================================

  /// Fallback document title when no better name can be produced.
  static const String defaultDocumentTitle = 'Scanned Document';

  // ============================================================
  // Camera
  // ============================================================

  /// Default JPEG compression for captured images.
  static const int cameraJpegQuality = 92;

  // ============================================================
  // File extensions
  // ============================================================

  static const String jpgExtension = '.jpg';
  static const String pngExtension = '.png';
  static const String pdfExtension = '.pdf';

  // ============================================================
  // Unsupported detection error message
  // ============================================================

  /// Fixed message used by ScannerDocumentDetectionService when
  /// automatic document detection is requested. The installed
  /// dependency set does not include any automatic document
  /// boundary or corner detection engine.
  static const String detectionUnsupportedMessage =
      'Automatic document boundary/corner detection is not '
      'available. The currently installed dependencies '
      '(flutter_box_transform, crop_your_image) provide manual '
      'transformation and cropping UIs, not automatic detection.';

  // ============================================================
  // Convenience
  // ============================================================

  /// Returns the page extension used for saved page images.
  static String get pageImageExtension => jpgExtension;

  /// Marker so callers do not need to import dart:io just for
  /// the separator. Uses File.separator at runtime.
  static String get pathSeparator => Platform.pathSeparator;
}