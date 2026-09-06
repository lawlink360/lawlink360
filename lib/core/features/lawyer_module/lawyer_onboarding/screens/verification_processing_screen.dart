
import 'dart:async';

import 'package:flutter/material.dart';

import 'verification_success_screen.dart';

class VerificationProcessingScreen extends StatefulWidget {
  const VerificationProcessingScreen({super.key});

  @override
  State<VerificationProcessingScreen> createState() =>
      _VerificationProcessingScreenState();
}

class _VerificationProcessingScreenState
    extends State<VerificationProcessingScreen> {
  Timer? _timer;

  int _secondsRemaining = 20;

  @override
  void initState() {
    super.initState();

    _startVerificationProcess();
  }

  void _startVerificationProcess() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_secondsRemaining > 1) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          timer.cancel();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const VerificationSuccessScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (20 - _secondsRemaining) / 20;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ------------------------------------------------
                  // VERIFICATION ICON
                  // ------------------------------------------------

                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4AF37).withValues(alpha:0.12),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 58,
                        height: 58,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFD4AF37),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // TITLE
                  // ------------------------------------------------

                  const Text(
                    'Verification in Progress',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'We are reviewing your submitted credentials. '
                    'Please wait while we complete the verification process.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // PROGRESS CARD
                  // ------------------------------------------------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              color: Color(0xFFD4AF37),
                              size: 23,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Checking your credentials',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0D1B2A),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFE5E7EB),
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFFD4AF37),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          '$_secondsRemaining seconds remaining',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ------------------------------------------------
                  // INFORMATION
                  // ------------------------------------------------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFD6E8FF),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color(0xFF0D1B2A),
                          size: 22,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your verification documents are private '
                            'and are only used for credential verification.',
                            style: TextStyle(
                              color: Color(0xFF334155),
                              fontSize: 12.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Please do not close the application during verification.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
