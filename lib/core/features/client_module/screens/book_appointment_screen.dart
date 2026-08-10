import 'package:flutter/material.dart';

import '../widgets/book_lawyer_profile_header.dart';
import '../widgets/book_consultation_type.dart';
import '../widgets/book_date_card.dart';
import '../widgets/book_time_slot.dart';
import '../widgets/book_summary_card.dart';
import '../widgets/book_payment_card.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Book Appointment",
          style: TextStyle(
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
children: const [

  LawyerProfileHeader(),

  SizedBox(height: 20),

  BookConsultationType(),

  SizedBox(height: 20),

  BookDateCard(),

  SizedBox(height: 20),

  BookTimeSlot(),

  SizedBox(height: 20),

  BookSummaryCard(),

  SizedBox(height: 100),
],
        ),
      ),
      bottomNavigationBar: const BookPaymentCard(),
    );
  }
}