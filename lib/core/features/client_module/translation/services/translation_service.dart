import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationService {
  OnDeviceTranslator? _translator;

  Future<String> translate({
    required String text,
    required TranslateLanguage source,
    required TranslateLanguage target,
  }) async {
    _translator?.close();

    _translator = OnDeviceTranslator(
      sourceLanguage: source,
      targetLanguage: target,
    );

    return await _translator!.translateText(text);
  }

  void dispose() {
    _translator?.close();
  }
}