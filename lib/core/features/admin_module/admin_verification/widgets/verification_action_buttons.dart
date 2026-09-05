import 'package:flutter/material.dart';

class VerificationActionButtons extends StatelessWidget {
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onMarkUnderReview;
  final bool isLoading;

  const VerificationActionButtons({
    super.key,
    this.onApprove,
    this.onReject,
    this.onMarkUnderReview,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        if (onMarkUnderReview != null)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onMarkUnderReview,
              icon: const Icon(Icons.rate_review_outlined),
              label: const Text('Mark Under Review'),
            ),
          ),
        if (onMarkUnderReview != null &&
            (onApprove != null || onReject != null))
          const SizedBox(height: 10),
        Row(
          children: [
            if (onReject != null)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReject,
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Reject'),
                ),
              ),
            if (onReject != null && onApprove != null)
              const SizedBox(width: 10),
            if (onApprove != null)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onApprove,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Approve'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}