import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:lawlink360/core/features/translation/services/ocr_service.dart';
import 'package:lawlink360/core/features/translation/services/translation_service.dart';

class ImageTranslationScreen extends StatefulWidget {
  const ImageTranslationScreen({super.key});

  @override
  State<ImageTranslationScreen> createState() => _ImageTranslationScreenState();
}

class _ImageTranslationScreenState extends State<ImageTranslationScreen> {
  File? selectedImage;

  final OCRService _ocrService = OCRService();

  final TranslationService _translationService = TranslationService();

  final ImagePicker _picker = ImagePicker();


  String extractedText = "";
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

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> recognizeText() async {
  if (selectedImage == null) return;

  final text = await _ocrService.extractText(selectedImage!);

  setState(() {
    extractedText = text;
  });
}
  
  Future<void> translateDetectedText() async {
  if (extractedText.trim().isEmpty) return;

  final result = await _translationService.translate(
    text: extractedText,
    source: getTranslateLanguage(fromLanguage),
    target: getTranslateLanguage(toLanguage),
  );

  setState(() {
    translatedText = result;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Translation")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: selectedImage == null
                  ? const Center(
                      child: Icon(Icons.image, size: 70, color: Colors.grey),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(selectedImage!, fit: BoxFit.cover),
                    ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Select Image"),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: recognizeText,
                icon: const Icon(Icons.document_scanner),
                label: const Text("Scan Text"),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Detected Text",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              constraints: const BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                extractedText.isEmpty
                    ? "Text from image will appear here"
                    : extractedText,
              ),
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: translateDetectedText,
                child: const Text("Translate"),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Translated Result",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              constraints: const BoxConstraints(minHeight: 120),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                translatedText.isEmpty
                    ? "Translation will appear here"
                    : translatedText,
              ),
            ),

            const SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
