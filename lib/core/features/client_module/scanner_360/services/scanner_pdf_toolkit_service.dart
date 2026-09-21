import 'dart:io';
import 'dart:ui';

import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Raised when a PDF toolkit operation fails.
class ScannerPdfToolkitException implements Exception {
  const ScannerPdfToolkitException(this.message);

  final String message;

  @override
  String toString() => 'ScannerPdfToolkitException: $message';
}

/// Scanner 360 rotation angles. Mapped internally to
/// Syncfusion's PdfPageRotateAngle.
enum PdfRotation {
  none,
  rotate90,
  rotate180,
  rotate270,
}

/// Scanner 360 permission flags. Mapped internally to
/// Syncfusion's PdfPermissionsFlags.
enum PdfPermission {
  print,
  editContent,
  copyContent,
  editAnnotations,
  fillFields,
  accessibilityCopyContent,
  assembleDocument,
  fullQualityPrint,
}

/// Scanner 360 compression levels. Mapped internally to
/// Syncfusion's PdfCompressionLevel.
enum PdfCompressionLevelChoice {
  none,
  bestSpeed,
  belowNormal,
  normal,
  aboveNormal,
  best,
}

/// Scanner 360 encryption algorithms. Mapped internally to
/// Syncfusion's PdfEncryptionAlgorithm.
enum PdfEncryptionAlgorithmChoice {
  rc4x40Bit,
  rc4x128Bit,
  aesx128Bit,
  aesx256Bit,
  aesx256BitRevision6,
}

/// Watermark and page-number position on a PDF page.
///
/// Nine positions covering the standard placements. For page
/// numbers, only the six edge positions are valid; the three
/// middle positions are rejected by
/// [ScannerPdfToolkitService.addPageNumbers].
enum PdfWatermarkPosition {
  center,
  topLeft,
  topCenter,
  topRight,
  middleLeft,
  middleRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// A reference to a single source page that will be reconstructed
/// into an output PDF.
class _SourcePageRef {
  const _SourcePageRef({
    required this.sourceDoc,
    required this.sourcePage,
  });

  final PdfDocument sourceDoc;
  final PdfPage sourcePage;
}

/// PDF toolkit for Scanner 360.
///
/// Provides page-manipulation operations on existing PDF files:
/// merge, split, extract, reorder, delete, rotate, compress,
/// protect, addWatermark, addPageNumbers.
///
/// The service does not retain PdfDocument instances beyond each
/// method call. Source and output documents are disposed before
/// each public method returns.
///
/// The page-reconstruction operations (merge, split, extract,
/// reorder, delete) build a new PDF from source page templates.
/// The native operations (rotate, compress, protect) modify the
/// loaded document in place, then write to the output path.
/// The decoration operations (addWatermark, addPageNumbers)
/// overlay content on the loaded document, then write to the
/// output path.
///
/// No operation modifies the source file at [inputPath].
class ScannerPdfToolkitService {
  const ScannerPdfToolkitService();

  // ============================================================
  // Merge
  // ============================================================

  /// Combines [inputPaths] into a single PDF at [outputPath],
  /// preserving the order of the input files and the order of
  /// each file's pages.
  Future<String> merge({
    required List<String> inputPaths,
    required String outputPath,
  }) async {
    if (inputPaths.isEmpty) {
      throw const ScannerPdfToolkitException(
        'merge requires at least one input PDF.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'merge requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final pageRefs = <_SourcePageRef>[];

      for (final path in inputPaths) {
        final doc = await _loadSource(path);
        sourceDocs.add(doc);
        final count = doc.pages.count;
        for (var i = 0; i < count; i++) {
          pageRefs.add(
            _SourcePageRef(sourceDoc: doc, sourcePage: doc.pages[i]),
          );
        }
      }

      await _writeReconstruction(
        pages: pageRefs,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Split
  // ============================================================

  /// Splits [inputPath] into multiple PDFs, one per range in
  /// [pageRanges], written to [outputPaths].
  ///
  /// [pageRanges] and [outputPaths] must have the same length.
  /// Ranges may overlap. Duplicate indexes within a range are
  /// allowed and produce duplicate output pages.
  Future<List<String>> split({
    required String inputPath,
    required List<List<int>> pageRanges,
    required List<String> outputPaths,
  }) async {
    if (pageRanges.isEmpty) {
      throw const ScannerPdfToolkitException(
        'split requires at least one page range.',
      );
    }
    if (pageRanges.length != outputPaths.length) {
      throw const ScannerPdfToolkitException(
        'split requires pageRanges and outputPaths to have the '
        'same length.',
      );
    }
    for (final path in outputPaths) {
      if (path.trim().isEmpty) {
        throw const ScannerPdfToolkitException(
          'split requires non-empty output paths.',
        );
      }
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      for (var i = 0; i < pageRanges.length; i++) {
        _validatePageIndexes(
          pageRanges[i],
          count,
          'split range $i',
        );
      }

      final outputs = <String>[];
      for (var i = 0; i < pageRanges.length; i++) {
        final refs = pageRanges[i]
            .map(
              (index) => _SourcePageRef(
                sourceDoc: sourceDoc,
                sourcePage: sourceDoc.pages[index],
              ),
            )
            .toList(growable: false);

        await _writeReconstruction(
          pages: refs,
          outputPath: outputPaths[i],
        );

        outputs.add(outputPaths[i]);
      }

      return outputs;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Extract pages
  // ============================================================

  /// Extracts the pages at [pageIndexes] from [inputPath], in the
  /// given order, into a new PDF at [outputPath].
  ///
  /// Duplicate indexes are allowed.
  Future<String> extractPages({
    required String inputPath,
    required List<int> pageIndexes,
    required String outputPath,
  }) async {
    if (pageIndexes.isEmpty) {
      throw const ScannerPdfToolkitException(
        'extractPages requires at least one page index.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'extractPages requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      _validatePageIndexes(pageIndexes, count, 'extractPages');

      final refs = pageIndexes
          .map(
            (index) => _SourcePageRef(
              sourceDoc: sourceDoc,
              sourcePage: sourceDoc.pages[index],
            ),
          )
          .toList(growable: false);

      await _writeReconstruction(
        pages: refs,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Reorder pages
  // ============================================================

  /// Produces a new PDF at [outputPath] containing every page of
  /// [inputPath] in the order given by [newOrder].
  ///
  /// [newOrder] must be a permutation of `0..pageCount - 1`.
  Future<String> reorderPages({
    required String inputPath,
    required List<int> newOrder,
    required String outputPath,
  }) async {
    if (newOrder.isEmpty) {
      throw const ScannerPdfToolkitException(
        'reorderPages requires a non-empty newOrder.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'reorderPages requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      _validateNewOrder(newOrder, count);

      final refs = newOrder
          .map(
            (index) => _SourcePageRef(
              sourceDoc: sourceDoc,
              sourcePage: sourceDoc.pages[index],
            ),
          )
          .toList(growable: false);

      await _writeReconstruction(
        pages: refs,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Delete pages
  // ============================================================

  /// Produces a new PDF at [outputPath] containing every page of
  /// [inputPath] except those at [pageIndexes], preserving the
  /// original order.
  Future<String> deletePages({
    required String inputPath,
    required List<int> pageIndexes,
    required String outputPath,
  }) async {
    if (pageIndexes.isEmpty) {
      throw const ScannerPdfToolkitException(
        'deletePages requires at least one page index.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'deletePages requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      _validatePageIndexes(pageIndexes, count, 'deletePages');

      if (pageIndexes.length >= count) {
        throw const ScannerPdfToolkitException(
          'deletePages cannot delete every page.',
        );
      }

      final toDelete = pageIndexes.toSet();
      final refs = <_SourcePageRef>[];
      for (var i = 0; i < count; i++) {
        if (toDelete.contains(i)) continue;
        refs.add(
          _SourcePageRef(
            sourceDoc: sourceDoc,
            sourcePage: sourceDoc.pages[i],
          ),
        );
      }

      await _writeReconstruction(
        pages: refs,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Rotate
  // ============================================================

  /// Rotates the pages of [inputPath] whose indexes appear in
  /// [rotations] by the specified angles, producing a new PDF at
  /// [outputPath].
  ///
  /// Pages not present in [rotations] retain their current
  /// rotation.
  ///
  /// [inputPath] is not modified.
  Future<String> rotate({
    required String inputPath,
    required Map<int, PdfRotation> rotations,
    required String outputPath,
  }) async {
    if (rotations.isEmpty) {
      throw const ScannerPdfToolkitException(
        'rotate requires at least one page rotation.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'rotate requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      for (final index in rotations.keys) {
        if (index < 0 || index >= count) {
          throw ScannerPdfToolkitException(
            'rotate: page index $index is out of range '
            '(0..${count - 1}).',
          );
        }
      }

      for (final entry in rotations.entries) {
        final page = sourceDoc.pages[entry.key];
        page.rotation = _mapRotation(entry.value);
      }

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Compress
  // ============================================================

  /// Produces a re-saved copy of [inputPath] at [outputPath] using
  /// the specified compression [level]. When [level] is null, uses
  /// the strongest compression level.
  ///
  /// [inputPath] is not modified.
  Future<String> compress({
    required String inputPath,
    required String outputPath,
    PdfCompressionLevelChoice? level,
  }) async {
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'compress requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);

      sourceDoc.compressionLevel = _mapCompressionLevel(
        level ?? PdfCompressionLevelChoice.best,
      );

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Protect
  // ============================================================

  /// Encrypts [inputPath] into a new PDF at [outputPath].
  ///
  /// [userPassword] is required to open the document.
  /// [ownerPassword] is required to change permissions.
  ///
  /// When [algorithm] is null, uses Syncfusion's default algorithm
  /// (rc4x128Bit).
  ///
  /// When [permissions] is null, uses Syncfusion's default
  /// permission set. When provided, the listed permissions are
  /// added to the security object.
  ///
  /// [inputPath] is not modified.
  Future<String> protect({
    required String inputPath,
    required String outputPath,
    required String userPassword,
    required String ownerPassword,
    PdfEncryptionAlgorithmChoice? algorithm,
    List<PdfPermission>? permissions,
  }) async {
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'protect requires a non-empty outputPath.',
      );
    }
    if (userPassword.isEmpty) {
      throw const ScannerPdfToolkitException(
        'protect requires a non-empty userPassword.',
      );
    }
    if (ownerPassword.isEmpty) {
      throw const ScannerPdfToolkitException(
        'protect requires a non-empty ownerPassword.',
      );
    }
    if (permissions != null && permissions.isEmpty) {
      throw const ScannerPdfToolkitException(
        'protect: permissions list must not be empty when provided.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);

      final security = sourceDoc.security;
      security.algorithm = _mapEncryptionAlgorithm(
        algorithm ?? PdfEncryptionAlgorithmChoice.rc4x128Bit,
      );
      security.userPassword = userPassword;
      security.ownerPassword = ownerPassword;

      if (permissions != null) {
        for (final permission in permissions) {
          security.permissions.add(_mapPermission(permission));
        }
      }

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Add watermark
  // ============================================================

  /// Draws [text] as a semi-transparent watermark on every page of
  /// [inputPath] and writes the result to [outputPath].
  ///
  /// [inputPath] is not modified.
  ///
  /// [position] determines where the watermark is anchored.
  /// [fontSize] is in PDF points. [opacity] must be in `[0, 1]`.
  /// [rotationDegrees] rotates the watermark clockwise around its
  /// anchor point.
  ///
  /// When [red], [green], and [blue] are all provided, they must
  /// each be in `[0, 255]` and are used as the text color.
  /// Otherwise a default mid-grey is used.
  Future<String> addWatermark({
    required String inputPath,
    required String outputPath,
    required String text,
    PdfWatermarkPosition position = PdfWatermarkPosition.center,
    double fontSize = 48,
    double opacity = 0.3,
    double rotationDegrees = 45,
    int? red,
    int? green,
    int? blue,
  }) async {
    if (text.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'addWatermark requires non-empty text.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'addWatermark requires a non-empty outputPath.',
      );
    }
    if (fontSize <= 0) {
      throw const ScannerPdfToolkitException(
        'addWatermark requires fontSize > 0.',
      );
    }
    if (opacity < 0 || opacity > 1) {
      throw const ScannerPdfToolkitException(
        'addWatermark requires opacity in [0, 1].',
      );
    }
    if (!rotationDegrees.isFinite) {
      throw const ScannerPdfToolkitException(
        'addWatermark requires finite rotationDegrees.',
      );
    }

    final color = _resolveWatermarkColor(red, green, blue);

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      if (count == 0) {
        throw const ScannerPdfToolkitException(
          'addWatermark requires a PDF with at least one page.',
        );
      }

      final font = PdfStandardFont(
        PdfFontFamily.timesRoman,
        fontSize,
      );
      final brush = PdfSolidBrush(color);
      final format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      );

      for (var i = 0; i < count; i++) {
        final page = sourceDoc.pages[i];
        final pageSize = page.size;
        final origin = _watermarkOrigin(
          position: position,
          pageSize: pageSize,
        );

        final graphics = page.graphics;
        graphics.save();
        graphics.setTransparency(opacity);
        graphics.translateTransform(origin.x, origin.y);
        graphics.rotateTransform(rotationDegrees);

        final bounds = Rect.fromLTWH(
          -pageSize.width / 2,
          -fontSize,
          pageSize.width,
          fontSize * 2,
        );

        graphics.drawString(
          text,
          font,
          brush: brush,
          bounds: bounds,
          format: format,
        );

        graphics.restore();
      }

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Add page numbers
  // ============================================================

  /// Adds automatic page numbers to every page of [inputPath]
  /// and writes the result to [outputPath].
  ///
  /// [format] must contain `{0}`, which is replaced by the current
  /// page number. The default is `'Page {0}'`.
  ///
  /// [inputPath] is not modified.
  ///
  /// [position] must be one of the six edge positions
  /// (`topLeft`, `topCenter`, `topRight`, `bottomLeft`,
  /// `bottomCenter`, `bottomRight`). The three middle positions
  /// are rejected.
  ///
  /// The footer (or header) template is sized to the first page's
  /// width and applied uniformly to the document. Per-page sizing
  /// is not supported in this method.
  Future<String> addPageNumbers({
    required String inputPath,
    required String outputPath,
    String format = 'Page {0}',
    double fontSize = 10,
    double margin = 24,
    PdfWatermarkPosition position = PdfWatermarkPosition.bottomCenter,
  }) async {
    if (format.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'addPageNumbers requires non-empty format.',
      );
    }
    if (!format.contains('{0}')) {
      throw const ScannerPdfToolkitException(
        'addPageNumbers format must contain {0} for the page number.',
      );
    }
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'addPageNumbers requires a non-empty outputPath.',
      );
    }
    if (fontSize <= 0) {
      throw const ScannerPdfToolkitException(
        'addPageNumbers requires fontSize > 0.',
      );
    }
    if (margin < 0) {
      throw const ScannerPdfToolkitException(
        'addPageNumbers requires margin >= 0.',
      );
    }

    _validatePageNumberPosition(position);

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);
      final count = sourceDoc.pages.count;

      if (count == 0) {
        throw const ScannerPdfToolkitException(
          'addPageNumbers requires a PDF with at least one page.',
        );
      }

      final firstPageSize = sourceDoc.pages[0].size;
      final stripHeight = fontSize * 3;

      final font = PdfStandardFont(
        PdfFontFamily.timesRoman,
        fontSize,
      );
      final brush = PdfSolidBrush(_defaultWatermarkColor());

      final pageNumberField = PdfPageNumberField(
        font: font,
        brush: brush,
      );

      final compositeField = PdfCompositeField(
        font: font,
        brush: brush,
        text: format,
        fields: <PdfAutomaticField>[pageNumberField],
      );

      final stripBounds = _pageNumberStripBounds(
        position: position,
        pageSize: firstPageSize,
        stripHeight: stripHeight,
        margin: margin,
      );

      final template = PdfPageTemplateElement(stripBounds);
      compositeField.bounds = template.bounds;

      final drawOffset = _compositeDrawOffset(
        position: position,
        stripBounds: stripBounds,
        stripHeight: stripHeight,
        fontSize: fontSize,
      );

      compositeField.draw(template.graphics, drawOffset);

      if (_isTopPosition(position)) {
        sourceDoc.template.top = template;
      } else {
        sourceDoc.template.bottom = template;
      }

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Update metadata
  // ============================================================

  /// Copies [inputPath] to [outputPath] with the supplied
  /// document-information fields applied.
  ///
  /// All six fields are optional. A null field is left unchanged
  /// in the output document. A non-null field is written to the
  /// output document's document-information dictionary.
  ///
  /// [keywords] is written as a single String value, preserving
  /// whatever representation the caller supplies. No parsing,
  /// splitting, or joining is performed.
  ///
  /// [inputPath] is not modified. The source bytes are read, a
  /// new PdfDocument is loaded from them, the requested fields
  /// are set, and the result is saved to [outputPath].
  Future<String> updateMetadata({
    required String inputPath,
    required String outputPath,
    String? title,
    String? author,
    String? subject,
    String? keywords,
    String? creator,
    String? producer,
  }) async {
    if (outputPath.trim().isEmpty) {
      throw const ScannerPdfToolkitException(
        'updateMetadata requires a non-empty outputPath.',
      );
    }

    final sourceDocs = <PdfDocument>[];
    try {
      final sourceDoc = await _loadSource(inputPath);
      sourceDocs.add(sourceDoc);

      final info = sourceDoc.documentInformation;
      if (title != null) info.title = title;
      if (author != null) info.author = author;
      if (subject != null) info.subject = subject;
      if (keywords != null) info.keywords = keywords;
      if (creator != null) info.creator = creator;
      if (producer != null) info.producer = producer;

      await _writeModifiedDocument(
        document: sourceDoc,
        outputPath: outputPath,
      );

      return outputPath;
    } finally {
      _disposeAll(sourceDocs);
    }
  }

  // ============================================================
  // Internal helpers — loading and writing
  // ============================================================

  Future<PdfDocument> _loadSource(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw ScannerPdfToolkitException(
        'Source PDF does not exist: $path',
      );
    }

    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      throw ScannerPdfToolkitException(
        'Source PDF is empty: $path',
      );
    }

    try {
      return PdfDocument(inputBytes: bytes);
    } catch (e) {
      throw ScannerPdfToolkitException(
        'Failed to load PDF: $path. $e',
      );
    }
  }

  /// Reconstructs [pages] into a new PDF at [outputPath].
  ///
  /// Each output page preserves the size of its source page and
  /// uses Syncfusion's per-section page-settings mechanism.
  Future<void> _writeReconstruction({
    required List<_SourcePageRef> pages,
    required String outputPath,
  }) async {
    if (pages.isEmpty) {
      throw const ScannerPdfToolkitException(
        'Cannot produce a PDF with zero pages.',
      );
    }

    final outputDoc = PdfDocument();

    try {
      for (final ref in pages) {
        final template = ref.sourcePage.createTemplate();
        final size = ref.sourcePage.size;

        final section = outputDoc.sections!.add();
        section.pageSettings = PdfPageSettings(size);
        final outputPage = section.pages.add();

        outputPage.graphics.drawPdfTemplate(
          template,
          Offset.zero,
          size,
        );
      }

      final bytes = await outputDoc.save();

      final outFile = File(outputPath);
      await outFile.parent.create(recursive: true);
      await outFile.writeAsBytes(bytes, flush: true);
    } finally {
      outputDoc.dispose();
    }
  }

  /// Saves [document] to [outputPath].
  ///
  /// The document must already have been modified as required by
  /// the caller. Does not dispose the document.
  Future<void> _writeModifiedDocument({
    required PdfDocument document,
    required String outputPath,
  }) async {
    final bytes = await document.save();

    final outFile = File(outputPath);
    await outFile.parent.create(recursive: true);
    await outFile.writeAsBytes(bytes, flush: true);
  }

  // ============================================================
  // Internal helpers — enum mapping
  // ============================================================

  PdfPageRotateAngle _mapRotation(PdfRotation rotation) {
    switch (rotation) {
      case PdfRotation.none:
        return PdfPageRotateAngle.rotateAngle0;
      case PdfRotation.rotate90:
        return PdfPageRotateAngle.rotateAngle90;
      case PdfRotation.rotate180:
        return PdfPageRotateAngle.rotateAngle180;
      case PdfRotation.rotate270:
        return PdfPageRotateAngle.rotateAngle270;
    }
  }

  PdfPermissionsFlags _mapPermission(PdfPermission permission) {
    switch (permission) {
      case PdfPermission.print:
        return PdfPermissionsFlags.print;
      case PdfPermission.editContent:
        return PdfPermissionsFlags.editContent;
      case PdfPermission.copyContent:
        return PdfPermissionsFlags.copyContent;
      case PdfPermission.editAnnotations:
        return PdfPermissionsFlags.editAnnotations;
      case PdfPermission.fillFields:
        return PdfPermissionsFlags.fillFields;
      case PdfPermission.accessibilityCopyContent:
        return PdfPermissionsFlags.accessibilityCopyContent;
      case PdfPermission.assembleDocument:
        return PdfPermissionsFlags.assembleDocument;
      case PdfPermission.fullQualityPrint:
        return PdfPermissionsFlags.fullQualityPrint;
    }
  }

  PdfCompressionLevel _mapCompressionLevel(
    PdfCompressionLevelChoice level,
  ) {
    switch (level) {
      case PdfCompressionLevelChoice.none:
        return PdfCompressionLevel.none;
      case PdfCompressionLevelChoice.bestSpeed:
        return PdfCompressionLevel.bestSpeed;
      case PdfCompressionLevelChoice.belowNormal:
        return PdfCompressionLevel.belowNormal;
      case PdfCompressionLevelChoice.normal:
        return PdfCompressionLevel.normal;
      case PdfCompressionLevelChoice.aboveNormal:
        return PdfCompressionLevel.aboveNormal;
      case PdfCompressionLevelChoice.best:
        return PdfCompressionLevel.best;
    }
  }

  PdfEncryptionAlgorithm _mapEncryptionAlgorithm(
    PdfEncryptionAlgorithmChoice choice,
  ) {
    switch (choice) {
      case PdfEncryptionAlgorithmChoice.rc4x40Bit:
        return PdfEncryptionAlgorithm.rc4x40Bit;
      case PdfEncryptionAlgorithmChoice.rc4x128Bit:
        return PdfEncryptionAlgorithm.rc4x128Bit;
      case PdfEncryptionAlgorithmChoice.aesx128Bit:
        return PdfEncryptionAlgorithm.aesx128Bit;
      case PdfEncryptionAlgorithmChoice.aesx256Bit:
        return PdfEncryptionAlgorithm.aesx256Bit;
      case PdfEncryptionAlgorithmChoice.aesx256BitRevision6:
        return PdfEncryptionAlgorithm.aesx256BitRevision6;
    }
  }

  ({double x, double y}) _watermarkOrigin({
    required PdfWatermarkPosition position,
    required Size pageSize,
  }) {
    final halfW = pageSize.width / 2;
    final halfH = pageSize.height / 2;
    const edgeInset = 0.0;

    switch (position) {
      case PdfWatermarkPosition.center:
        return (x: halfW, y: halfH);
      case PdfWatermarkPosition.topLeft:
        return (x: edgeInset, y: edgeInset);
      case PdfWatermarkPosition.topCenter:
        return (x: halfW, y: edgeInset);
      case PdfWatermarkPosition.topRight:
        return (x: pageSize.width, y: edgeInset);
      case PdfWatermarkPosition.middleLeft:
        return (x: edgeInset, y: halfH);
      case PdfWatermarkPosition.middleRight:
        return (x: pageSize.width, y: halfH);
      case PdfWatermarkPosition.bottomLeft:
        return (x: edgeInset, y: pageSize.height);
      case PdfWatermarkPosition.bottomCenter:
        return (x: halfW, y: pageSize.height);
      case PdfWatermarkPosition.bottomRight:
        return (x: pageSize.width, y: pageSize.height);
    }
  }

  // ============================================================
  // Internal helpers — validation
  // ============================================================

  void _validatePageIndexes(
    List<int> indexes,
    int pageCount,
    String label,
  ) {
    for (final index in indexes) {
      if (index < 0 || index >= pageCount) {
        throw ScannerPdfToolkitException(
          '$label: page index $index is out of range '
          '(0..${pageCount - 1}).',
        );
      }
    }
  }

  void _validateNewOrder(List<int> order, int pageCount) {
    if (order.length != pageCount) {
      throw ScannerPdfToolkitException(
        'reorderPages: newOrder length ${order.length} does not '
        'match page count $pageCount.',
      );
    }

    final seen = <int>{};
    for (final value in order) {
      if (value < 0 || value >= pageCount) {
        throw ScannerPdfToolkitException(
          'reorderPages: page index $value is out of range '
          '(0..${pageCount - 1}).',
        );
      }
      if (!seen.add(value)) {
        throw ScannerPdfToolkitException(
          'reorderPages: page index $value is duplicated. '
          'newOrder must be a permutation of 0..${pageCount - 1}.',
        );
      }
    }
  }

  void _validateWatermarkColor(int? red, int? green, int? blue) {
    final provided = <int?>[red, green, blue];
    final count = provided.where((v) => v != null).length;

    if (count == 0) return;
    if (count != 3) {
      throw const ScannerPdfToolkitException(
        'addWatermark: red, green and blue must all be provided '
        'or all omitted.',
      );
    }

    for (final value in provided) {
      if (value! < 0 || value > 255) {
        throw const ScannerPdfToolkitException(
          'addWatermark: RGB values must each be in [0, 255].',
        );
      }
    }
  }

  PdfColor _resolveWatermarkColor(int? red, int? green, int? blue) {
    _validateWatermarkColor(red, green, blue);
    if (red == null) {
      return _defaultWatermarkColor();
    }
    return PdfColor(red, green!, blue!);
  }

  PdfColor _defaultWatermarkColor() {
    return PdfColor(160, 160, 160);
  }

  void _validatePageNumberPosition(PdfWatermarkPosition position) {
    switch (position) {
      case PdfWatermarkPosition.topLeft:
      case PdfWatermarkPosition.topCenter:
      case PdfWatermarkPosition.topRight:
      case PdfWatermarkPosition.bottomLeft:
      case PdfWatermarkPosition.bottomCenter:
      case PdfWatermarkPosition.bottomRight:
        return;
      case PdfWatermarkPosition.center:
      case PdfWatermarkPosition.middleLeft:
      case PdfWatermarkPosition.middleRight:
        throw ScannerPdfToolkitException(
          'addPageNumbers: position ${position.name} is not valid '
          'for page numbers. Use a top or bottom edge position.',
        );
    }
  }

  bool _isTopPosition(PdfWatermarkPosition position) {
    switch (position) {
      case PdfWatermarkPosition.topLeft:
      case PdfWatermarkPosition.topCenter:
      case PdfWatermarkPosition.topRight:
        return true;
      case PdfWatermarkPosition.center:
      case PdfWatermarkPosition.middleLeft:
      case PdfWatermarkPosition.middleRight:
      case PdfWatermarkPosition.bottomLeft:
      case PdfWatermarkPosition.bottomCenter:
      case PdfWatermarkPosition.bottomRight:
        return false;
    }
  }

  Rect _pageNumberStripBounds({
    required PdfWatermarkPosition position,
    required Size pageSize,
    required double stripHeight,
    required double margin,
  }) {
    switch (position) {
      case PdfWatermarkPosition.topLeft:
      case PdfWatermarkPosition.topCenter:
      case PdfWatermarkPosition.topRight:
        return Rect.fromLTWH(0, margin, pageSize.width, stripHeight);
      case PdfWatermarkPosition.bottomLeft:
      case PdfWatermarkPosition.bottomCenter:
      case PdfWatermarkPosition.bottomRight:
        return Rect.fromLTWH(
          0,
          pageSize.height - stripHeight - margin,
          pageSize.width,
          stripHeight,
        );
      case PdfWatermarkPosition.center:
      case PdfWatermarkPosition.middleLeft:
      case PdfWatermarkPosition.middleRight:
        throw ScannerPdfToolkitException(
          'addPageNumbers: position ${position.name} is not valid.',
        );
    }
  }

  Offset _compositeDrawOffset({
    required PdfWatermarkPosition position,
    required Rect stripBounds,
    required double stripHeight,
    required double fontSize,
  }) {
    final y = stripHeight - fontSize;

    switch (position) {
      case PdfWatermarkPosition.topLeft:
      case PdfWatermarkPosition.bottomLeft:
        return Offset(0, y);
      case PdfWatermarkPosition.topCenter:
      case PdfWatermarkPosition.bottomCenter:
        return Offset(stripBounds.width / 2, y);
      case PdfWatermarkPosition.topRight:
      case PdfWatermarkPosition.bottomRight:
        return Offset(stripBounds.width, y);
      case PdfWatermarkPosition.center:
      case PdfWatermarkPosition.middleLeft:
      case PdfWatermarkPosition.middleRight:
        throw ScannerPdfToolkitException(
          'addPageNumbers: position ${position.name} is not valid.',
        );
    }
  }

  // ============================================================
  // Internal helpers — disposal
  // ============================================================

  void _disposeAll(List<PdfDocument> docs) {
    for (final doc in docs) {
      doc.dispose();
    }
  }
}