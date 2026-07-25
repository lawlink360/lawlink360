import 'package:flutter/material.dart';

class ChatClientMessage extends StatelessWidget {
  const ChatClientMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Text(
                    "Thank you, Advocate. I have uploaded all the documents. Kindly review them.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    "09:18 AM",
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