
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class VideoBottomTools extends StatelessWidget {
  const VideoBottomTools({super.key});

  Widget _tool(
    IconData icon,
    String title,
  ) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tool(Icons.chat_outlined, 'Chat'),
          _tool(Icons.description_outlined, 'Document'),
          _tool(Icons.edit_note_outlined, 'Notes'),
          _tool(Icons.calendar_month_outlined, 'Follow-up'),
        ],
      ),
    );
  }
}
