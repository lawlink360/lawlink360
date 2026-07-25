import 'package:flutter/material.dart';

class ChatSecureChatCard extends StatelessWidget {
  const ChatSecureChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.security,
              color: Color(0xFFD4AF37),
              size: 32,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This is a secure conversation",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Your messages and documents are end-to-end encrypted.",
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: () {},
            child: const Text(
              "Learn More",
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}