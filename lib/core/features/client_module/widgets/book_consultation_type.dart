import 'package:flutter/material.dart';

class BookConsultationType extends StatelessWidget {
  const BookConsultationType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Consultation Type",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D1B2A),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: const [

            Expanded(
              child: ConsultationCard(
                icon: Icons.person,
                title: "In Person",
                selected: true,
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: ConsultationCard(
                icon: Icons.call,
                title: "Voice",
              ),
            ),

          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: const [

            Expanded(
              child: ConsultationCard(
                icon: Icons.videocam,
                title: "Video",
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: ConsultationCard(
                icon: Icons.chat,
                title: "Chat",
              ),
            ),

          ],
        ),

      ],
    );
  }
}

class ConsultationCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final bool selected;

  const ConsultationCard({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 92,

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

          Icon(
            icon,
            size: 28,
            color: selected
                ? Colors.white
                : const Color(0xff0D1B2A),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
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