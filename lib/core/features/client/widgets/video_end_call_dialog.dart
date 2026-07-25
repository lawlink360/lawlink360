import 'package:flutter/material.dart';

class VideoEndCallDialog {
  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "End Consultation?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to end this video consultation?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Exit video screen
              },
              child: const Text("End Call"),
            ),
          ],
        );
      },
    );
  }
}