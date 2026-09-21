import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../models/ocr_block.dart';
import '../models/ocr_line.dart';
import '../models/ocr_result.dart';
import '../models/ocr_word.dart';
import '../models/scanner_language.dart';

class ScannerOcrException implements Exception {
  const ScannerOcrException(this.message);

  final String message;

  @override
  String toString() => 'ScannerOcrException: $message';
}

class ScannerOcrService {
  const ScannerOcrService();

  Future<OcrResult> extractText({
    required String imagePath,
    required ScannerLanguage language,
    String? pageId,
  }) async {
    final file = File(imagePath);

    if (!await file.exists()) {
      throw ScannerOcrException(
        'Image file does not exist: $imagePath',
      );
    }

    final recognizer = TextRecognizer(
      script: _scriptFor(language),
    );

    try {
      final input = InputImage.fromFilePath(imagePath);

      final RecognizedText recognized =
          await recognizer.processImage(input);

      return OcrResult(
        text: recognized.text,
        blocks: recognized.blocks
            .map(_convertBlock)
            .toList(growable: false),
        language: language,
        createdAt: DateTime.now(),
        pageId: pageId,
      );
    } finally {
      await recognizer.close();
    }
  }

  TextRecognitionScript _scriptFor(
    ScannerLanguage language,
  ) {
    switch (language) {
      case ScannerLanguage.latin:
        return TextRecognitionScript.latin;

      case ScannerLanguage.chinese:
        return TextRecognitionScript.chinese;

      case ScannerLanguage.devanagari:
        return TextRecognitionScript.devanagiri;

      case ScannerLanguage.japanese:
        return TextRecognitionScript.japanese;

      case ScannerLanguage.korean:
        return TextRecognitionScript.korean;
    }
  }

  OcrBlock _convertBlock(TextBlock block) {
    return OcrBlock(
      text: block.text,
      lines: block.lines
          .map(_convertLine)
          .toList(growable: false),
      boundingBox: block.boundingBox,
      cornerPoints: _convertCornerPoints(block.cornerPoints),
      recognizedLanguages: block.recognizedLanguages,
    );
  }

  OcrLine _convertLine(TextLine line) {
    return OcrLine(
      text: line.text,
      words: line.elements
          .map(_convertElement)
          .toList(growable: false),
      boundingBox: line.boundingBox,
      cornerPoints: _convertCornerPoints(line.cornerPoints),
      angle: line.angle ?? 0.0,
      recognizedLanguages: line.recognizedLanguages,
    );
  }

  OcrWord _convertElement(TextElement element) {
    return OcrWord(
      text: element.text,
      boundingBox: element.boundingBox,
      cornerPoints: _convertCornerPoints(
        element.cornerPoints,
      ),
    );
  }

  List<Offset> _convertCornerPoints(
    List<Point<int>?> points,
  ) {
    return points
        .whereType<Point<int>>()
        .map(
          (point) => Offset(
            point.x.toDouble(),
            point.y.toDouble(),
          ),
        )
        .toList(growable: false);
  }
}