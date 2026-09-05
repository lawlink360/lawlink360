import 'package:flutter/material.dart';

import '../models/case_status_model.dart';

class CaseStatusChip extends StatelessWidget {
  final String status;

  const CaseStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color color;

    switch (status) {
      case CaseStatusModel.active:
        color = Colors.green;
        break;
      case CaseStatusModel.pending:
        color = Colors.orange;
        break;
      case CaseStatusModel.onHold:
        color = Colors.blueGrey;
        break;
      case CaseStatusModel.closed:
        color = Colors.blue;
        break;
      case CaseStatusModel.dismissed:
        color = Colors.red;
        break;
      default:
        color = theme.colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}