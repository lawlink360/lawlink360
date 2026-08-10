import 'package:flutter/material.dart';

class ProcedureCard extends StatelessWidget {
  final String title;
  final String overview;
  final VoidCallback? onTap;

  const ProcedureCard({
    super.key,
    required this.title,
    required this.overview,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(overview),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}