import 'dart:io';

import 'package:flutter/material.dart';

class BasicInfoProfilePhoto extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const BasicInfoProfilePhoto({
    super.key,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5F7FB),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: imagePath != null && imagePath!.isNotEmpty
                    ? Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person,
                        size: 58,
                        color: Color(0xFF0D1B2A),
                      ),
              ),
            ),

            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD4AF37),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}