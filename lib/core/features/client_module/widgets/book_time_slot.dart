import 'package:flutter/material.dart';

class BookTimeSlot extends StatelessWidget {
  const BookTimeSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Available Time",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D1B2A),
          ),
        ),

        const SizedBox(height: 16),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [

            TimeChip(time: "09:00 AM"),

            TimeChip(time: "10:00 AM"),

            TimeChip(
              time: "11:00 AM",
              selected: true,
            ),

            TimeChip(time: "12:00 PM"),

            TimeChip(time: "02:00 PM"),

            TimeChip(time: "03:00 PM"),

            TimeChip(time: "04:00 PM"),

            TimeChip(time: "05:00 PM"),

          ],
        ),
      ],
    );
  }
}

class TimeChip extends StatelessWidget {

  final String time;
  final bool selected;

  const TimeChip({
    super.key,
    required this.time,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 105,
      height: 48,

      decoration: BoxDecoration(
        color: selected
            ? const Color(0xffD4AF37)
            : Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: selected
              ? const Color(0xffD4AF37)
              : Colors.grey.shade300,
        ),
      ),

      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected
                ? Colors.white
                : const Color(0xff0D1B2A),
          ),
        ),
      ),
    );
  }
}