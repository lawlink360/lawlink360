import 'package:flutter/material.dart';

class VoiceCallLawyerInfo extends StatelessWidget {
  const VoiceCallLawyerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: const [

          Text(
            "Adv. Ahmed Khan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.verified,
                color: Color(0xFFD4AF37),
                size: 18,
              ),

              SizedBox(width: 6),

              Text(
                "Verified Criminal Lawyer",
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 15,
                ),
              ),
            ],
          ),

          SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.circle,
                color: Colors.green,
                size: 10,
              ),

              SizedBox(width: 6),

              Text(
                "Connected • Voice Call",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}