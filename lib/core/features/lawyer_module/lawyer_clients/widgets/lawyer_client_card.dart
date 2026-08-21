import 'package:flutter/material.dart';

class LawyerClientCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String city;
  final String caseTitle;
  final String caseStatus;
  final String lastActivity;
  final int activeCases;
  final VoidCallback? onProfile;
  final VoidCallback? onChat;

  const LawyerClientCard({
    super.key,
    required this.name,
    this.imageUrl,
    required this.city,
    required this.caseTitle,
    required this.caseStatus,
    required this.lastActivity,
    required this.activeCases,
    this.onProfile,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // ==================================================
          // CLIENT INFORMATION
          // ==================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CLIENT IMAGE
              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  color: Color(0xFFD4AF37),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 38,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 38,
                        ),
                ),
              ),

              const SizedBox(width: 14),

              // CLIENT DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      caseTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.redAccent,
                          size: 17,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            city,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ONLINE INDICATOR
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ==================================================
          // CLIENT STATUS / CASE COUNT
          // ==================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$activeCases Active Cases',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Color(0xFF22C55E),
                    size: 9,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    caseStatus,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              lastActivity,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10.5,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ==================================================
          // PROFILE + CHAT BUTTONS
          // ==================================================

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onProfile,
                  icon: const Icon(
                    Icons.person_outline_rounded,
                    size: 18,
                  ),
                  label: const Text('Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0D213A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onChat,
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 18,
                  ),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0D213A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(28),
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