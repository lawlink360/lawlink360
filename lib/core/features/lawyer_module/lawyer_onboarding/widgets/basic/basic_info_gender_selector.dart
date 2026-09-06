import 'package:flutter/material.dart';

class BasicInfoGenderSelector extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String> onChanged;

  const BasicInfoGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _GenderOption(
                title: "Male",
                icon: Icons.male,
                selected: selectedGender == "Male",
                onTap: () => onChanged("Male"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GenderOption(
                title: "Female",
                icon: Icons.female,
                selected: selectedGender == "Female",
                onTap: () => onChanged("Female"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4AF37);
    const navy = Color(0xFF13294B);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? gold.withValues(alpha:0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? gold : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? gold : navy,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: selected ? navy : Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.check_circle,
                color: gold,
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}