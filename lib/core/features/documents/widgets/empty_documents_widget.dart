import 'package:flutter/material.dart';

class EmptyDocumentsWidget extends StatelessWidget {
  const EmptyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 90,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Text(
              "No Documents Found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Scanned, translated and generated documents will appear here.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}