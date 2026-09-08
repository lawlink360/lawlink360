import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class OCRService {

  final TextRecognizer _latinRecognizer =
      TextRecognizer(
        script: TextRecognitionScript.latin,
      );


  Future<String> extractText(File image) async {

    final inputImage = InputImage.fromFile(image);

    final RecognizedText recognizedText =
        await _latinRecognizer.processImage(inputImage);

    return recognizedText.text;
  }

  void dispose() {
    _latinRecognizer.close();
  }
}