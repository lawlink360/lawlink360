import 'package:flutter/material.dart';

class ChatLawyerMessage extends StatelessWidget {
  const ChatLawyerMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFD4AF37),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Good morning! Please tell me about your legal issue. I'll guide you through the next steps.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "09:15 AM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}