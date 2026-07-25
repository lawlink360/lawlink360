import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  Widget paymentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? const Color(0xFFD4AF37)
              : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFFFF8E1),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: const Color(0xFFD4AF37),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Payment Method",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),

        const SizedBox(height: 18),

        paymentTile(
          icon: Icons.credit_card,
          title: "Credit / Debit Card",
          subtitle: "Visa • Mastercard • UnionPay",
          selected: true,
        ),

        paymentTile(
          icon: Icons.account_balance_wallet,
          title: "JazzCash",
          subtitle: "Pay using JazzCash Wallet",
        ),

        paymentTile(
          icon: Icons.phone_android,
          title: "EasyPaisa",
          subtitle: "Pay using EasyPaisa Wallet",
        ),

        paymentTile(
          icon: Icons.account_balance,
          title: "Bank Transfer",
          subtitle: "Online Bank Payment",
        ),
      ],
    );
  }
}