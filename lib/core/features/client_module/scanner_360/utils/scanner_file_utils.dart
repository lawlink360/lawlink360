import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../constants/scanner_constants.dart';

/// Path manipulation helpers for Scanner 360.
///
/// Pure functions only; no I/O side effects except where explicitly
/// documented (ensureDirectory, ensureAllScannerDirectories,
/// ensureSessionDirectories, ensureDocumentDirectories,
/// deleteIfExists).
class ScannerFileUtils {
  ScannerFileUtils._();

  // ============================================================
  // Root directories
  // ============================================================

  /// Root folder for all Scanner 360 files.
  static Future<Directory> scannerRoot() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(
      '${base.path}${Platform.pathSeparator}'
      '${ScannerConstants.scannerRootFolder}',
    );
    return dir;
  }

  /// Folder for page images.
  static Future<Directory> pagesDir() async {
    final root = await scannerRoot();
    return Directory(
      '${root.path}${Platform.pathSeparator}'
      '${ScannerConstants.pagesFolder}',
    );
  }

  /// Folder for thumbnails.
  static Future<Directory> thumbnailsDir() async {
    final root = await scannerRoot();
    return Directory(
      '${root.path}${Platform.pathSeparator}'
      '${ScannerConstants.thumbnailsFolder}',
    );
  }

  /// Folder for PDFs.
  static Future<Directory> pdfsDir() async {
    final root = await scannerRoot();
    return Directory(
      '${root.path}${Platform.pathSeparator}'
      '${ScannerConstants.pdfsFolder}',
    );
  }

  // ============================================================
  // Session / document ownership directories (Phase 9)
  // ============================================================
  //
  // These helpers describe the new ownership layout. They are
  // additive. No existing caller is migrated to them in this
  // batch, and no directory is created unless a caller explicitly
  // invokes one of the ensure* helpers below.

  /// Root folder for all per-session working directories.
  static Future<Directory> sessionsDir() async {
    final root = await scannerRoot();
    return Directory(
      '${root.path}${Platform.pathSeparator}'
      '${ScannerConstants.sessionsFolder}',
    );
  }

  /// Folder for a single session.
  static Future<Directory> sessionDir(String sessionId) async {
    final base = await sessionsDir();
    return Directory(
      '${base.path}${Platform.pathSeparator}$sessionId',
    );
  }

  /// Folder for raw camera captures inside a session.
  static Future<Directory> sessionCapturesDir(String sessionId) async {
    final base = await sessionDir(sessionId);
    return Directory(
      '${base.path}${Platform.pathSeparator}'
      '${ScannerConstants.capturesFolder}',
    );
  }

  /// Folder for processed page images inside a session.
  static Future<Directory> sessionPagesDir(String sessionId) async {
    final base = await sessionDir(sessionId);
    return Directory(
      '${base.path}${Platform.pathSeparator}'
      '${ScannerConstants.sessionPagesFolder}',
    );
  }

  /// Root folder for all per-document owned directories.
  static Future<Directory> documentsDir() async {
    final root = await scannerRoot();
    return Directory(
      '${root.path}${Platform.pathSeparator}'
      '${ScannerConstants.documentsFolder}',
    );
  }

  /// Folder for a single document.
  static Future<Directory> documentDir(String documentId) async {
    final base = await documentsDir();
    return Directory(
      '${base.path}${Platform.pathSeparator}$documentId',
    );
  }

  /// Folder for page images owned by a document.
  static Future<Directory> documentPagesDir(String documentId) async {
    final base = await documentDir(documentId);
    return Directory(
      '${base.path}${Platform.pathSeparator}'
      '${ScannerConstants.documentPagesFolder}',
    );
  }

  /// Folder for thumbnails owned by a document.
  static Future<Directory> documentThumbnailsDir(
    String documentId,
  ) async {
    final base = await documentDir(documentId);
    return Directory(
      '${base.path}${Platform.pathSeparator}'
      '${ScannerConstants.documentThumbnailsFolder}',
    );
  }

  // ============================================================
  // Ensure
  // ============================================================

  /// Creates [dir] recursively if it does not exist.
  static Future<void> ensureDirectory(Directory dir) async {
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  /// Creates all scanner sub-directories.
  ///
  /// This remains the legacy root setup and is intentionally
  /// unchanged. Session/document directories are not created here.
  static Future<void> ensureAllScannerDirectories() async {
    await ensureDirectory(await pagesDir());
    await ensureDirectory(await thumbnailsDir());
    await ensureDirectory(await pdfsDir());
  }

  /// Creates the session directory tree for [sessionId].
  ///
  /// Callers must invoke this explicitly; nothing in Batch 9.1
  /// calls it automatically.
  static Future<void> ensureSessionDirectories(
    String sessionId,
  ) async {
    await ensureDirectory(await sessionCapturesDir(sessionId));
    await ensureDirectory(await sessionPagesDir(sessionId));
  }

  /// Creates the document directory tree for [documentId].
  ///
  /// Callers must invoke this explicitly; nothing in Batch 9.1
  /// calls it automatically.
  static Future<void> ensureDocumentDirectories(
    String documentId,
  ) async {
    await ensureDirectory(await documentPagesDir(documentId));
    await ensureDirectory(await documentThumbnailsDir(documentId));
  }

  // ============================================================
  // Path building
  // ============================================================

  /// Builds a page image path for [pageId].
  static Future<String> buildPageImagePath(
    String pageId, {
    String extension = ScannerConstants.jpgExtension,
  }) async {
    final dir = await pagesDir();
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.pageFilePrefix}$pageId$extension';
  }

  /// Builds a thumbnail path for [pageId].
  static Future<String> buildThumbnailPath(
    String pageId, {
    String extension = ScannerConstants.jpgExtension,
  }) async {
    final dir = await thumbnailsDir();
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.thumbnailFilePrefix}$pageId$extension';
  }

  /// Builds a PDF path for [documentId].
  static Future<String> buildPdfPath(String documentId) async {
    final dir = await pdfsDir();
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.pdfFilePrefix}$documentId'
        '${ScannerConstants.pdfExtension}';
  }

  /// Builds a page image path inside a session directory.
  static Future<String> buildSessionPagePath(
    String sessionId,
    String pageId, {
    String extension = ScannerConstants.jpgExtension,
  }) async {
    final dir = await sessionPagesDir(sessionId);
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.pageFilePrefix}$pageId$extension';
  }

  /// Builds a page image path inside a document directory.
  static Future<String> buildDocumentPagePath(
    String documentId,
    String pageId, {
    String extension = ScannerConstants.jpgExtension,
  }) async {
    final dir = await documentPagesDir(documentId);
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.pageFilePrefix}$pageId$extension';
  }

  /// Builds a thumbnail path inside a document directory.
  static Future<String> buildDocumentThumbnailPath(
    String documentId,
    String pageId, {
    String extension = ScannerConstants.jpgExtension,
  }) async {
    final dir = await documentThumbnailsDir(documentId);
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.thumbnailFilePrefix}$pageId$extension';
  }

  /// Builds the PDF path inside a document directory.
  static Future<String> buildDocumentPdfPath(
    String documentId,
  ) async {
    final dir = await documentDir(documentId);
    return '${dir.path}${Platform.pathSeparator}'
        '${ScannerConstants.documentPdfFileName}';
  }

  // ============================================================
  // Delete
  // ============================================================

  /// Deletes [path] if it exists. Silent if the file is missing.
  static Future<void> deleteIfExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Deletes every page image and thumbnail for [pageId].
  static Future<void> deletePageFiles(
    String pageId, {
    String? imagePath,
    String? thumbnailPath,
  }) async {
    if (imagePath != null) {
      await deleteIfExists(imagePath);
    }
    if (thumbnailPath != null) {
      await deleteIfExists(thumbnailPath);
    }
  }

  // ============================================================
  // Name sanitisation
  // ============================================================

  /// Removes characters that are illegal in file names.
  static String sanitizeFileName(String name) {
    final cleaned = name
        .trim()
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

    if (cleaned.isEmpty) {
      return ScannerConstants.defaultDocumentTitle;
    }
    return cleaned;
  }
}