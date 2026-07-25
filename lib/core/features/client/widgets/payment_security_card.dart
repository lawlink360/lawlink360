import 'package:flutter/material.dart';

class PaymentSecurityCard extends StatelessWidget {
  const PaymentSecurityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.lock,
            color: Colors.green,
            size: 30,
          ),

          SizedBox(width: 14),

          Expanded(
            child: Text(
              "Your payment is protected with 256-bit SSL encryption. LawLink360 never stores your card details.",
              style: TextStyle(
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}