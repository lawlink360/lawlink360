import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 0.5,
      color: AppColors.divider,
    );
  }
}
