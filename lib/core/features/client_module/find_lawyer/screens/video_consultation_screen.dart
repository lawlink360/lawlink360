import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../widgets/video_app_bar.dart';
import '../widgets/video_lawyer_info.dart';
import '../widgets/video_main_view.dart';
import '../widgets/video_control_bar.dart';
import '../widgets/video_bottom_tools.dart';

class VideoConsultationScreen extends StatelessWidget {
  const VideoConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const VideoAppBar(),
            const SizedBox(height: AppSpacing.sm),
            const VideoLawyerInfo(),
            const SizedBox(height: AppSpacing.md),
            const Expanded(
              child: VideoMainView(),
            ),
            const SizedBox(height: AppSpacing.lg),
            const VideoControlBar(),
            const SizedBox(height: AppSpacing.md),
            const VideoBottomTools(),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
