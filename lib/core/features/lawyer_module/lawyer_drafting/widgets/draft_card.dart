import 'package:flutter/material.dart';

import '../models/draft_model.dart';

class DraftCard extends StatelessWidget {
  const DraftCard({
    super.key,
    required this.draft,
    required this.onTap,
    this.onDelete,
  });

  final DraftModel draft;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.025),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================================================
              // DOCUMENT ICON
              // ====================================================

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: navy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: navy,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              // ====================================================
              // DRAFT INFORMATION
              // ====================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      draft.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      draft.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: gold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    if (draft.clientName != null &&
                        draft.clientName!.trim().isNotEmpty)
                      Text(
                        draft.clientName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),

                    if (draft.caseTitle != null &&
                        draft.caseTitle!.trim().isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        draft.caseTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ====================================================
              // STATUS + DATE
              // ====================================================

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _StatusBadge(
                    status: draft.status,
                  ),

                  const SizedBox(height: 7),

                  Text(
                    _formatDate(draft.updatedAt),
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),

                  if (onDelete != null) ...[
                    const SizedBox(height: 4),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      iconSize: 19,
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Color(0xFF9CA3AF),
                      ),
                      onSelected: (value) {
                        if (value == 'delete') {
                          onDelete!();
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ================================================================
// STATUS BADGE
// ================================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final String status;

  static const Color navy = Color(0xFF13294B);
static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.trim().toLowerCase();

    Color backgroundColor;
    Color textColor;

    switch (normalizedStatus) {
      case 'completed':
        backgroundColor = Colors.green.withValues(alpha: 0.10);
        textColor = Colors.green.shade700;
        break;

      case 'final':
      case 'finalized':
        backgroundColor = gold.withValues(alpha: 0.15);
        textColor = const Color(0xFF9A7A00);
        break;

      case 'sent':
        backgroundColor = Colors.blue.withValues(alpha: 0.10);
        textColor = Colors.blue.shade700;
        break;

      case 'draft':
      default:
        backgroundColor = navy.withValues(alpha: 0.08);
        textColor = navy;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}