import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xffF7F8FC),

      body: SafeArea(
        child: Column(
          children: [

            const ChatHeader(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: const [

                  ChatSecureChatCard(),

                  SizedBox(height: 20),

                  ChatDateDivider(),

                  SizedBox(height: 20),

                  ChatLawyerMessage(),

                  ChatClientMessage(),

                  ChatLawyerMessage(),

                  ChatClientMessage(),

                  ChatDocumentMessage(),

                  ChatClientMessage(),

                  SizedBox(height: 20),
                ],
              ),
            ),

            ChatQuickActionBar(),

            ChatMessageInputBar(),
          ],
        ),
      ),
    );
  }
}