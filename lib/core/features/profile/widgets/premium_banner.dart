import 'package:flutter/material.dart';

class PremiumBanner extends StatelessWidget {
  final VoidCallback? onUpgrade;

  const PremiumBanner({
    super.key,
    this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFD54F),
            Color(0xFFFFC107),
          ],
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.workspace_premium,
            size: 42,
            color: Colors.black87,
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upgrade to Premium",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Enjoy watermark-free documents, ad-free experience and future premium legal features.",
                  style: TextStyle(
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 80,
              maxWidth: 120,
            ),
            child: ElevatedButton(
              onPressed: onUpgrade,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: const Text("Upgrade"),
            ),
          ),
        ],
      ),
    );
  }
}