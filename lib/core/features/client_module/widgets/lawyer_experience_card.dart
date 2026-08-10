import 'package:flutter/material.dart';

class LawyerExperienceCard extends StatelessWidget {
  const LawyerExperienceCard({super.key});

  Widget tile(String year,String title){
    return Padding(
      padding: const EdgeInsets.only(bottom:18),
      child: Row(
        children: [

          Container(
            width:70,
            alignment: Alignment.center,
            child: Text(
              year,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),
          ),

          const Icon(Icons.circle,size:12,color: Color(0xFFD4AF37)),

          const SizedBox(width:15),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          )

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
            "Professional Experience",
            style: TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height:20),

          tile("2014","Started Legal Practice"),
          tile("2017","District Courts"),
          tile("2020","High Court Practice"),
          tile("2023","Senior Criminal Advocate"),

        ],
      ),
    );
  }
}