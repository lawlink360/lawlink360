import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_document_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_status_chip.dart';

class VerificationDocumentCard extends StatelessWidget {
  final VerificationDocumentModel document;
  final VoidCallback? onTap;

  const VerificationDocumentCard({
    super.key,
    required this.document,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _documentIcon(document.documentType),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.documentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      document.documentType,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color,
                      ),
                    ),
                    if (document.documentNumber.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        'No: ${document.documentNumber}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              VerificationStatusChip(
                status: document.status,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _documentIcon(String documentType) {
    final type = documentType.toLowerCase();

    if (type.contains('cnic') || type.contains('identity')) {
      return Icons.badge_outlined;
    }

    if (type.contains('license') ||
        type.contains('bar council') ||
        type.contains('certificate')) {
      return Icons.workspace_premium_outlined;
    }

    if (type.contains('degree') ||
        type.contains('education')) {
      return Icons.school_outlined;
    }

    if (type.contains('address')) {
      return Icons.location_on_outlined;
    }

    return Icons.description_outlined;
  }
}