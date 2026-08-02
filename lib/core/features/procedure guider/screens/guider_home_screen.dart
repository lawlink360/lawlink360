import 'package:flutter/material.dart';

class GuiderHomeScreen extends StatelessWidget {
  const GuiderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.menu_book_outlined,
                size: 70,
                color: Color(0xFF1B263B),
              ),
              SizedBox(height: 20),
              Text(
                "Procedure Guider",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Law Library - Coming Soon",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}