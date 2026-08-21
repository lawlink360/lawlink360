
class ClientPostModel {
  final String id;
  final String clientId;
  final String clientName;
  final String? clientImageUrl;

  /// Case / Question / Query
  final String postType;

  final String title;
  final String description;
  final DateTime postedAt;

  /// Number of lawyers who have replied.
  final int replyCount;

  const ClientPostModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    this.clientImageUrl,
    required this.postType,
    required this.title,
    required this.description,
    required this.postedAt,
    this.replyCount = 0,
  });

  ClientPostModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientImageUrl,
    String? postType,
    String? title,
    String? description,
    DateTime? postedAt,
    int? replyCount,
  }) {
    return ClientPostModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientImageUrl: clientImageUrl ?? this.clientImageUrl,
      postType: postType ?? this.postType,
      title: title ?? this.title,
      description: description ?? this.description,
      postedAt: postedAt ?? this.postedAt,
      replyCount: replyCount ?? this.replyCount,
    );
  }
}
