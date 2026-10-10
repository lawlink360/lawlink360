import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_model.dart';
import '../models/message_type.dart';
import 'conversation_provider.dart';

/// Owns the messages list for the client messaging feature.
///
/// This is synchronous and read-only. The underlying data source
/// (`MessageData.messages`) has no mutation path, so no write
/// operations are exposed.
///
/// Reads the shared [messageRepositoryProvider] defined in
/// `conversation_provider.dart`.
final messageProvider =
    NotifierProvider<MessagesNotifier, AsyncValue<List<MessageModel>>>(
  MessagesNotifier.new,
);

class MessagesNotifier
    extends Notifier<AsyncValue<List<MessageModel>>> {
  List<MessageModel> _messages = [];

  @override
  AsyncValue<List<MessageModel>> build() {
    final repository = ref.watch(messageRepositoryProvider);
    _messages = repository.getAllMessages();
    return AsyncData(_messages);
  }

  /// Unmodifiable view of the current messages.
  List<MessageModel> get messages =>
      List<MessageModel>.unmodifiable(_messages);

  /// Total number of messages.
  int get totalMessages => _messages.length;

  /// Number of messages that have not been read.
  int get unreadCount =>
      _messages.where((message) => !message.isRead).length;

  /// Returns the message with [messageId], or `null`.
  MessageModel? getMessageById(String messageId) {
    for (final message in _messages) {
      if (message.messageId == messageId) {
        return message;
      }
    }
    return null;
  }

  /// Returns every message exchanged between [senderId] and
  /// [receiverId] in either direction.
  List<MessageModel> getMessagesBetween(
    String senderId,
    String receiverId,
  ) {
    return _messages
        .where(
          (message) =>
              (message.senderId == senderId &&
                  message.receiverId == receiverId) ||
              (message.senderId == receiverId &&
                  message.receiverId == senderId),
        )
        .toList();
  }

  /// Returns every message whose type matches [type].
  List<MessageModel> getMessagesByType(MessageType type) {
    return _messages
        .where((message) => message.type == type)
        .toList();
  }

  /// Reloads messages from the repository.
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repository = ref.read(messageRepositoryProvider);
    _messages = repository.getAllMessages();
    state = AsyncData(_messages);
  }
}