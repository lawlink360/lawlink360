import 'package:lawlink360/core/features/client_module/client_messages/data/message_data.dart';
import 'package:lawlink360/core/features/client_module/client_messages/models/conversation_model.dart';
import 'package:lawlink360/core/features/client_module/client_messages/models/message_model.dart';
import 'package:lawlink360/core/features/client_module/client_messages/models/message_type.dart';

/// Read-only data access for client messages and conversations.
///
/// The current messages data source is a pair of static in-memory
/// lists in `MessageData`. This repository wraps that source so
/// higher layers can depend on a single, explicit access point
/// without reading the data file directly.
///
/// No Firebase, Firestore, or remote data source is used at this
/// stage. This class is synchronous.
class MessageRepository {
  const MessageRepository();

  // ============================================================
  // Conversations
  // ============================================================

  /// Returns a copy of the current conversation list.
  List<ConversationModel> getAllConversations() {
    return List<ConversationModel>.from(
      MessageData.conversations,
    );
  }

  /// Returns the conversation with [conversationId],
  /// or `null` when no such conversation exists.
  ConversationModel? getConversationById(String conversationId) {
    for (final conversation in MessageData.conversations) {
      if (conversation.conversationId == conversationId) {
        return conversation;
      }
    }
    return null;
  }

  /// Returns every conversation whose [ConversationModel.clientId]
  /// matches [clientId].
  List<ConversationModel> getConversationsForClient(String clientId) {
    return MessageData.conversations
        .where((conversation) => conversation.clientId == clientId)
        .toList();
  }

  /// Returns every conversation whose [ConversationModel.lawyerId]
  /// matches [lawyerId].
  List<ConversationModel> getConversationsForLawyer(String lawyerId) {
    return MessageData.conversations
        .where((conversation) => conversation.lawyerId == lawyerId)
        .toList();
  }

  /// Returns the total number of conversations currently available.
  int getTotalConversationCount() {
    return MessageData.conversations.length;
  }

  // ============================================================
  // Messages
  // ============================================================

  /// Returns a copy of the current message list.
  List<MessageModel> getAllMessages() {
    return List<MessageModel>.from(MessageData.messages);
  }

  /// Returns the message with [messageId],
  /// or `null` when no such message exists.
  MessageModel? getMessageById(String messageId) {
    for (final message in MessageData.messages) {
      if (message.messageId == messageId) {
        return message;
      }
    }
    return null;
  }

  /// Returns every message whose sender is [senderId].
  List<MessageModel> getMessagesBySender(String senderId) {
    return MessageData.messages
        .where((message) => message.senderId == senderId)
        .toList();
  }

  /// Returns every message whose receiver is [receiverId].
  List<MessageModel> getMessagesByReceiver(String receiverId) {
    return MessageData.messages
        .where((message) => message.receiverId == receiverId)
        .toList();
  }

  /// Returns every message exchanged between [senderId] and
  /// [receiverId] in either direction.
  List<MessageModel> getMessagesBetween(
    String senderId,
    String receiverId,
  ) {
    return MessageData.messages
        .where(
          (message) =>
              (message.senderId == senderId &&
                  message.receiverId == receiverId) ||
              (message.senderId == receiverId &&
                  message.receiverId == senderId),
        )
        .toList();
  }

  /// Returns every message whose type is [type].
  List<MessageModel> getMessagesByType(MessageType type) {
    return MessageData.messages
        .where((message) => message.type == type)
        .toList();
  }

  /// Returns every unread message.
  List<MessageModel> getUnreadMessages() {
    return MessageData.messages
        .where((message) => !message.isRead)
        .toList();
  }

  /// Returns the total number of messages currently available.
  int getTotalMessageCount() {
    return MessageData.messages.length;
  }
}