class ClientPostModel {
  final String id;
  final String clientId;
  final String clientName;
  final String? clientImageUrl;

  /// Case / Question / Query
  final String postType;

  final String title;
  final String description;

  /// Legal category selected by the client.
  final String legalCategory;

  /// City / area where the matter is located.
  final String location;

  /// Preferred consultation method.
  /// chat / voice / video / in-person
  final String consultationPreference;

  /// Attachment names or references.
  ///
  /// This remains backend-friendly. Actual file storage can be
  /// connected later without changing the post structure.
  final List<String> attachments;

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
    this.legalCategory = '',
    this.location = '',
    this.consultationPreference = 'chat',
    this.attachments = const [],
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
    String? legalCategory,
    String? location,
    String? consultationPreference,
    List<String>? attachments,
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
      legalCategory: legalCategory ?? this.legalCategory,
      location: location ?? this.location,
      consultationPreference:
          consultationPreference ?? this.consultationPreference,
      attachments: attachments ?? this.attachments,
      postedAt: postedAt ?? this.postedAt,
      replyCount: replyCount ?? this.replyCount,
    );
  }
}