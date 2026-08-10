import 'package:flutter/material.dart';

class AppointmentFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const AppointmentFilterTabs({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      "All",
      "Today",
      "Upcoming",
      "Completed",
      "Cancelled",
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;

          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            selectedColor: const Color(0xFF0F172A),
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => onChanged?.call(index),
          );
        },
      ),
    );
  }
}