import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/conversation_model.dart';
import '../models/message_model.dart';
import '../models/message_type.dart';
import 'conversation_provider.dart';
import 'message_provider.dart';

/// All conversations, unwrapped from their AsyncValue.
///
/// Returns an empty list while loading or on error. Mirrors the
/// `allAppointmentsProvider` pattern used in the appointments feature.
final allConversationsProvider =
    Provider<List<ConversationModel>>((ref) {
  final state = ref.watch(conversationProvider);
  return state.when(
    data: (conversations) => conversations,
    loading: () => const <ConversationModel>[],
    error: (_, _) => const <ConversationModel>[],
  );
});

/// All messages, unwrapped from their AsyncValue.
final allMessagesProvider =
    Provider<List<MessageModel>>((ref) {
  final state = ref.watch(messageProvider);
  return state.when(
    data: (messages) => messages,
    loading: () => const <MessageModel>[],
    error: (_, _) => const <MessageModel>[],
  );
});

/// Messages that have not been read.
final unreadMessagesProvider =
    Provider<List<MessageModel>>((ref) {
  final messages = ref.watch(allMessagesProvider);
  return messages
      .where((message) => !message.isRead)
      .toList();
});

/// Messages exchanged between two parties, in either direction.
///
/// Keyed on a record of `(senderId, receiverId)` so callers can
/// request a thread without adding a new model.
final messagesBetweenProvider = Provider.family<
    List<MessageModel>,
    ({String senderId, String receiverId})>((ref, thread) {
  final messages = ref.watch(allMessagesProvider);
  return messages
      .where(
        (message) =>
            (message.senderId == thread.senderId &&
                message.receiverId == thread.receiverId) ||
            (message.senderId == thread.receiverId &&
                message.receiverId == thread.senderId),
      )
      .toList();
});

/// Messages of a given [MessageType].
final messagesByTypeProvider = Provider.family<
    List<MessageModel>,
    MessageType>((ref, type) {
  final messages = ref.watch(allMessagesProvider);
  return messages
      .where((message) => message.type == type)
      .toList();
});

/// Aggregate counts for the messaging feature.
///
/// Mirrors the shape of `AppointmentStatistics` in the appointments
/// feature. All values are derived from the current conversations and
/// messages lists; nothing is persisted.
final messagingStatisticsProvider =
    Provider<MessagingStatistics>((ref) {
  final conversations = ref.watch(allConversationsProvider);
  final messages = ref.watch(allMessagesProvider);

  final totalUnreadConversations = conversations
      .where((conversation) => conversation.unreadCount > 0)
      .length;

  final totalUnreadMessages =
      messages.where((message) => !message.isRead).length;

  return MessagingStatistics(
    totalConversations: conversations.length,
    totalMessages: messages.length,
    unreadConversations: totalUnreadConversations,
    unreadMessages: totalUnreadMessages,
  );
});

class MessagingStatistics {
  final int totalConversations;
  final int totalMessages;
  final int unreadConversations;
  final int unreadMessages;

  const MessagingStatistics({
    required this.totalConversations,
    required this.totalMessages,
    required this.unreadConversations,
    required this.unreadMessages,
  });
}