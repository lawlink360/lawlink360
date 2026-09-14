import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookConsultationType extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const BookConsultationType({
    super.key,
    this.onChanged,
  });

  @override
  State<BookConsultationType> createState() =>
      _BookConsultationTypeState();
}

class _BookConsultationTypeState extends State<BookConsultationType> {
  String _selectedType = 'In Person';

  void _selectType(String type) {
    setState(() {
      _selectedType = type;
    });

    widget.onChanged?.call(type);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consultation Type',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 19,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: ConsultationCard(
                icon: Icons.person_outline_rounded,
                title: 'In Person',
                selected: _selectedType == 'In Person',
                onTap: () => _selectType('In Person'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ConsultationCard(
                icon: Icons.call_outlined,
                title: 'Voice',
                selected: _selectedType == 'Voice',
                onTap: () => _selectType('Voice'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: ConsultationCard(
                icon: Icons.videocam_outlined,
                title: 'Video',
                selected: _selectedType == 'Video',
                onTap: () => _selectType('Video'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ConsultationCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Chat',
                selected: _selectedType == 'Chat',
                onTap: () => _selectType('Chat'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const ConsultationCard({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = selected
        ? AppColors.accent
        : colorScheme.surface;

    final foregroundColor = selected
        ? Colors.white
        : colorScheme.onSurface;

    final borderColor = selected
        ? AppColors.accent
        : colorScheme.outline.withValues(alpha: 0.45);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 92,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(
              AppRadius.lg,
            ),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.4 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(
                        alpha: 0.16,
                      ),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 27,
                color: foregroundColor,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
