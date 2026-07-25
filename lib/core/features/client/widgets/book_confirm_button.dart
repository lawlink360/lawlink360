import 'package:flutter/material.dart';
import 'package:lawlink360/core/features/client/screens/payment_screen.dart';

class BookConfirmButton extends StatelessWidget {
  const BookConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5E5),
            ),
          ),
        ),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              // Debug print
              print("🔵🔵🔵 CONFIRM BOOKING BUTTON PRESSED 🔵🔵🔵");
              
              // Show snackbar for visual feedback
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Navigating to Payment..."),
                  duration: Duration(milliseconds: 800),
                ),
              );
              
              // Navigate
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentScreen(),
                ),
              );
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text(
              "Confirm Booking",
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
        ),
      ),
    );
  }
}