import 'package:flutter/material.dart';

import '../models/procedure_model.dart';

import '../widgets/estimated_time_card.dart';
import '../widgets/legal_notice_card.dart';
import '../widgets/related_laws_card.dart';
import '../widgets/required_documents_card.dart';
import 'procedure_steps_screen.dart';
import 'package:lawlink360/features/legal_navigator/views/legal_navigator.dart';
import 'package:lawlink360/features/legal_navigator/enums/content_type.dart';

class ProcedureDetailScreen extends StatelessWidget {
  final ProcedureModel procedure;

  const ProcedureDetailScreen({super.key, required this.procedure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: Text(procedure.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Overview",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Text(
                  procedure.overview,
                  style: const TextStyle(height: 1.6, color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          RequiredDocumentsCard(documents: procedure.requiredDocuments),

          const SizedBox(height: 18),

          EstimatedTimeCard(
            fee: procedure.estimatedFee,
            time: procedure.estimatedTime,
          ),

          const SizedBox(height: 18),

          RelatedLawsCard(laws: procedure.applicableLaws),

          const SizedBox(height: 18),

          const LegalNoticeCard(
            notice:
                "Always verify the latest legal requirements from the relevant authority before submitting documents.",
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text(
                "Start Step-by-Step Guide",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProcedureStepsScreen(procedure: procedure),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          LegalNavigator(
            contentType: ContentType.procedure,
            contentId: procedure.title, // Temporary
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
