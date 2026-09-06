import 'package:flutter/material.dart';
import '../../models/verification_category.dart';

class CategoryServiceHeader extends StatelessWidget {
  final VerificationCategory category;
  final int totalServices;

  const CategoryServiceHeader({
    super.key,
    required this.category,
    required this.totalServices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
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
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
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
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white.withValues(alpha:0.15),
              child: Icon(
                category.icon,
                color: const Color(0xFFD4AF37),
                size: 30,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              category.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              category.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.10),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$totalServices Official Services",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}