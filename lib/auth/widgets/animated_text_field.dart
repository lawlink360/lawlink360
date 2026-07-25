import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const AnimatedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> {
  late FocusNode _focusNode;
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscure = widget.obscureText;

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.white60 : Colors.black54;
    final iconColor = isDark ? Colors.white70 : Colors.black54;
    final fillColor = isDark 
        ? Colors.white.withValues(alpha: 0.08) 
        : Colors.black.withValues(alpha: 0.05);
    final borderColor = isDark 
        ? Colors.white.withValues(alpha: 0.10) 
        : Colors.black.withValues(alpha: 0.10);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.22),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscure,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        cursorColor: const Color(0xFFD4AF37),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: hintColor,
          ),
          filled: true,
          fillColor: fillColor,
          prefixIcon: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              widget.icon,
              color: focused
                  ? const Color(0xFFD4AF37)
                  : iconColor,
            ),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: focused
                        ? const Color(0xFFD4AF37)
                        : iconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFD4AF37),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}