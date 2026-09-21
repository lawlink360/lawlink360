import 'package:flutter/material.dart';

import '../shared/scanner_empty_view.dart';

/// Home-specific empty state. Delegates presentation to
/// [ScannerEmptyView] with home-specific copy.
class ScannerHomeEmptyState extends StatelessWidget {
  const ScannerHomeEmptyState({
    super.key,
    required this.onStartScanning,
  });

  final VoidCallback onStartScanning;

  @override
  Widget build(BuildContext context) {
    return ScannerEmptyView(
      icon: Icons.document_scanner_outlined,
      title: 'No scanned documents yet',
      subtitle:
          'Start by scanning a legal document. Your saved scans will appear here.',
      actionLabel: 'Start scanning',
      onAction: onStartScanning,
    );
  }
}