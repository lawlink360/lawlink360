import 'package:flutter/material.dart';

class LawyerClientsRequestCard extends StatelessWidget {
  final String clientName;
  final String requestType;
  final String message;
  final String requestedAt;
  final String? imageUrl;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const LawyerClientsRequestCard({
    super.key,
    required this.clientName,
    required this.requestType,
    required this.message,
    required this.requestedAt,
    this.imageUrl,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // CLIENT HEADER
          // --------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5F7FB),
                  border: Border.all(
                    color:
                        const Color(0xFFD4AF37).withValues(alpha:0.35),
                  ),
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Icon(
                              Icons.person_outline_rounded,
                              color: Color(0xFF13294B),
                              size: 26,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person_outline_rounded,
                          color: Color(0xFF13294B),
                          size: 26,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      requestType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      requestedAt,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Pending',
                  style: TextStyle(
                    color: Color(0xFF8A6A00),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // --------------------------------------------------
          // REQUEST MESSAGE
          // --------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // --------------------------------------------------
          // ACTION BUTTONS
          // --------------------------------------------------
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(
                      color: Color(0xFFE5E7EB),
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      44,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(
                      double.infinity,
                      44,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}