import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class SmartCameraTopModes extends StatefulWidget {
  const SmartCameraTopModes({super.key});

  @override
  State<SmartCameraTopModes> createState() => _SmartCameraTopModesState();
}

class _SmartCameraTopModesState extends State<SmartCameraTopModes> {
  int selectedIndex = 0;

  final List<String> modes = [
    'Document',
    'ID',
    'Book',
    'Whiteboard',
    'OCR',
    'Translate',
    'QR',
    'ID Photo',
    'Time',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: modes.length,
        separatorBuilder: (_, _) => const SizedBox(
          width: AppSpacing.md,
        ),
        itemBuilder: (context, index) {
          final bool selected = index == selectedIndex;

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    modes[index],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: selected
                          ? AppColors.accent
                          : AppColors.darkTextSecondary,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: selected ? 42 : 0,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}