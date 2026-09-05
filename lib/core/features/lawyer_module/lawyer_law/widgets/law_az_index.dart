import 'package:flutter/material.dart';

import '../data/law_index_data.dart';

class LawAzIndex extends StatelessWidget {
  const LawAzIndex({
    super.key,
    required this.selectedLetter,
    required this.onLetterSelected,
  });

  final String selectedLetter;
  final ValueChanged<String> onLetterSelected;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 8,
      children: LawIndexData.alphabet.map((letter) {
        final isSelected = letter == selectedLetter;
        final hasLaws = LawIndexData.hasLaws(letter);

        return _LetterButton(
          letter: letter,
          isSelected: isSelected,
          hasLaws: hasLaws,
          onTap: hasLaws
              ? () => onLetterSelected(letter)
              : null,
        );
      }).toList(),
    );
  }
}

class _LetterButton extends StatelessWidget {
  const _LetterButton({
    required this.letter,
    required this.isSelected,
    required this.hasLaws,
    required this.onTap,
  });

  final String letter;
  final bool isSelected;
  final bool hasLaws;
  final VoidCallback? onTap;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? navy
              : hasLaws
                  ? Colors.white
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? navy
                : hasLaws
                    ? Colors.grey.shade300
                    : Colors.grey.shade200,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: navy.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Text(
          letter,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : hasLaws
                    ? navy
                    : Colors.grey.shade400,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}