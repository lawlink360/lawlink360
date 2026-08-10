import 'package:flutter/material.dart';

import '../data/message_data.dart';
import '../models/conversation_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input_bar.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;

  const ChatScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messages = MessageData.messages;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: const BackButton(),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage(widget.conversation.lawyerImage),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.lawyerName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "Online",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),

          PopupMenuButton(
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 1,
                child: Text("View Profile"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Shared Documents"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Mute Chat"),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(
                  message: message.message,
                  isMe:
                      message.senderId ==
                      widget.conversation.clientId,
                );
              },
            ),
          ),

          MessageInputBar(
            controller: controller,
            onSend: () {
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}