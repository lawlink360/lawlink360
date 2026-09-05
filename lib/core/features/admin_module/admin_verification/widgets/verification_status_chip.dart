import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_status_model.dart';

class VerificationStatusChip extends StatelessWidget {
  final String status;

  const VerificationStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusModel = VerificationStatusModel.fromValue(status);

    IconData icon;
    Color color;

    if (statusModel.isApproved) {
      icon = Icons.verified_rounded;
      color = Colors.green;
    } else if (statusModel.isRejected) {
      icon = Icons.cancel_rounded;
      color = Colors.red;
    } else if (statusModel.isUnderReview) {
      icon = Icons.rate_review_rounded;
      color = Colors.orange;
    } else {
      icon = Icons.pending_actions_rounded;
      color = Colors.blue;
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            statusModel.label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}