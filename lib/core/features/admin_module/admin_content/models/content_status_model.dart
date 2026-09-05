import 'package:flutter/material.dart';

enum ContentStatus {
  draft,
  published,
  archived,
  scheduled,
}

extension ContentStatusExtension on ContentStatus {
  String get label {
    switch (this) {
      case ContentStatus.draft:
        return 'Draft';
      case ContentStatus.published:
        return 'Published';
      case ContentStatus.archived:
        return 'Archived';
      case ContentStatus.scheduled:
        return 'Scheduled';
    }
  }

  Color get color {
    switch (this) {
      case ContentStatus.draft:
        return Colors.orange;
      case ContentStatus.published:
        return Colors.green;
      case ContentStatus.archived:
        return Colors.grey;
      case ContentStatus.scheduled:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (this) {
      case ContentStatus.draft:
        return Icons.edit_note_outlined;
      case ContentStatus.published:
        return Icons.check_circle_outline;
      case ContentStatus.archived:
        return Icons.archive_outlined;
      case ContentStatus.scheduled:
        return Icons.schedule_outlined;
    }
  }
}

ContentStatus contentStatusFromString(String? value) {
  switch (value?.toLowerCase()) {
    case 'published':
      return ContentStatus.published;
    case 'archived':
      return ContentStatus.archived;
    case 'scheduled':
      return ContentStatus.scheduled;
    case 'draft':
    default:
      return ContentStatus.draft;
  }
}
