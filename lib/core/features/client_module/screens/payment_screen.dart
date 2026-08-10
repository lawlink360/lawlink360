import 'package:flutter/material.dart';

import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_coupon_card.dart';
import '../widgets/payment_security_card.dart';
import '../widgets/payment_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Secure Payment",
          style: TextStyle(
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [

            PaymentSummaryCard(),

            SizedBox(height: 20),

            PaymentMethodCard(),

            SizedBox(height: 20),

            PaymentCouponCard(),

            SizedBox(height: 20),

            PaymentSecurityCard(),

            SizedBox(height: 120),
          ],
        ),
      ),

      bottomNavigationBar: const PaymentButton(),
    );
  }
}