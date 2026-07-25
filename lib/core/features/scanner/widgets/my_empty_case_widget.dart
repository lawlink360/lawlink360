import 'package:flutter/material.dart';

class MyEmptyCaseWidget extends StatelessWidget {
  const MyEmptyCaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open_outlined,
                size: 60,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "No Case Files Yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D1B2A),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Create your first Case File to organize scanned legal documents.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}