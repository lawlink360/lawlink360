import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> sharePdf(String filePath) async {
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Translated Document - LawLink360',
    );
  }
}