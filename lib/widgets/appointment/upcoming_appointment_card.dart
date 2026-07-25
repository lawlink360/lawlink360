import 'package:flutter/material.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  const UpcomingAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xff102542),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upcoming Appointment",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xffD4AF37),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.calendar_today, color: Colors.white),
                ),

                const SizedBox(width: 15),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Adv. Ahmed Khan",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Civil Suit Consultation",
                        style: TextStyle(color: Colors.white70),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Today • 3:30 PM",
                        style: TextStyle(
                          color: Color(0xffD4AF37),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text("Join Meeting"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF13294B),
                      side: const BorderSide(
                        color: Color(0xFF13294B),
                        width: 1.2,
                      ),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text("Details"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
