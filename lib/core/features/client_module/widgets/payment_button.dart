import 'package:flutter/material.dart';
import 'package:lawlink360/core/features/client_module/screens/booking_success_screen.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEAEAEA))),
        ),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
  onPressed: () {
  debugPrint("PAY BUTTON PRESSED");

  final navigator = Navigator.of(context);

  debugPrint("Navigator found: $navigator");

  navigator.push(
    MaterialPageRoute(
      builder: (context) {
        debugPrint("BUILDING SUCCESS SCREEN");
        return const BookingSuccessScreen();
      },
    ),
  );

  },

  icon: const Icon(Icons.lock),
  label: const Text(
    "Pay PKR 5,300",
    style: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFD4AF37),
    foregroundColor: Colors.white,
  ),
)
        ),
      ),
    );
  }
}
