import 'package:meta/meta.dart';

/// A user-created folder in the Scanner 360 document library.
///
/// Folders are first-class entities. Documents reference the
/// folder they belong to through `DocumentMetadata.folderId`.
/// A folder with `parentFolderId == null` is a root folder.
@immutable
class ScannerFolder {
  const ScannerFolder({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.parentFolderId,
  });

  final String id;
  final String name;

  /// The id of the containing folder, or null for a root folder.
  final String? parentFolderId;

  final DateTime createdAt;
  final DateTime updatedAt;

  ScannerFolder copyWith({
    String? id,
    String? name,
    String? parentFolderId,
    bool clearParentFolderId = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScannerFolder(
      id: id ?? this.id,
      name: name ?? this.name,
      parentFolderId: clearParentFolderId
          ? null
          : (parentFolderId ?? this.parentFolderId),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parentFolderId': parentFolderId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ScannerFolder.fromMap(Map<String, dynamic> map) {
    return ScannerFolder(
      id: map['id'] as String,
      name: map['name'] as String,
      parentFolderId: map['parentFolderId'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScannerFolder &&
        other.id == id &&
        other.name == name &&
        other.parentFolderId == parentFolderId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        parentFolderId,
        createdAt,
        updatedAt,
      );
}