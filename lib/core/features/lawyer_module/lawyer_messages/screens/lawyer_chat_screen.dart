import 'package:flutter/material.dart';
import 'package:lawlink360/core/features/client_module/client_messages/models/conversation_model.dart';
import 'package:lawlink360/core/features/client_module/client_messages/widgets/message_bubble.dart';
import 'package:lawlink360/core/features/client_module/client_messages/widgets/message_input_bar.dart';
import 'package:lawlink360/core/features/client_module/client_messages/data/message_data.dart';

class LawyerChatScreen extends StatefulWidget {
  final ConversationModel conversation;

  const LawyerChatScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<LawyerChatScreen> createState() => _LawyerChatScreenState();
}

class _LawyerChatScreenState extends State<LawyerChatScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                      color: Color(0xFF13294B),
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

          PopupMenuButton<int>(
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 1,
                child: Text("View Client Profile"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Case Documents"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Case Details"),
              ),
              PopupMenuItem(
                value: 4,
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
                  isMe: message.senderId ==
                      widget.conversation.lawyerId,
                );
              },
            ),
          ),

          MessageInputBar(
            controller: controller,
            onSend: () {
              if (controller.text.trim().isEmpty) {
                return;
              }

              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}