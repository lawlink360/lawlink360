import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/features/client_module/models/ai_search_intent.dart';
import '../../core/features/client_module/services/ai_search_resolver.dart';
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final AiSearchResolver _resolver = const AiSearchResolver();

  Timer? _rotationTimer;
  int _currentIndex = 0;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    _rotationTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted ||
            _isNavigating ||
            _focusNode.hasFocus ||
            _controller.text.isNotEmpty) {
          return;
        }

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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    final query = _controller.text.trim();

    if (query.isEmpty) {
      _focusNode.requestFocus();
      return;
    }

    final destination = _resolver.resolve(query);

    if (destination == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'I could not identify the right service. Try searching for a lawyer, procedure, application, verification, translation, or scanner.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _focusNode.unfocus();

    setState(() {
      _isNavigating = true;
    });

    await _resolver.openDestination(
      context,
      destination,
    );

    if (!mounted) return;

    _controller.clear();

    setState(() {
      _currentIndex = 0;
      _isNavigating = false;
    });
  }

  void _clearSearch() {
    _controller.clear();

    setState(() {});

    _focusNode.requestFocus();
  }

  void _handleTapOutside(PointerDownEvent event) {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final chipColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    final currentIntent = AiSearchIntent.available[_currentIndex];

    return Material(
      color: Colors.transparent,
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
            TextField(
              controller: _controller,
              focusNode: _focusNode,

              // Important:
              // Tapping anywhere outside the search field
              // removes focus and closes the keyboard.
              onTapOutside: _handleTapOutside,

              onChanged: (_) {
                setState(() {});
              },

              onSubmitted: (_) => _performSearch(),

              textInputAction: TextInputAction.search,

              style: AppTextStyles.body.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),

              decoration: InputDecoration(
                hintText: currentIntent.title,
                hintStyle: AppTextStyles.body.copyWith(
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
                prefixIcon: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.accent,
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: Icon(
                          Icons.close_rounded,
                          color: secondaryTextColor,
                        ),
                      )
                    : IconButton(
                        onPressed: _performSearch,
                        icon: Icon(
                          Icons.search_rounded,
                          color: secondaryTextColor,
                        ),
                      ),
                filled: true,
                fillColor: chipColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.lg,
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.lg,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.lg,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.accent,
                    width: 1.5,
                  ),
                ),
              ),
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

    return GestureDetector(
      onTap: () {
        final searchBar = context.findAncestorStateOfType<
            _AISearchBarState>();

        if (searchBar == null) return;

        searchBar._controller.text = text;
        searchBar._performSearch();
      },
      child: Chip(
        label: Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        side: BorderSide.none,
      ),
    );
  }
}
