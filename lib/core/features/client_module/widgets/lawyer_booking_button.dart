import 'package:flutter/material.dart';

class LawyerBookingButton extends StatelessWidget {
  const LawyerBookingButton({super.key});

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          height:56,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: (){
              // Booking Screen Navigation
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text(
              "Book Appointment",
              style: TextStyle(
                fontSize:17,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}