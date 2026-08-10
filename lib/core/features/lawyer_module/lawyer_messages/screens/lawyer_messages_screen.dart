import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/client_messages/data/message_data.dart';
import 'package:lawlink360/core/features/client_module/client_messages/widgets/conversation_card.dart';
import 'package:lawlink360/core/features/client_module/client_messages/widgets/empty_messages_widget.dart';

import 'lawyer_chat_screen.dart';

class LawyerMessagesScreen extends StatelessWidget {
  const LawyerMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = MessageData.conversations;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: conversations.isEmpty
          ? const EmptyMessagesWidget()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];

                return ConversationCard(
                  conversation: conversation,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LawyerChatScreen(conversation: conversation),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
