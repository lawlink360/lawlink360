import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/features/client_module/models/ai_search_intent.dart';
import '../../core/features/client_module/screens/ai_search_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AISearchBar extends StatefulWidget {
  const AISearchBar({super.key});

  @override
  State<AISearchBar> createState() => _AISearchBarState();
}

class _AISearchBarState extends State<AISearchBar> {
  Timer? _rotationTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _rotationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          _currentIndex =
              (_currentIndex + 1) % AiSearchIntent.available.length;
        });
      },
    );
  }

  @override
  void dispose() {
    _rotationTimer?.cancel();
    super.dispose();
  }

  void _openAiSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiSearchScreen(
          initialDestination:
              AiSearchIntent.available[_currentIndex].destination,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final currentIntent = AiSearchIntent.available[_currentIndex];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openAiSearch,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: isDark ? 0.18 : 0.08,
                ),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0, 0.35),
                          end: Offset.zero,
                        ).animate(animation);

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          ),
                        );
                      },
                      child: Align(
                        key: ValueKey(currentIntent.destination),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          currentIntent.title,
                          style: AppTextStyles.body.copyWith(
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: secondaryTextColor,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: const [
                  _SuggestionChip(
                    text: 'Bail Application',
                  ),
                  _SuggestionChip(
                    text: 'Property Case',
                  ),
                  _SuggestionChip(
                    text: 'Family Dispute',
                  ),
                  _SuggestionChip(
                    text: 'Lost CNIC',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;

  const _SuggestionChip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final textColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Chip(
      label: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
      side: BorderSide.none,
    );
  }
}
