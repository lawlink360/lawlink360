/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : section_divider.dart
/// Purpose : Divider used between navigator items.
/// ------------------------------------------------------------

import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 0.5,
    );
  }
}