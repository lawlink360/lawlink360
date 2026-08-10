import 'package:flutter/material.dart';

import '../models/case_models.dart';
import 'case_status_badge.dart';

class CaseCard extends StatelessWidget {
  final CaseModel caseItem;
  final VoidCallback? onTap;

  const CaseCard({
    super.key,
    required this.caseItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header
              Row(
                children: [

                  Expanded(
                    child: Text(
                      caseItem.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CaseStatusBadge(
                    status: caseItem.status,
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                "Case No: ${caseItem.caseNumber}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              _infoRow(
                Icons.person_outline,
                "Client",
                caseItem.clientName,
              ),

              const SizedBox(height: 10),

              _infoRow(
                Icons.gavel_outlined,
                "Lawyer",
                caseItem.lawyerName,
              ),

              const SizedBox(height: 10),

              _infoRow(
                Icons.account_balance_outlined,
                "Court",
                caseItem.courtName,
              ),

              const Divider(height: 30),

              Row(
                children: [

                  Expanded(
                    child: _bottomInfo(
                      Icons.calendar_today_outlined,
                      "Next Hearing",
                      "${caseItem.nextHearing.day}/${caseItem.nextHearing.month}/${caseItem.nextHearing.year}",
                    ),
                  ),

                  Expanded(
                    child: _bottomInfo(
                      Icons.update_outlined,
                      "Updated",
                      "${caseItem.lastUpdated.day}/${caseItem.lastUpdated.month}/${caseItem.lastUpdated.year}",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          size: 18,
          color: const Color(0xFF0F172A),
        ),

        const SizedBox(width: 8),

        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  Widget _bottomInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          color: Colors.grey,
          size: 18,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}