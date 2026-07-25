import 'package:flutter/material.dart';

class LawyerConsultationCard extends StatelessWidget {
  const LawyerConsultationCard({super.key});

  Widget tile(IconData icon,String title,String value){
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon,color: const Color(0xFFD4AF37)),
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:20,vertical:10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Consultation Information",
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height:20),

          tile(Icons.video_call,"Video Consultation","PKR 2500"),
          tile(Icons.call,"Voice Consultation","PKR 1800"),
          tile(Icons.chat,"Chat Consultation","PKR 1200"),
          tile(Icons.schedule,"Response Time","15 mins"),

        ],
      ),
    );
  }
}