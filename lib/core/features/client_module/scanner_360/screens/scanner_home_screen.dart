import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../models/scanner_mode.dart';
import '../providers/scanner_documents_provider.dart';
import '../providers/scanner_pages_provider.dart';
import '../providers/scanner_session_provider.dart';
import '../providers/scanner_settings_provider.dart';
import '../widgets/home/scanner_home_action_card.dart';
import '../widgets/home/scanner_home_header.dart';
import '../widgets/home/scanner_home_recent_section.dart';
import 'scanner_camera_screen.dart';
import 'scanner_convert_screen.dart';
import 'scanner_document_library_screen.dart';
import 'scanner_document_tools_screen.dart';
import 'scanner_document_viewer_screen.dart';
import 'scanner_pdf_tools_screen.dart';
import 'scanner_settings_screen.dart';

/// Scanner 360 home screen.
class ScannerHomeScreen extends ConsumerStatefulWidget {
  const ScannerHomeScreen({super.key});

  @override
  ConsumerState<ScannerHomeScreen> createState() =>
      _ScannerHomeScreenState();
}

class _ScannerHomeScreenState extends ConsumerState<ScannerHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scannerDocumentsProvider.notifier).loadRecent(limit: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScannerHomeHeader(
                onOpenSettings: _openSettings,
              ),
              const SizedBox(height: AppSpacing.lg),
              ScannerHomeActionCard(
                icon: Icons.document_scanner_outlined,
                title: 'Scan Document',
                subtitle:
                    'Use the camera to scan a new document.',
                onTap: _startScanning,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.photo_library_outlined,
                title: 'Import from Gallery',
                subtitle:
                    'Pick images and turn them into a document.',
                onTap: _importFromGallery,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.burst_mode_outlined,
                title: 'Batch Scan',
                subtitle: 'Scan multiple pages continuously.',
                onTap: _startBatchScanning,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.badge_outlined,
                title: 'ID Card',
                subtitle: 'Capture the front and back of a card.',
                onTap: _startIdCardScanning,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.picture_as_pdf_outlined,
                title: 'PDF Tools',
                subtitle:
                    'Merge, split, reorder, rotate and compress PDFs.',
                onTap: _openPdfTools,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.swap_horiz,
                title: 'Convert',
                subtitle:
                    'Convert between images, PDFs and text.',
                onTap: _openConvert,
              ),
              const SizedBox(height: AppSpacing.md),
              ScannerHomeActionCard(
                icon: Icons.build_outlined,
                title: 'Document Tools',
                subtitle:
                    'OCR, annotate, sign, fill, print and share.',
                onTap: _openDocumentTools,
              ),
              const SizedBox(height: AppSpacing.lg),
              ScannerHomeRecentSection(
                onOpenDocument: _openDocument,
                onSeeAll: _openAllDocuments,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerSettingsScreen(),
      ),
    );
  }

  Future<void> _startScanning() async {
    final settings = ref.read(scannerSettingsProvider);
    final previous = ref.read(scannerSessionProvider);

    await ref
        .read(scannerPagesProvider.notifier)
        .resetForNewSession(previousSessionId: previous?.id);

    ref.read(scannerSessionProvider.notifier).startSession(
          mode: ScannerMode.document,
          settings: settings,
        );

    if (!mounted) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerCameraScreen(),
      ),
    );

    if (result == true && mounted) {
      _showSnackBar('Saved');
    }
  }

  Future<void> _importFromGallery() async {
    final settings = ref.read(scannerSettingsProvider);
    final previous = ref.read(scannerSessionProvider);

    await ref
        .read(scannerPagesProvider.notifier)
        .resetForNewSession(previousSessionId: previous?.id);

    ref.read(scannerSessionProvider.notifier).startSession(
          mode: ScannerMode.document,
          settings: settings,
        );

    if (!mounted) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerCameraScreen(
          autoOpenGallery: true,
        ),
      ),
    );

    if (result == true && mounted) {
      _showSnackBar('Saved');
    }
  }

  Future<void> _startBatchScanning() async {
    final settings = ref.read(scannerSettingsProvider);
    final previous = ref.read(scannerSessionProvider);

    await ref
        .read(scannerPagesProvider.notifier)
        .resetForNewSession(previousSessionId: previous?.id);

    ref.read(scannerSessionProvider.notifier).startSession(
          mode: ScannerMode.batch,
          settings: settings,
        );

    if (!mounted) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerCameraScreen(),
      ),
    );

    if (result == true && mounted) {
      _showSnackBar('Saved');
    }
  }

  Future<void> _startIdCardScanning() async {
    final settings = ref.read(scannerSettingsProvider);
    final previous = ref.read(scannerSessionProvider);

    await ref
        .read(scannerPagesProvider.notifier)
        .resetForNewSession(previousSessionId: previous?.id);

    ref.read(scannerSessionProvider.notifier).startSession(
          mode: ScannerMode.idCard,
          settings: settings,
        );

    if (!mounted) return;

    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerCameraScreen(),
      ),
    );

    if (result == true && mounted) {
      _showSnackBar('Saved');
    }
  }

  void _openPdfTools() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerPdfToolsScreen(),
      ),
    );
  }

  void _openConvert() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerConvertScreen(),
      ),
    );
  }

  void _openDocumentTools() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerDocumentToolsScreen(),
      ),
    );
  }

  void _openDocument(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScannerDocumentViewerScreen(
          documentId: id,
        ),
      ),
    );
  }

  void _openAllDocuments() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ScannerDocumentLibraryScreen(),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}