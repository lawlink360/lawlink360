
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../widgets/chat_header.dart';
import '../widgets/chat_secure_chat_card.dart';
import '../widgets/chat_date_divider.dart';
import '../widgets/chat_lawyer_message.dart';
import '../widgets/chat_client_message.dart';
import '../widgets/chat_document_message.dart';
import '../widgets/chat_quick_action_bar.dart';
import '../widgets/chat_message_input_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const ChatHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                physics: const BouncingScrollPhysics(),
                children: const [
                  ChatSecureChatCard(),
                  SizedBox(height: AppSpacing.lg),
                  ChatDateDivider(),
                  SizedBox(height: AppSpacing.lg),
                  ChatLawyerMessage(),
                  ChatClientMessage(),
                  ChatLawyerMessage(),
                  ChatClientMessage(),
                  ChatDocumentMessage(),
                  ChatClientMessage(),
                  SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
            const ChatQuickActionBar(),
            const ChatMessageInputBar(),
          ],
        ),
      ),
    );
  }
}
