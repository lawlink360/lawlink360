import 'package:flutter/material.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({
    super.key,
    this.cases = 4,
    this.meetings = 2,
    this.pendingTasks = 5,
    this.documents = 3,
    this.paymentsDue = 'Rs. 25,000',
  });

  final int cases;
  final int meetings;
  final int pendingTasks;
  final int documents;
  final String paymentsDue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 126,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _SummaryItem(
                  icon: Icons.gavel_rounded,
                  value: '$cases',
                  label: "Today's Cases",
                  iconColor: const Color(0xFF5B4BDB),
                ),
                _SummaryItem(
                  icon: Icons.people_alt_rounded,
                  value: '$meetings',
                  label: 'Meetings',
                  iconColor: const Color(0xFF20A56A),
                ),
                _SummaryItem(
                  icon: Icons.checklist_rounded,
                  value: '$pendingTasks',
                  label: 'Pending Tasks',
                  iconColor: const Color(0xFFF39C12),
                ),
                _SummaryItem(
                  icon: Icons.description_rounded,
                  value: '$documents',
                  label: 'Documents',
                  iconColor: const Color(0xFF3975D3),
                ),
                _SummaryItem(
                  icon: Icons.payments_rounded,
                  value: paymentsDue,
                  label: 'Payments Due',
                  iconColor: const Color(0xFF1D9B67),
                  compactValue: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
    this.compactValue = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;
  final bool compactValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 21,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: Colors.grey.shade400,
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compactValue ? 17 : 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}