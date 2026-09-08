import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/features/client_module/translation/services/document_service.dart';
import 'package:lawlink360/core/features/client_module/translation/services/ocr_service.dart';
import 'package:lawlink360/core/features/client_module/translation/services/translation_service.dart';
import 'package:lawlink360/core/services/download_service.dart';
import 'package:lawlink360/core/services/share_service.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  File? selectedImage;

  final OCRService _ocrService = OCRService();
  final TranslationService _translationService = TranslationService();
  final DocumentService _documentService = DocumentService();
  final DownloadService _downloadService = DownloadService();
  final ShareService _shareService = ShareService();
  final ImagePicker _picker = ImagePicker();

  String extractedText = '';
  String translatedText = '';

  String fromLanguage = 'English';
  String toLanguage = 'Urdu';

  final List<String> languages = [
    'Auto Detect',
    'English',
    'Urdu',
    'Arabic',
    'French',
    'German',
    'Turkish',
    'Chinese',
    'Hindi',
    'Persian',
    'Russian',
    'Italian',
    'Portuguese',
    'Japanese',
    'Korean',
  ];

  void showUrduComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Urdu Translation'),
        content: const Text(
          'Urdu document translation is launching soon.\n\n'
          "We're working to provide accurate Urdu OCR and translation "
          'in a future update.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  TranslateLanguage getTranslateLanguage(String language) {
    switch (language) {
      case 'English':
        return TranslateLanguage.english;
      case 'Urdu':
        return TranslateLanguage.urdu;
      case 'Arabic':
        return TranslateLanguage.arabic;
      case 'French':
        return TranslateLanguage.french;
      case 'German':
        return TranslateLanguage.german;
      case 'Turkish':
        return TranslateLanguage.turkish;
      case 'Chinese':
        return TranslateLanguage.chinese;
      case 'Hindi':
        return TranslateLanguage.hindi;
      case 'Persian':
        return TranslateLanguage.persian;
      case 'Russian':
        return TranslateLanguage.russian;
      case 'Italian':
        return TranslateLanguage.italian;
      case 'Portuguese':
        return TranslateLanguage.portuguese;
      case 'Japanese':
        return TranslateLanguage.japanese;
      case 'Korean':
        return TranslateLanguage.korean;
      default:
        return TranslateLanguage.english;
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

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
    if (fromLanguage == 'Urdu') {
      showUrduComingSoonDialog();
      return;
    }

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
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Translation'),
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.lightBorder,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(
              icon: Icons.document_scanner_outlined,
              title: 'Document',
              subtitle: 'Select a document image and extract its text.',
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildDocumentPreview(),

            const SizedBox(height: AppSpacing.md),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Select Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textLight,
                  minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: recognizeText,
                icon: const Icon(Icons.document_scanner_outlined),
                label: const Text('Extract Text'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
                  side: const BorderSide(
                    color: AppColors.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionTitle(
              icon: Icons.text_snippet_outlined,
              title: 'Extracted Text',
              subtitle: 'Review the text detected from your document.',
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildTextContainer(
              text: extractedText,
              placeholder: 'Extracted text will appear here...',
              minHeight: 110,
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionTitle(
              icon: Icons.translate_rounded,
              title: 'Language',
              subtitle: 'Choose the source and target languages.',
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildLanguageSelector(),

            const SizedBox(height: AppSpacing.md),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: translateDetectedText,
                icon: const Icon(Icons.translate_rounded),
                label: const Text('Translate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            _SectionTitle(
              icon: Icons.g_translate_rounded,
              title: 'Translated Result',
              subtitle: 'Your translated document text will appear here.',
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildTextContainer(
              text: translatedText,
              placeholder: 'Translation will appear here',
              minHeight: 130,
              highlighted: true,
            ),

            const SizedBox(height: AppSpacing.md),

            _buildResultActions(),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentPreview() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
      ),
      child: selectedImage == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  "Tap 'Select Document'",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'to choose an image or scanned document',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Widget _buildTextContainer({
    required String text,
    required String placeholder,
    required double minHeight,
    bool highlighted = false,
  }) {
    final hasText = text.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.lightSurface
            : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: highlighted
              ? AppColors.accent.withValues(alpha: 0.35)
              : AppColors.lightBorder,
        ),
      ),
      child: Text(
        hasText ? text : placeholder,
        style: AppTextStyles.body.copyWith(
          color: hasText
              ? AppColors.lightTextPrimary
              : AppColors.lightTextSecondary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLanguageDropdown(
              label: 'From',
              value: fromLanguage,
              onChanged: (value) {
                setState(() {
                  fromLanguage = value!;
                });
              },
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: 'Swap languages',
              onPressed: () {
                setState(() {
                  final temp = fromLanguage;
                  fromLanguage = toLanguage;
                  toLanguage = temp;
                });
              },
              icon: const Icon(
                Icons.swap_horiz_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _buildLanguageDropdown(
              label: 'To',
              value: toLanguage,
              onChanged: (value) {
                setState(() {
                  toLanguage = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.caption.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        filled: true,
        fillColor: AppColors.lightBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.4,
          ),
        ),
      ),
      items: languages.map((language) {
        return DropdownMenuItem<String>(
          value: language,
          child: Text(
            language,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.lightTextPrimary,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildResultActions() {
    final enabled = translatedText.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: enabled
                ? () async {
                    await _documentService.printTranslation(
                      translatedText,
                    );
                  }
                : null,
            icon: const Icon(Icons.print_outlined),
            label: const Text('Print'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
              side: const BorderSide(
                color: AppColors.lightBorder,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: enabled
                ? () {
                    // Print function
                  }
                : null,
            icon: const Icon(Icons.autorenew_rounded),
            label: const Text('Convert'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textLight,
              minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: enabled
                ? () async {
                    final path = await _downloadService
                        .saveTranslationAsPdf(
                      translatedText,
                      'LawLink360_Translation',
                    );

                    await _shareService.sharePdf(path);
                  }
                : null,
            icon: const Icon(Icons.share_outlined),
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}