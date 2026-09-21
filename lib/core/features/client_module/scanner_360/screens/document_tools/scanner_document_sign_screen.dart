import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';

/// Document Tools → Sign.
///
/// Phase 10D.6.5. Standalone document-tool operation. Accepts an
/// arbitrary PDF, captures a visual signature, burns it into a
/// selected page at a user-specified rectangle, and offers the
/// resulting PDF for sharing.
///
/// This is a **visual signature**, not a cryptographic digital
/// signature. No certificates, PKI, or validation are involved.
/// The signature is embedded as a raster image via
/// [PdfGraphics.drawImage].
///
/// Not connected to the scanner capture pipeline. Does not create
/// ScannerDocuments or ScannerPages, and does not touch scanner
/// storage, sessions, or repositories.
///
/// MVP scope: one signature, one page, one placement rectangle,
/// one output file.
class ScannerDocumentSignScreen extends ConsumerStatefulWidget {
  const ScannerDocumentSignScreen({super.key});

  @override
  ConsumerState<ScannerDocumentSignScreen> createState() =>
      _ScannerDocumentSignScreenState();
}

class _ScannerDocumentSignScreenState
    extends ConsumerState<ScannerDocumentSignScreen> {
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String? _pdfPath;
  int _pageCount = 0;
  int _selectedPageIndex = 0; // 0-based
  double _pageWidth = 0;
  double _pageHeight = 0;

  bool _hasDrawn = false;
  bool _isApplying = false;
  bool _isSharing = false;
  String? _errorMessage;
  String? _savedPdfPath;

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Sign'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPdfSelection(),
                  const SizedBox(height: AppSpacing.lg),
                  if (_pdfPath != null) ...[
                    _buildSignaturePadSection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildPlacementSection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildApplyButton(),
                  ],
                  if (_errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      _errorMessage!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                  if (_savedPdfPath != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    _buildSuccessSection(),
                  ],
                ],
              ),
            ),
            if (_isApplying)
              const ScannerLoadingOverlay(
                label: 'Applying signature…',
              ),
            if (_isSharing)
              const ScannerLoadingOverlay(
                label: 'Opening share sheet…',
              ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PDF selection
  // ------------------------------------------------------------

  Widget _buildPdfSelection() {
    final fileName = _pdfPath == null
        ? 'No PDF selected.'
        : _pdfPath!.split(Platform.pathSeparator).last;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PDF file',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            fileName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: (_isApplying || _isSharing) ? null : _pickPdf,
            icon: const Icon(Icons.folder_open_outlined),
            label: const Text('Select PDF'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size(
                double.infinity,
                AppSpacing.buttonHeight,
              ),
              side: const BorderSide(color: AppColors.lightBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Signature pad
  // ------------------------------------------------------------

  Widget _buildSignaturePadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your signature',
          style: AppTextStyles.title,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.lightBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: SfSignaturePad(
              key: _signaturePadKey,
              backgroundColor: Colors.transparent,
              strokeColor: AppColors.primary,
              minimumStrokeWidth: 2.0,
              maximumStrokeWidth: 4.0,
              onDrawEnd: () {
                if (!_hasDrawn) {
                  setState(() => _hasDrawn = true);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: (_isApplying || _isSharing)
                ? null
                : () {
                    _signaturePadKey.currentState?.clear();
                    setState(() => _hasDrawn = false);
                  },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear'),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Placement
  // ------------------------------------------------------------

  Widget _buildPlacementSection() {
    final pageEntries = <DropdownMenuItem<int>>[
      for (var i = 0; i < _pageCount; i++)
        DropdownMenuItem<int>(
          value: i,
          child: Text('Page ${i + 1}'),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Placement',
          style: AppTextStyles.title,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Page size: '
          '${_pageWidth.toStringAsFixed(0)} × '
          '${_pageHeight.toStringAsFixed(0)} points',
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.lightBorder),
          ),
          child: DropdownButton<int>(
            value: _selectedPageIndex,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: pageEntries,
            onChanged: (_isApplying || _isSharing)
                ? null
                : (value) {
                    if (value == null) return;
                    setState(() => _selectedPageIndex = value);
                    _refreshPlacementDefaults();
                  },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(child: _buildNumericField('X', _xController)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _buildNumericField('Y', _yController)),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(child: _buildNumericField('Width', _widthController)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _buildNumericField('Height', _heightController)),
          ],
        ),
      ],
    );
  }

  Widget _buildNumericField(
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          enabled: !(_isApplying || _isSharing),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          style: AppTextStyles.body,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lightSurface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.lightBorder),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Apply / success
  // ------------------------------------------------------------

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: (_isApplying || _isSharing) ? null : _apply,
        icon: const Icon(Icons.draw_outlined),
        label: const Text('Apply Signature'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signed PDF ready',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your signature has been added to the PDF.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: (_isApplying || _isSharing) ? null : _share,
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share Signed PDF'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                minimumSize: const Size(
                  double.infinity,
                  AppSpacing.buttonHeight,
                ),
                side: const BorderSide(color: AppColors.lightBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  Future<void> _pickPdf() async {
    setState(() => _errorMessage = null);

    List<String>? paths;
    try {
      paths = await _inputSelector.pick(
        context: context,
        ref: ref,
        allowMultiple: false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to open picker: $e';
      });
      return;
    }

    if (paths == null || paths.isEmpty) return;

    final selected = paths.first;

    // Load the PDF immediately to obtain the page count and the
    // first page dimensions, so we can populate sensible defaults.
    PdfDocument? doc;
    try {
      final bytes = await File(selected).readAsBytes();
      doc = PdfDocument(inputBytes: bytes);
      final pageCount = doc.pages.count;
      if (pageCount <= 0) {
        throw const _SignError('This PDF has no pages.');
      }
      final firstPage = doc.pages[0];
      final size = firstPage.size;
      final width = size.width.toDouble();
      final height = size.height.toDouble();

      if (!mounted) return;
      setState(() {
        _pdfPath = selected;
        _pageCount = pageCount;
        _selectedPageIndex = 0;
        _pageWidth = width;
        _pageHeight = height;
        _savedPdfPath = null;
        _hasDrawn = false;
      });
      _signaturePadKey.currentState?.clear();
      _refreshPlacementDefaults();
    } on _SignError catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      setState(() {
        _errorMessage = msg.toLowerCase().contains('password')
            ? 'This PDF is password protected and cannot be signed here.'
            : 'Unable to open this PDF.';
      });
    } finally {
      doc?.dispose();
    }
  }

  Future<void> _refreshPlacementDefaults() async {
    final path = _pdfPath;
    if (path == null) return;

    PdfDocument? doc;
    try {
      final bytes = await File(path).readAsBytes();
      doc = PdfDocument(inputBytes: bytes);
      if (_selectedPageIndex < 0 ||
          _selectedPageIndex >= doc.pages.count) {
        return;
      }
      final page = doc.pages[_selectedPageIndex];
      final size = page.size;
      final width = size.width.toDouble();
      final height = size.height.toDouble();

      final defaultWidth = width * 0.4;
      final defaultHeight = defaultWidth * 0.35;
      final defaultX = (width - defaultWidth) / 2;
      final defaultY = height * 0.15;

      if (!mounted) return;
      setState(() {
        _pageWidth = width;
        _pageHeight = height;
        _widthController.text = defaultWidth.toStringAsFixed(1);
        _heightController.text = defaultHeight.toStringAsFixed(1);
        _xController.text = defaultX.toStringAsFixed(1);
        _yController.text = defaultY.toStringAsFixed(1);
      });
    } catch (_) {
      // Silent: defaults are optional.
    } finally {
      doc?.dispose();
    }
  }

  Future<void> _apply() async {
    if (_isApplying) return;

    final pdfPath = _pdfPath;
    if (pdfPath == null) {
      setState(() => _errorMessage = 'Please select a PDF first.');
      return;
    }
    if (!_hasDrawn) {
      setState(() =>
          _errorMessage = 'Please draw your signature first.');
      return;
    }

    final x = double.tryParse(_xController.text.trim());
    final y = double.tryParse(_yController.text.trim());
    final w = double.tryParse(_widthController.text.trim());
    final h = double.tryParse(_heightController.text.trim());

    if (x == null || y == null || w == null || h == null) {
      setState(() =>
          _errorMessage = 'X, Y, Width and Height must be numbers.');
      return;
    }
    if (x < 0 || y < 0 || w <= 0 || h <= 0) {
      setState(() => _errorMessage =
          'X and Y must be non-negative, and Width and Height must be positive.');
      return;
    }
    if (x + w > _pageWidth || y + h > _pageHeight) {
      setState(() => _errorMessage =
          'Signature rectangle exceeds the page boundaries.');
      return;
    }

    setState(() {
      _isApplying = true;
      _errorMessage = null;
    });

    Uint8List? pngBytes;
    PdfDocument? doc;
    try {
      // 1. Export the signature to a PNG with a transparent
      //    background.
      final ui.Image? image =
          await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
      if (image == null) {
        throw const _SignError('Unable to capture the signature.');
      }
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (byteData == null) {
        throw const _SignError('Unable to capture the signature.');
      }
      pngBytes = byteData.buffer.asUint8List();

      // 2. Load the PDF and draw the signature.
      final pdfBytes = await File(pdfPath).readAsBytes();
      doc = PdfDocument(inputBytes: pdfBytes);

      if (_selectedPageIndex < 0 ||
          _selectedPageIndex >= doc.pages.count) {
        throw const _SignError('Selected page is out of range.');
      }

      final page = doc.pages[_selectedPageIndex];
      final bitmap = PdfBitmap(pngBytes);
      page.graphics.drawImage(
        bitmap,
        Rect.fromLTWH(x, y, w, h),
      );

      // 3. Save to a temporary file.
      final outputBytes = await doc.save();
      final outputPath = await _newOutputPath();

      try {
        await File(outputPath).writeAsBytes(
          Uint8List.fromList(outputBytes),
          flush: true,
        );
      } catch (_) {
        throw const _SignError(
          'Unable to create the signed PDF file.',
        );
      }

      if (!mounted) return;
      setState(() {
        _isApplying = false;
        _savedPdfPath = outputPath;
      });
    } on _SignError catch (e) {
      if (!mounted) return;
      setState(() {
        _isApplying = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isApplying = false;
        _errorMessage = 'Unable to save the signed PDF.';
      });
    } finally {
      doc?.dispose();
    }
  }

  Future<void> _share() async {
    if (_isSharing) return;

    final path = _savedPdfPath;
    if (path == null) return;

    setState(() {
      _isSharing = true;
      _errorMessage = null;
    });

    try {
      await Share.shareXFiles(
        [XFile(path)],
        subject: 'Signed PDF',
      );
      if (!mounted) return;
      setState(() => _isSharing = false);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSharing = false;
        _errorMessage = 'Unable to share the signed PDF.';
      });
    }
  }

  Future<String> _newOutputPath() async {
    final tempDir = Directory.systemTemp;
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final dir = Directory(
      '${tempDir.path}${Platform.pathSeparator}'
      'scanner_360_sign_$stamp',
    );
    await dir.create(recursive: true);
    return '${dir.path}${Platform.pathSeparator}signed_$stamp.pdf';
  }
}

/// Internal exception used to unify signing errors for the UI.
class _SignError implements Exception {
  const _SignError(this.message);

  final String message;
}