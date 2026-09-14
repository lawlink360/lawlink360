import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookTimeSlot extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const BookTimeSlot({
    super.key,
    this.onChanged,
  });

  @override
  State<BookTimeSlot> createState() => _BookTimeSlotState();
}

class _BookTimeSlotState extends State<BookTimeSlot> {
  int _selectedIndex = 2;

  final List<String> _times = const [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Time',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: List.generate(
            _times.length,
            (index) {
              return TimeChip(
                time: _times[index],
                selected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });

                  widget.onChanged?.call(_times[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class TimeChip extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback? onTap;

  const TimeChip({
    super.key,
    required this.time,
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
        : colorScheme.outline.withValues(alpha: 0.35);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 105,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.3 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.16),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              time,
              style: AppTextStyles.bodySmall.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}