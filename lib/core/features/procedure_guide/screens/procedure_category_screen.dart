import 'package:flutter/material.dart';

import '../data/procedure_data.dart';
import '../widgets/procedure_card.dart';
import 'procedure_detail_screen.dart';

class ProcedureCategoryScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const ProcedureCategoryScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final procedures = ProcedureData.procedures
        .where((p) => p.categoryId == categoryId)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: procedures.length,
        itemBuilder: (context, index) {
          final procedure = procedures[index];

          return ProcedureCard(
            title: procedure.title,
            overview: procedure.overview,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProcedureDetailScreen(procedure: procedure),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
