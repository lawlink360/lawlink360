import 'package:flutter/material.dart';

class EnableBiometricDialog extends StatelessWidget {
  final VoidCallback onEnable;
  final VoidCallback onSkip;

  const EnableBiometricDialog({
    super.key,
    required this.onEnable,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFFD4AF37),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.fingerprint_rounded,
              size: 70,
              color: Color(0xFFD4AF37),
            ),
            const SizedBox(height: 18),

            const Text(
              "Enable Fingerprint Login?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "Sign in faster and securely using your fingerprint or Face Unlock.\n\nYour biometric information never leaves your device and is never stored by LawLink360.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                height: 1.5,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onSkip,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFD4AF37),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Not Now"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onEnable,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      "Enable",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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