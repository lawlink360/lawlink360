class ConversationModel {
  final String conversationId;
  final String clientId;
  final String lawyerId;

  final String lawyerName;
  final String lawyerImage;

  final String lastMessage;
  final DateTime lastMessageTime;

  final int unreadCount;

  final String? caseId;

  const ConversationModel({
    required this.conversationId,
    required this.clientId,
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.caseId,
  });
}