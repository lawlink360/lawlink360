import 'package:flutter/material.dart';

import '../models/case_status.dart';

class CaseStatusBadge extends StatelessWidget {
  final CaseStatus status;

  const CaseStatusBadge({
    super.key,
    required this.status,
  });

  Color get backgroundColor {
    switch (status) {
      case CaseStatus.active:
        return Colors.green.shade100;
      case CaseStatus.pending:
        return Colors.orange.shade100;
      case CaseStatus.completed:
        return Colors.blue.shade100;
      case CaseStatus.archived:
        return Colors.grey.shade300;
    }
  }

  Color get textColor {
    switch (status) {
      case CaseStatus.active:
        return Colors.green.shade800;
      case CaseStatus.pending:
        return Colors.orange.shade800;
      case CaseStatus.completed:
        return Colors.blue.shade800;
      case CaseStatus.archived:
        return Colors.grey.shade800;
    }
  }

  String get label {
    switch (status) {
      case CaseStatus.active:
        return "Active";
      case CaseStatus.pending:
        return "Pending";
      case CaseStatus.completed:
        return "Completed";
      case CaseStatus.archived:
        return "Archived";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}