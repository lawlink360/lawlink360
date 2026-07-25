import 'package:flutter/material.dart';

class LawyerEnrollmentCard extends StatelessWidget {
  const LawyerEnrollmentCard({super.key});

  Widget row(String title,String value){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
            "Professional Enrollment",
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height:20),

          row("Punjab Bar Council","Verified"),
          row("High Court License","Active"),
          row("License No.","PBC-2026-4587"),
          row("Status","Good Standing"),

        ],
      ),
    );
  }
}