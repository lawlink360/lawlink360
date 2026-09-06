import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../widgets/voice_call_app_bar.dart';
import '../widgets/voice_call_lawyer_info.dart';
import '../widgets/voice_call_avatar.dart';
import '../widgets/voice_call_control_bar.dart';
import '../widgets/voice_call_bottom_tools.dart';

class VoiceCallScreen extends StatelessWidget {
  const VoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const VoiceCallAppBar(),
            const SizedBox(height: AppSpacing.lg),
            const VoiceCallLawyerInfo(),
            const SizedBox(height: AppSpacing.xl),
            const Expanded(
              child: Center(
                child: VoiceCallAvatar(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const VoiceCallControlBar(),
            const SizedBox(height: AppSpacing.lg),
            const VoiceCallBottomTools(),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
