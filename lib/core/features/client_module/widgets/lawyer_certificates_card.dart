import 'package:flutter/material.dart';

class LawyerCertificatesCard extends StatelessWidget {
  const LawyerCertificatesCard({super.key});

  Widget certificate(String title){
    return Card(
      elevation:0,
      color: const Color(0xffF5F7FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.workspace_premium,
          color: Color(0xFFD4AF37),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.visibility),
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
            "Certificates",
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height:20),

          certificate("Punjab Bar Council License"),
          certificate("LL.B Degree"),
          certificate("LL.M Degree"),
          certificate("Criminal Law Certification"),

        ],
      ),
    );
  }
}