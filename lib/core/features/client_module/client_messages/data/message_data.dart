import '../models/conversation_model.dart';
import '../models/message_model.dart';
import '../models/message_type.dart';

class MessageData {
  static final List<ConversationModel> conversations = [
    ConversationModel(
      conversationId: "CONV001",
      clientId: "CLIENT001",
      lawyerId: "LAW001",
      lawyerName: "Adv. Ahmad Khan",
      lawyerImage: "assets/images/profile_face.png",
      lastMessage: "Your hearing is scheduled for next week.",
      lastMessageTime: DateTime.now(),
      unreadCount: 2,
      caseId: "CASE001",
    ),

    ConversationModel(
      conversationId: "CONV002",
      clientId: "CLIENT001",
      lawyerId: "LAW002",
      lawyerName: "Adv. Sarah Malik",
      lawyerImage: "assets/images/profile_face.png",
      lastMessage: "Thank you for sharing the documents.",
      lastMessageTime: DateTime.now(),
      unreadCount: 0,
      caseId: "CASE002",
    ),
  ];

  static final List<MessageModel> messages = [
    MessageModel(
      messageId: "MSG001",
      senderId: "LAW001",
      receiverId: "CLIENT001",
      message: "Good morning.",
      sentAt: DateTime.now(),
      isRead: true,
      type: MessageType.text,
    ),

    MessageModel(
      messageId: "MSG002",
      senderId: "CLIENT001",
      receiverId: "LAW001",
      message: "Good morning, Sir.",
      sentAt: DateTime.now(),
      isRead: true,
      type: MessageType.text,
    ),

    MessageModel(
      messageId: "MSG003",
      senderId: "LAW001",
      receiverId: "CLIENT001",
      message: "Your next hearing has been fixed for next Tuesday.",
      sentAt: DateTime.now(),
      isRead: false,
      type: MessageType.text,
    ),
  ];
}