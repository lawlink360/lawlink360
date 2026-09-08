import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/models/ai_search_intent.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/client_module/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client_module/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class AiSearchScreen extends StatefulWidget {
  final AiSearchDestination? initialDestination;

  const AiSearchScreen({
    super.key,
    this.initialDestination,
  });

  @override
  State<AiSearchScreen> createState() => _AiSearchScreenState();
}

class _AiSearchScreenState extends State<AiSearchScreen> {
  late AiSearchIntent _selectedIntent;
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedIntent = widget.initialDestination != null
        ? AiSearchIntent.forDestination(widget.initialDestination!)
        : AiSearchIntent.available.first;
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _selectIntent(AiSearchIntent intent) {
    setState(() {
      _selectedIntent = intent;
      _queryController.clear();
    });
  }

  void _performSearch() {
    final destination = _selectedIntent.destination;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _destinationScreen(destination),
      ),
    );
  }

  Widget _destinationScreen(AiSearchDestination destination) {
    switch (destination) {
      case AiSearchDestination.findLawyer:
        return const FindLawyerScreen();

      case AiSearchDestination.applications:
        return const ApplicationHomeScreen();

      case AiSearchDestination.procedureGuide:
        return const GuiderHomeScreen();

      case AiSearchDestination.verificationHub:
        return const VerificationScreen();

      case AiSearchDestination.translation:
        return const TranslationScreen();

      case AiSearchDestination.scanner:
        return const ScannerConverterHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'LawLink AI',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            _IntroSection(
              title: 'How can we help?',
              description:
                  'Choose a service or describe what you need. LawLink360 will take you to the right place.',
              textColor: colorScheme.onSurface,
              secondaryTextColor: secondaryTextColor,
            ),
            const SizedBox(height: AppSpacing.lg),
            _SearchInput(
              controller: _queryController,
              hintText: _selectedIntent.fields.first,
              textColor: colorScheme.onSurface,
              secondaryTextColor: secondaryTextColor,
              surfaceColor: surfaceColor,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'What are you looking for?',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...AiSearchIntent.available.map(
              (intent) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.sm,
                ),
                child: _IntentCard(
                  intent: intent,
                  selected:
                      intent.destination == _selectedIntent.destination,
                  onTap: () => _selectIntent(intent),
                  textColor: colorScheme.onSurface,
                  secondaryTextColor: secondaryTextColor,
                  surfaceColor: surfaceColor,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _SelectedIntentSection(
              intent: _selectedIntent,
              textColor: colorScheme.onSurface,
              secondaryTextColor: secondaryTextColor,
              surfaceColor: surfaceColor,
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 54,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _performSearch,
                icon: const Icon(Icons.auto_awesome_rounded),
                label: Text(
                  _selectedIntent.actionLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppRadius.lg,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  final String title;
  final String description;
  final Color textColor;
  final Color secondaryTextColor;

  const _IntroSection({
    required this.title,
    required this.description,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.headline.copyWith(
                  color: textColor,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          description,
          style: AppTextStyles.bodySmall.copyWith(
            color: secondaryTextColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color textColor;
  final Color secondaryTextColor;
  final Color surfaceColor;

  const _SearchInput({
    required this.controller,
    required this.hintText,
    required this.textColor,
    required this.secondaryTextColor,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTextStyles.body.copyWith(
        color: textColor,
      ),
      maxLines: 3,
      minLines: 1,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: secondaryTextColor,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.accent,
        ),
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _IntentCard extends StatelessWidget {
  final AiSearchIntent intent;
  final bool selected;
  final VoidCallback onTap;
  final Color textColor;
  final Color secondaryTextColor;
  final Color surfaceColor;

  const _IntentCard({
    required this.intent,
    required this.selected,
    required this.onTap,
    required this.textColor,
    required this.secondaryTextColor,
    required this.surfaceColor,
  });

  IconData get _icon {
    switch (intent.destination) {
      case AiSearchDestination.findLawyer:
        return Icons.gavel_rounded;
      case AiSearchDestination.applications:
        return Icons.description_rounded;
      case AiSearchDestination.procedureGuide:
        return Icons.menu_book_rounded;
      case AiSearchDestination.verificationHub:
        return Icons.verified_user_rounded;
      case AiSearchDestination.translation:
        return Icons.translate_rounded;
      case AiSearchDestination.scanner:
        return Icons.document_scanner_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: selected
                  ? AppColors.accent
                  : Colors.transparent,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(
                    alpha: selected ? 0.16 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                child: Icon(
                  _icon,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      intent.title,
                      style: AppTextStyles.body.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      intent.description,
                      style: AppTextStyles.caption.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.chevron_right_rounded,
                color: selected
                    ? AppColors.accent
                    : secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedIntentSection extends StatelessWidget {
  final AiSearchIntent intent;
  final Color textColor;
  final Color secondaryTextColor;
  final Color surfaceColor;

  const _SelectedIntentSection({
    required this.intent,
    required this.textColor,
    required this.secondaryTextColor,
    required this.surfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Relevant information',
            style: AppTextStyles.body.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...intent.fields.map(
            (field) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      field,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}