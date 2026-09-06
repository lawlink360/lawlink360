import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class VoiceCallBottomTools extends StatelessWidget {
  const VoiceCallBottomTools({super.key});

  Widget _tool(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: colorScheme.onSurface.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                icon,
                color: colorScheme.onSurface,
                size: 25,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.72),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tool(
            context,
            Icons.chat_outlined,
            'Chat',
          ),
          _tool(
            context,
            Icons.description_outlined,
            'Document',
          ),
          _tool(
            context,
            Icons.edit_note_outlined,
            'Notes',
          ),
          _tool(
            context,
            Icons.calendar_month_outlined,
            'Follow-up',
          ),
        ],
      ),
    );
  }
}