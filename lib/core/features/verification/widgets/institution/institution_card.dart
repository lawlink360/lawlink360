import 'package:flutter/material.dart';
import '../../models/verification_institution.dart';

class InstitutionCard extends StatelessWidget {
  final VerificationInstitution institution;
  final VoidCallback? onTap;

  const InstitutionCard({
    super.key,
    required this.institution,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    institution.color.withOpacity(0.15),
                child: Icon(
                  institution.icon,
                  color: institution.color,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      institution.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      institution.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  "${institution.serviceCount}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}