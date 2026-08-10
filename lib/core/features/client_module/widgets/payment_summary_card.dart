import 'package:flutter/material.dart';

class PaymentSummaryCard extends StatelessWidget {
  const PaymentSummaryCard({super.key});

  Widget _row(String title, String value,
      {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? const Color(0xFF0D1B2A),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Appointment Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 18),

          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFF4F4F4),
              child: Icon(
                Icons.person,
                color: Color(0xFF0D1B2A),
              ),
            ),
            title: Text(
              "Adv. Ahmed Khan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("Criminal Lawyer"),
          ),

          const Divider(height: 30),

          _row("Consultation", "Video Call"),
          _row("Date", "20 July 2026"),
          _row("Time", "11:00 AM"),
          _row("Consultation Fee", "PKR 2,300"),
          _row("Service Charges", "PKR 200"),

          const Divider(height: 30),

          _row(
            "Total",
            "PKR 2,500",
            isTotal: true,
            color: const Color(0xFFD4AF37),
          ),
        ],
      ),
    );
  }
}