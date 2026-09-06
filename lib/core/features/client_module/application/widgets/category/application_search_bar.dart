import 'package:flutter/material.dart';

class ApplicationSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const ApplicationSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController =
        controller ?? TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: searchController,
          onChanged: onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'What document do you need today?',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF0F172A),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                onChanged?.call('');
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.grey,
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}