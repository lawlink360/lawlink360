import 'package:flutter/material.dart';

class CategoryServiceSearch extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CategoryServiceSearch({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search services...",
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: IconButton(
            onPressed: () => controller.clear(),
            icon: const Icon(Icons.close_rounded),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFD4AF37),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}