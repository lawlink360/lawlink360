import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareService {
  const ShareService();

  // ============================================================
  // SHARE PDF
  // ============================================================

  Future<void> sharePdf(
    String filePath, {
    String text = 'LawLink360 Document',
  }) async {
    // Check if file exists
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $filePath');
    }

    await Share.shareXFiles(
      [
        XFile(filePath),
      ],
      text: text,
    );
  }
}