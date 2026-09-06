import 'package:flutter/material.dart';

class BookSummaryCard extends StatelessWidget {
  const BookSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Appointment Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff0D1B2A),
            ),
          ),

          const SizedBox(height: 18),

          _summaryRow("Lawyer", "Adv. Ahmed Khan"),
          _summaryRow("Date", "21 July 2026"),
          _summaryRow("Time", "11:00 AM"),
          _summaryRow("Consultation", "In Person"),

          const Divider(height: 30),

          _summaryRow("Consultation Fee", "Rs. 5,000"),
          _summaryRow("Platform Fee", "Rs. 300"),

          const Divider(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [

              Text(
                "Total",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Rs. 5,300",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffD4AF37),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}