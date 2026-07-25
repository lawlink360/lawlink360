import 'package:flutter/material.dart';

class BookingHomeButton extends StatelessWidget {
  const BookingHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: () {
          // SAFE NAVIGATION - CHECK IF CAN POP FIRST
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            // If can't pop, do nothing or navigate to home
          }
        },
        icon: const Icon(Icons.home_outlined),
        label: const Text(
          "Return to Dashboard",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4AF37),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}