import 'package:flutter/material.dart';

class ShowMoreButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onPressed;

  const ShowMoreButton({
    super.key,
    required this.expanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        expanded
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down,
      ),
      label: Text(
        expanded ? 'Show Less' : 'Show More',
      ),
    );
  }
}