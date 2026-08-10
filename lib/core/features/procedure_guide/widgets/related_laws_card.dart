import 'package:flutter/material.dart';

class RelatedLawsCard extends StatelessWidget {
  final List<String> laws;

  const RelatedLawsCard({
    super.key,
    required this.laws,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Applicable Laws",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 14),

            ...laws.map(
              (law) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.gavel,
                      color: Color(0xFF0F172A),
                      size: 20,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(law),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}