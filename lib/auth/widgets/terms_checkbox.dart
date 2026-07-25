import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final textColor = isDark ? Colors.white70 : Colors.black54;
    final linkColor = const Color(0xFFD4AF37);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFFD4AF37),
          checkColor: Colors.black,
          side: const BorderSide(
            color: Color(0xFFD4AF37),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
                children: [
                  const TextSpan(text: "I agree to the "),
                  TextSpan(
                    text: "Terms & Conditions",
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}