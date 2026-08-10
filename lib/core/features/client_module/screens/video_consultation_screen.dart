import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFF0D1B2A),

      body: SafeArea(
        child: Column(
          children: const [

            VideoAppBar(),

            SizedBox(height: 12),

            VideoLawyerInfo(),

            SizedBox(height: 16),

            Expanded(
              child: VideoMainView(),
            ),

            SizedBox(height: 20),

            VideoControlBar(),

            SizedBox(height: 18),

            VideoBottomTools(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}