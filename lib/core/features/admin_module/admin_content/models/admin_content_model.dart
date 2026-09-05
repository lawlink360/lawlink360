import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

class AdminContentModel {
  final String id;
  final String title;
  final String description;
  final String content;
  final String category;
  final String authorId;
  final String authorName;
  final ContentStatus status;
  final String? featuredImageUrl;
  final String? relatedLaw;
  final String? relatedCase;
  final String? relatedProcedure;
  final int viewCount;
  final int likeCount;
  final int shareCount;
  final bool isFeatured;
  final DateTime? publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminContentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.authorId,
    required this.authorName,
    required this.status,
    this.featuredImageUrl,
    this.relatedLaw,
    this.relatedCase,
    this.relatedProcedure,
    this.viewCount = 0,
    this.likeCount = 0,
    this.shareCount = 0,
    this.isFeatured = false,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  AdminContentModel copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    String? category,
    String? authorId,
    String? authorName,
    ContentStatus? status,
    String? featuredImageUrl,
    String? relatedLaw,
    String? relatedCase,
    String? relatedProcedure,
    int? viewCount,
    int? likeCount,
    int? shareCount,
    bool? isFeatured,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminContentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      status: status ?? this.status,
      featuredImageUrl: featuredImageUrl ?? this.featuredImageUrl,
      relatedLaw: relatedLaw ?? this.relatedLaw,
      relatedCase: relatedCase ?? this.relatedCase,
      relatedProcedure: relatedProcedure ?? this.relatedProcedure,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      shareCount: shareCount ?? this.shareCount,
      isFeatured: isFeatured ?? this.isFeatured,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'category': category,
      'authorId': authorId,
      'authorName': authorName,
      'status': status.name,
      'featuredImageUrl': featuredImageUrl,
      'relatedLaw': relatedLaw,
      'relatedCase': relatedCase,
      'relatedProcedure': relatedProcedure,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'shareCount': shareCount,
      'isFeatured': isFeatured,
      'publishedAt': publishedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AdminContentModel.fromMap(Map<String, dynamic> map) {
    return AdminContentModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      content: map['content'] as String? ?? '',
      category: map['category'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      authorName: map['authorName'] as String? ?? '',
      status: contentStatusFromString(
  map['status'] as String?,
),
      featuredImageUrl: map['featuredImageUrl'] as String?,
      relatedLaw: map['relatedLaw'] as String?,
      relatedCase: map['relatedCase'] as String?,
      relatedProcedure: map['relatedProcedure'] as String?,
      viewCount: map['viewCount'] as int? ?? 0,
      likeCount: map['likeCount'] as int? ?? 0,
      shareCount: map['shareCount'] as int? ?? 0,
      isFeatured: map['isFeatured'] as bool? ?? false,
      publishedAt: _parseDate(map['publishedAt']),
      createdAt: _parseDate(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDate(map['updatedAt']) ?? DateTime.now(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }
}