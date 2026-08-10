import 'package:flutter/material.dart';

import '../models/procedure_model.dart';
import '../widgets/procedure_step_tile.dart';

class ProcedureStepsScreen extends StatelessWidget {
  final ProcedureModel procedure;

  const ProcedureStepsScreen({
    super.key,
    required this.procedure,
  });

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

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              "${procedure.steps.length} Steps to Complete This Procedure",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...procedure.steps.map(
            (step) => ProcedureStepTile(
              stepNo: step.stepNo,
              title: step.title,
              description: step.description,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("Procedure Completed"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(55),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}