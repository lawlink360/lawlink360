import 'package:flutter/material.dart';

class PremiumHeader extends StatelessWidget {
  const PremiumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 35),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E3A8A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP BAR
            Row(
              children: [

                /// LAWLINK360 LOGO
                Image.asset(
                  'assets/logos/lawlink360_transparent_logo.png',
                  height: 42,
                ),

                const Spacer(),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.12),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// TITLE
            Row(
              children: const [

                Icon(
                  Icons.verified_user_rounded,
                  color: Color(0xFFD4AF37),
                  size: 34,
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Verification Hub",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "One Gateway, Multiple Verified Services",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 22),

            /// TRUST BADGE
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.10),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 1.2,
                ),
              ),

              child: Row(
                children: [

                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Text(
                          "Trusted Official Gateway",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          "Government & Judicial Services",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}