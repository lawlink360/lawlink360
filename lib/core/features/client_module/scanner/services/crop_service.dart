import 'dart:io';
import 'package:image/image.dart' as img;

class CropService {
  static Future<File> cropImage({
  required String imagePath,
  required int left,
  required int top,
  required int width,
  required int height,
  required double scaleX,
  required double scaleY,
}) async {
    final file = File(imagePath);

    final bytes = await file.readAsBytes();

    final original = img.decodeImage(bytes);

    if (original == null) {
      throw Exception("Unable to decode image.");
    }

    final cropped = img.copyCrop(
  original,
  x: (left * scaleX).toInt(),
  y: (top * scaleY).toInt(),
  width: (width * scaleX).toInt(),
  height: (height * scaleY).toInt(),
);

    final newFile = File(imagePath);

    await newFile.writeAsBytes(
      img.encodeJpg(cropped, quality: 95),
    );

    return newFile;
  }
}