import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/ocr_result.dart';

/// Scrollable OCR text view with in-memory search highlighting.
class ScannerOcrResultView extends StatelessWidget {
  const ScannerOcrResultView({
    super.key,
    required this.result,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  final OcrResult result;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: TextField(
            onChanged: onSearchChanged,
            style: AppTextStyles.body,
            decoration: InputDecoration(
              hintText: 'Search text',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.lightTextSecondary,
              ),
              filled: true,
              fillColor: AppColors.lightSurface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
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
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: _buildHighlightedText(),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightedText() {
    final text = result.text;
    final query = searchQuery.trim();

    if (query.isEmpty) {
      return Text(
        text,
        style: AppTextStyles.body,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    var cursor = 0;

    while (cursor < text.length) {
      final matchIndex = lowerText.indexOf(lowerQuery, cursor);
      if (matchIndex == -1) {
        spans.add(
          TextSpan(
            text: text.substring(cursor),
            style: AppTextStyles.body,
          ),
        );
        break;
      }

      if (matchIndex > cursor) {
        spans.add(
          TextSpan(
            text: text.substring(cursor, matchIndex),
            style: AppTextStyles.body,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(
            matchIndex,
            matchIndex + query.length,
          ),
          style: AppTextStyles.body.copyWith(
            backgroundColor: AppColors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      cursor = matchIndex + query.length;
    }

    if (spans.isEmpty) {
      return Text(
        text,
        style: AppTextStyles.body,
      );
    }

    return Text.rich(
      TextSpan(children: spans),
    );
  }
}