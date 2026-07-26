import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:lawlink360/core/features/translation/screens/image_translation_screen.dart';
import 'package:lawlink360/core/features/translation/services/translation_service.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController inputController = TextEditingController();

  final TranslationService _translationService = TranslationService();

  final stt.SpeechToText _speech = stt.SpeechToText();

  final FlutterTts _flutterTts = FlutterTts();

  bool _isListening = false;
  bool _isTranslating = false;

  String translatedText = "";

  String fromLanguage = "English";
  String toLanguage = "Urdu";

  final List<String> languages = [
    "English",
    "Urdu",
    "Arabic",
    "French",
    "German",
    "Turkish",
    "Chinese",
    "Hindi",
    "Persian",
    "Russian",
    "Italian",
    "Portuguese",
    "Japanese",
    "Korean",
  ];

  TranslateLanguage getTranslateLanguage(String language) {
    switch (language) {
      case "English":
        return TranslateLanguage.english;
      case "Urdu":
        return TranslateLanguage.urdu;
      case "Arabic":
        return TranslateLanguage.arabic;
      case "French":
        return TranslateLanguage.french;
      case "German":
        return TranslateLanguage.german;
      case "Turkish":
        return TranslateLanguage.turkish;
      case "Chinese":
        return TranslateLanguage.chinese;
      case "Hindi":
        return TranslateLanguage.hindi;
      case "Persian":
        return TranslateLanguage.persian;
      case "Russian":
        return TranslateLanguage.russian;
      case "Italian":
        return TranslateLanguage.italian;
      case "Portuguese":
        return TranslateLanguage.portuguese;
      case "Japanese":
        return TranslateLanguage.japanese;
      case "Korean":
        return TranslateLanguage.korean;

      default:
        return TranslateLanguage.english;
    }
  }

  Future<void> translateText() async {
    if (inputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter some text first.")),
      );
      return;
    }

    setState(() {
      _isTranslating = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(child: Text("Preparing Translation...")),
          ],
        ),
      ),
    );

    try {
      final result = await _translationService
          .translate(
            text: inputController.text.trim(),
            source: getTranslateLanguage(fromLanguage),
            target: getTranslateLanguage(toLanguage),
          )
          .timeout(const Duration(seconds: 60));

      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      setState(() {
        translatedText = result;
        _isTranslating = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Translation Ready")));
    } on TimeoutException {
      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      setState(() {
        _isTranslating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "The language model is still downloading. Please wait a few minutes and try again.",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      Navigator.of(context, rootNavigator: true).pop();

      setState(() {
        _isTranslating = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Translation failed: $e")));
    }
  }

  Future<void> speakTranslatedText() async {
    if (translatedText.trim().isEmpty) return;

    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);

    await _flutterTts.speak(translatedText);
  }

  Future<void> startListening() async {
    bool available = await _speech.initialize();

    if (available) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            inputController.text = result.recognizedWords;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    _translationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Language Translator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromLanguage,
                    decoration: InputDecoration(
                      labelText: "From",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: languages.map((language) {
                      return DropdownMenuItem(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromLanguage = value!;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  onPressed: () {
                    setState(() {
                      final temp = fromLanguage;
                      fromLanguage = toLanguage;
                      toLanguage = temp;
                    });
                  },
                  icon: const Icon(Icons.swap_horiz_rounded, size: 30),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toLanguage,
                    decoration: InputDecoration(
                      labelText: "To",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: languages.map((language) {
                      return DropdownMenuItem(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toLanguage = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                leading: const Icon(Icons.document_scanner, size: 32),
                title: const Text(
                  "Image Translation",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Scan documents and translate text"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImageTranslationScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: inputController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Type or paste text here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: startListening,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      inputController.clear();

                      setState(() {
                        translatedText = "";
                      });
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text("Clear"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isTranslating ? null : translateText,
                    icon: const Icon(Icons.translate),
                    label: const Text("Translate"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 180),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: translatedText.isEmpty
                        ? null
                        : speakTranslatedText,
                    icon: const Icon(Icons.volume_up),
                  ),

                  SelectableText(
                    translatedText.isEmpty
                        ? "Translated text will appear here..."
                        : translatedText,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: translatedText.isEmpty
                        ? null
                        : () async {
                            await Clipboard.setData(
                              ClipboardData(text: translatedText),
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Translated text copied"),
                              ),
                            );
                          },
                    icon: const Icon(Icons.copy),
                    label: const Text("Copy"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
