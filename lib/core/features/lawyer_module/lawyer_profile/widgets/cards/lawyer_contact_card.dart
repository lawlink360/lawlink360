import 'package:flutter/material.dart';

class LawyerContactCard extends StatelessWidget {
  const LawyerContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSection(
      title: 'Contact Information',
      child: Column(
        children: [
          _ContactItem(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: '+92 300 1234567',
          ),
          Divider(
            height: 24,
            color: Color(0xFFE8EDF3),
          ),
          _ContactItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: 'lawyer@lawlink360.com',
          ),
          Divider(
            height: 24,
            color: Color(0xFFE8EDF3),
          ),
          _ContactItem(
            icon: Icons.location_on_outlined,
            title: 'Address',
            value: 'Lahore, Punjab, Pakistan',
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2563EB),
            size: 23,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF0F1B35),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF64748B),
          size: 23,
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _ProfileSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F1B35),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE8EDF3),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}