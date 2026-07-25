import 'package:flutter/material.dart';

class BookDateCard extends StatelessWidget {
  const BookDateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Select Date",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D1B2A),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [

              DateCard(day: "Mon", date: "21", selected: true),

              SizedBox(width: 12),

              DateCard(day: "Tue", date: "22"),

              SizedBox(width: 12),

              DateCard(day: "Wed", date: "23"),

              SizedBox(width: 12),

              DateCard(day: "Thu", date: "24"),

              SizedBox(width: 12),

              DateCard(day: "Fri", date: "25"),

            ],
          ),
        ),
      ],
    );
  }
}

class DateCard extends StatelessWidget {

  final String day;
  final String date;
  final bool selected;

  const DateCard({
    super.key,
    required this.day,
    required this.date,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 70,

      decoration: BoxDecoration(
        color: selected
            ? const Color(0xffD4AF37)
            : Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: selected
              ? const Color(0xffD4AF37)
              : Colors.grey.shade300,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            day,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            date,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: selected
                  ? Colors.white
                  : const Color(0xff0D1B2A),
            ),
          ),

        ],
      ),
    );
  }
}