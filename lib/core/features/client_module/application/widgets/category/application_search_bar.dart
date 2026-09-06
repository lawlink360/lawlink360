import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class ApplicationSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const ApplicationSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  State<ApplicationSearchBar> createState() =>
      _ApplicationSearchBarState();
}

class _ApplicationSearchBarState extends State<ApplicationSearchBar> {
  late final TextEditingController _internalController;

  TextEditingController get _controller =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }

    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.65),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            widget.onChanged?.call(value);
            setState(() {});
          },
          textInputAction: TextInputAction.search,
          cursorColor: AppColors.accent,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'What document do you need today?',
            hintStyle: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.48),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: colorScheme.primary,
              size: 23,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    onPressed: _clearSearch,
                    tooltip: 'Clear search',
                    icon: Icon(
                      Icons.close_rounded,
                      color: colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  )
                : null,
            filled: false,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ),
    );
  }
}
