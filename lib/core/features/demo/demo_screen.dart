import 'package:flutter/material.dart';

import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/cards/custom_card.dart';
import '../../../widgets/inputs/custom_text_field.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LawLink360 UI Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to LawLink360",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: nameController,
                    hintText: "Enter your name",
                    prefixIcon: Icons.person_outline,
                  ),

                  const SizedBox(height: 20),

                  PrimaryButton(
                    text: "Continue",
                    icon: Icons.arrow_forward,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}