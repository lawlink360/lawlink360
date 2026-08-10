import 'message_type.dart';

class MessageModel {
  final String messageId;

  final String senderId;
  final String receiverId;

  final String message;

  final DateTime sentAt;

  final bool isRead;

  final MessageType type;

  const MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentAt,
    required this.isRead,
    required this.type,
  });
}