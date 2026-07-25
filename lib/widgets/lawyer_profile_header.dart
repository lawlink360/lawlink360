import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0D1B2A),
            Color(0xFF1B263B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [

              Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),

              Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ],
          ),

          const SizedBox(height: 25),

          /// Profile Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stack(
                children: [

                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFD4AF37),
                        width: 3,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 55,
                        color: Color(0xFF0D1B2A),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.white,
                        ),
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

                    Row(
                      children: const [

                        Icon(
                          Icons.star,
                          color: Color(0xFFD4AF37),
                          size: 18,
                        ),

                        SizedBox(width: 4),

                        Text(
                          "4.9 (124 Reviews)",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Criminal Lawyer",
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: const [

                        Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 18,
                        ),

                        SizedBox(width: 5),

                        Text(
                          "Islamabad, Pakistan",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// Chips
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [

              _chip(
                Icons.verified_user,
                "Verified Lawyer",
              ),

              _chip(
                Icons.workspace_premium,
                "10+ Years Experience",
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _chip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}