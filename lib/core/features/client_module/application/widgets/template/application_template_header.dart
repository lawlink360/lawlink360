import 'package:flutter/material.dart';

import '../../models/document_category.dart';

class ApplicationTemplateHeader extends StatelessWidget {
  final DocumentCategory category;
  final int totalServices;

  const ApplicationTemplateHeader({
    super.key,
    required this.category,
    required this.totalServices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E3A8A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white.withValues(alpha:0.15),
                  child: Icon(
                    category.icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "$totalServices Sections",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}