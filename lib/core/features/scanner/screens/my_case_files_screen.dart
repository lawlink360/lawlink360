import 'package:flutter/material.dart';

import '../widgets/my_case_folder_card.dart';

class MyCaseFilesScreen extends StatelessWidget {
  const MyCaseFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Case Files",
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          MyCaseFolderCard(
            title: "Property Dispute",
            subtitle: "Lahore High Court",
            documents: 12,
            onTap: () {},
          ),

          MyCaseFolderCard(
            title: "Family Matter",
            subtitle: "Family Court",
            documents: 5,
            onTap: () {},
          ),

          MyCaseFolderCard(
            title: "Criminal Case",
            subtitle: "Sessions Court",
            documents: 8,
            onTap: () {},
          ),

          MyCaseFolderCard(
            title: "Personal Documents",
            subtitle: "CNIC • Passport • Certificates",
            documents: 15,
            onTap: () {},
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD4AF37),
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Create New Case File (Coming Next)"),
            ),
          );
        },
        icon: const Icon(Icons.create_new_folder_outlined),
        label: const Text("New Case"),
      ),
    );
  }
}