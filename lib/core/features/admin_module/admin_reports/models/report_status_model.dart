import 'package:flutter/material.dart';

enum ReportStatus {
  pending,
  underReview,
  investigating,
  resolved,
  rejected,
  closed,
}

extension ReportStatusExtension on ReportStatus {
  String get label {
    switch (this) {
      case ReportStatus.pending:
        return 'Pending';
      case ReportStatus.underReview:
        return 'Under Review';
      case ReportStatus.investigating:
        return 'Investigating';
      case ReportStatus.resolved:
        return 'Resolved';
      case ReportStatus.rejected:
        return 'Rejected';
      case ReportStatus.closed:
        return 'Closed';
    }
  }

  Color get color {
    switch (this) {
      case ReportStatus.pending:
        return const Color(0xFFF59E0B);
      case ReportStatus.underReview:
        return const Color(0xFF3B82F6);
      case ReportStatus.investigating:
        return const Color(0xFF8B5CF6);
      case ReportStatus.resolved:
        return const Color(0xFF16A34A);
      case ReportStatus.rejected:
        return const Color(0xFFDC2626);
      case ReportStatus.closed:
        return const Color(0xFF6B7280);
    }
  }

  IconData get icon {
    switch (this) {
      case ReportStatus.pending:
        return Icons.pending_actions_rounded;
      case ReportStatus.underReview:
        return Icons.rate_review_rounded;
      case ReportStatus.investigating:
        return Icons.search_rounded;
      case ReportStatus.resolved:
        return Icons.check_circle_rounded;
      case ReportStatus.rejected:
        return Icons.cancel_rounded;
      case ReportStatus.closed:
        return Icons.lock_rounded;
    }
  }

  static ReportStatus fromString(String value) {
    switch (value.toLowerCase().replaceAll(' ', '').replaceAll('_', '')) {
      case 'underreview':
        return ReportStatus.underReview;
      case 'investigating':
        return ReportStatus.investigating;
      case 'resolved':
        return ReportStatus.resolved;
      case 'rejected':
        return ReportStatus.rejected;
      case 'closed':
        return ReportStatus.closed;
      case 'pending':
      default:
        return ReportStatus.pending;
    }
  }
}