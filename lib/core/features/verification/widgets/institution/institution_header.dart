import 'package:flutter/material.dart';
import '../../models/verification_institution.dart';

class InstitutionHeader extends StatelessWidget {
  final VerificationInstitution institution;

  const InstitutionHeader({
    super.key,
    required this.institution,
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
                      color: Colors.white.withOpacity(0.12),
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

                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_balance_rounded,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.15),
              child: Icon(
                institution.icon,
                color: const Color(0xFFD4AF37),
                size: 32,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              institution.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              institution.description,
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
                color: Colors.white.withOpacity(0.10),
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
                    "${institution.serviceCount} Online Services",
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