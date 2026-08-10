import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFF0D1B2A),

      body: SafeArea(
        child: Column(
          children: const [

            VoiceCallAppBar(),

            SizedBox(height: 20),

            VoiceCallLawyerInfo(),

            SizedBox(height: 30),

            Expanded(
              child: Center(
                child: VoiceCallAvatar(),
              ),
            ),

            SizedBox(height: 20),

            VoiceCallControlBar(),

            SizedBox(height: 20),

            VoiceCallBottomTools(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}