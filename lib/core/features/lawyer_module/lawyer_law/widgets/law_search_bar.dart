import 'package:flutter/material.dart';

class LawSearchBar extends StatelessWidget {
  const LawSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.hintText = 'Search laws, acts, ordinances...',
    this.autofocus = false,
    this.readOnly = false,
    this.showFilter = false,
    this.onFilterTap,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;

  final String hintText;
  final bool autofocus;
  final bool readOnly;

  final bool showFilter;
  final VoidCallback? onFilterTap;

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFFF7F8FA);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: navy,
          size: 22,
        ),
        suffixIcon: showFilter
            ? IconButton(
                tooltip: 'Filter',
                onPressed: onFilterTap,
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: gold.withValues(alpha:0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: navy,
                    size: 17,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: navy,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}