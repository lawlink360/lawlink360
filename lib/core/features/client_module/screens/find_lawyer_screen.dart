import 'package:flutter/material.dart';


import '../widgets/hero_section.dart';
import '../widgets/practice_area_card.dart';
import '../widgets/lawyer_card.dart';

class FindLawyerScreen extends StatelessWidget {
  const FindLawyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Find Lawyer",
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const HeroSection(),

              const SizedBox(height: 24),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search lawyer...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {},
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Practice Areas",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [

                    PracticeAreaCard(
                      icon: Icons.gavel,
                      title: "Criminal",
                      lawyers: "120 Lawyers",
                    ),

                    PracticeAreaCard(
                      icon: Icons.family_restroom,
                      title: "Family",
                      lawyers: "95 Lawyers",
                    ),

                    PracticeAreaCard(
                      icon: Icons.description,
                      title: "Civil",
                      lawyers: "110 Lawyers",
                    ),

                    PracticeAreaCard(
                      icon: Icons.account_balance,
                      title: "Corporate",
                      lawyers: "72 Lawyers",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Top Rated Lawyers",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              const LawyerCard(
                name: "Adv. Ahmed Khan",
                speciality: "Criminal Lawyer",
                location: "Islamabad",
                rating: 4.9,
                experience: 15,
              ),

              const LawyerCard(
                name: "Adv. Sara Malik",
                speciality: "Family Lawyer",
                location: "Lahore",
                rating: 4.8,
                experience: 11,
              ),

              const LawyerCard(
                name: "Adv. Ali Raza",
                speciality: "Civil Lawyer",
                location: "Karachi",
                rating: 4.7,
                experience: 9,
              ),
              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1B2A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Can't Find the Right Lawyer?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Post your legal case and receive proposals from verified lawyers across Pakistan.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.gavel),
                        label: const Text("Post Your Case"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

    );
  }
}