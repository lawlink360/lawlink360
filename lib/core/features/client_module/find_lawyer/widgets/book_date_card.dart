import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookDateCard extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const BookDateCard({
    super.key,
    this.onChanged,
  });

  @override
  State<BookDateCard> createState() => _BookDateCardState();
}

class _BookDateCardState extends State<BookDateCard> {
  late final List<DateTime> _dates;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    _dates = List.generate(
      14,
      (index) => DateTime(
        today.year,
        today.month,
        today.day + index + 1,
      ),
    );

    _selectedDate = _dates.first;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onChanged?.call(_formatDate(_selectedDate));
      }
    });
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[date.weekday - 1]} '
        '${date.day} '
        '${months[date.month - 1]} '
        '${date.year}';
  }

  Future<void> _openCalendar() async {
    final today = DateTime.now();

    final firstDate = DateTime(
      today.year,
      today.month,
      today.day + 1,
    );

    final lastDate = DateTime(
      today.year + 1,
      today.month,
      today.day,
    );

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isBefore(firstDate)
          ? firstDate
          : _selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Select appointment date',
      confirmText: 'Select',
      cancelText: 'Cancel',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.accent,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
    });

    widget.onChanged?.call(_formatDate(_selectedDate));
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });

    widget.onChanged?.call(_formatDate(date));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Select Date',
                style: AppTextStyles.title.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _openCalendar,
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 18,
              ),
              label: const Text('View Calendar'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _dates.length,
            separatorBuilder: (_, _) => const SizedBox(
              width: AppSpacing.sm,
            ),
            itemBuilder: (context, index) {
              final date = _dates[index];

              return DateCard(
                day: _shortWeekday(date),
                date: date.day.toString(),
                selected: _isSameDate(_selectedDate, date),
                onTap: () => _selectDate(date),
              );
            },
          ),
        ),
      ],
    );
  }

  String _shortWeekday(DateTime date) {
    const weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return weekdays[date.weekday - 1];
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}

class DateCard extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;
  final VoidCallback? onTap;

  const DateCard({
    super.key,
    required this.day,
    required this.date,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor =
        selected ? AppColors.accent : colorScheme.surface;

    final borderColor = selected
        ? AppColors.accent
        : colorScheme.outline.withValues(alpha: 0.35);

    final dayColor =
        selected ? Colors.white : colorScheme.onSurfaceVariant;

    final dateColor =
        selected ? Colors.white : colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 70,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: AppTextStyles.caption.copyWith(
                  color: dayColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                date,
                style: AppTextStyles.title.copyWith(
                  color: dateColor,
                  fontSize: 24,
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