import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/repositories/message_repository.dart';

import '../models/conversation_model.dart';

/// Provides a single shared [MessageRepository] for the messaging feature.
///
/// The repository is stateless and const, so a plain `Provider` is
/// sufficient. Both notifiers read it through this provider.
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return const MessageRepository();
});

/// Owns the conversations list for the client messaging feature.
///
/// This is synchronous and read-only. The underlying data source
/// (`MessageData.conversations`) has no mutation path, so no write
/// operations are exposed.
final conversationProvider =
    NotifierProvider<ConversationsNotifier, AsyncValue<List<ConversationModel>>>(
  ConversationsNotifier.new,
);

class ConversationsNotifier
    extends Notifier<AsyncValue<List<ConversationModel>>> {
  List<ConversationModel> _conversations = [];

  @override
  AsyncValue<List<ConversationModel>> build() {
    final repository = ref.watch(messageRepositoryProvider);
    _conversations = repository.getAllConversations();
    return AsyncData(_conversations);
  }

  /// Unmodifiable view of the current conversations.
  List<ConversationModel> get conversations =>
      List<ConversationModel>.unmodifiable(_conversations);

  /// Total number of conversations.
  int get totalConversations => _conversations.length;

  /// Sum of `unreadCount` across all conversations.
  int get totalUnreadCount => _conversations.fold(
        0,
        (sum, conversation) => sum + conversation.unreadCount,
      );

  /// Returns the conversation with [conversationId], or `null`.
  ConversationModel? getConversationById(String conversationId) {
    for (final conversation in _conversations) {
      if (conversation.conversationId == conversationId) {
        return conversation;
      }
    }
    return null;
  }

  /// Returns every conversation whose clientId matches [clientId].
  List<ConversationModel> getConversationsForClient(String clientId) {
    return _conversations
        .where((conversation) => conversation.clientId == clientId)
        .toList();
  }

  /// Returns every conversation whose lawyerId matches [lawyerId].
  List<ConversationModel> getConversationsForLawyer(String lawyerId) {
    return _conversations
        .where((conversation) => conversation.lawyerId == lawyerId)
        .toList();
  }

  /// Reloads conversations from the repository.
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repository = ref.read(messageRepositoryProvider);
    _conversations = repository.getAllConversations();
    state = AsyncData(_conversations);
  }
}