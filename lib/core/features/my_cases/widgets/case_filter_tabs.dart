import 'package:flutter/material.dart';

class CaseFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const CaseFilterTabs({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      "All",
      "Active",
      "Pending",
      "Completed",
      "Archived",
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;

          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            onSelected: (_) => onChanged?.call(index),
            selectedColor: const Color(0xFF0F172A),
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}