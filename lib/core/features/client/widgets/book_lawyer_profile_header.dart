import 'package:flutter/material.dart';

class LawyerProfileHeader extends StatelessWidget {
  const LawyerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xff0D1B2A),
            Color(0xff1B263B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [

              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffD4AF37),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 45,
                    color: Color(0xff0D1B2A),
                  ),
                ),
              ),

              const Positioned(
                bottom: 2,
                right: 2,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Adv. Ahmed Khan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Criminal Lawyer",
                  style: TextStyle(
                    color: Color(0xffD4AF37),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: const [

                    Icon(
                      Icons.star,
                      color: Color(0xffD4AF37),
                      size: 18,
                    ),

                    SizedBox(width: 4),

                    Text(
                      "4.9 (124 Reviews)",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: const [

                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 18,
                    ),

                    SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        "Islamabad, Pakistan",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white24,
                    ),
                  ),
                  child: const Text(
                    "10+ Years Experience",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}