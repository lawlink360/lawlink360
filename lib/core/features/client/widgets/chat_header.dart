import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),

          const CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFFD4AF37),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Adv. Ahmed Khan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Criminal Lawyer",
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),

          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 1,
                child: Text("View Profile"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Block"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("Report"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}