import 'package:flutter/material.dart';

class LegalNoticeCard extends StatelessWidget {
  final String notice;

  const LegalNoticeCard({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
        ),
        title: const Text("Important Legal Notice"),
        subtitle: Text(notice),
      ),
    );
  }
}