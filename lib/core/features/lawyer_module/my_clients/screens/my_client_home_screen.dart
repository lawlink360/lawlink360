import 'package:flutter/material.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Clients",
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF0D1B2A),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // --------------------------------------------------
              // HEADER
              // --------------------------------------------------

              const Text(
                "Manage Your Clients",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Stay connected with your clients and manage their legal matters.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 22),

              // --------------------------------------------------
              // SEARCH
              // --------------------------------------------------

              TextField(
                decoration: InputDecoration(
                  hintText: "Search clients...",
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF0D1B2A),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune_rounded),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --------------------------------------------------
              // STATISTICS
              // --------------------------------------------------

              const Text(
                "Overview",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.people_alt_rounded,
                      title: "Clients",
                      value: "48",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.folder_rounded,
                      title: "Active Cases",
                      value: "23",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.calendar_month_rounded,
                      title: "Appointments",
                      value: "07",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.mark_email_unread_rounded,
                      title: "Requests",
                      value: "05",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // --------------------------------------------------
              // CLIENT REQUESTS
              // --------------------------------------------------

              _SectionHeader(
                title: "Client Requests",
                action: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              const _ClientRequestCard(
                name: "Muhammad Usman",
                matter: "Property dispute",
                location: "Lahore",
              ),

              const SizedBox(height: 12),

              const _ClientRequestCard(
                name: "Ayesha Malik",
                matter: "Family matter",
                location: "Islamabad",
              ),

              const SizedBox(height: 28),

              // --------------------------------------------------
              // RANDOM LEGAL QUESTION
              // --------------------------------------------------

              _SectionHeader(
                title: "Legal Questions",
                action: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              const _LegalQuestionCard(),

              const SizedBox(height: 28),

              // --------------------------------------------------
              // MY CLIENTS
              // --------------------------------------------------

              _SectionHeader(
                title: "My Clients",
                action: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              const _ClientCard(
                name: "Ali Raza",
                caseTitle: "Property Case",
                nextAppointment: "Today • 04:00 PM",
              ),

              const SizedBox(height: 12),

              const _ClientCard(
                name: "Sara Ahmed",
                caseTitle: "Family Case",
                nextAppointment: "Tomorrow • 11:00 AM",
              ),

              const SizedBox(height: 28),

              // --------------------------------------------------
              // RECENT ACTIVITY
              // --------------------------------------------------

              _SectionHeader(
                title: "Recent Activity",
                action: "View All",
                onTap: () {},
              ),

              const SizedBox(height: 14),

              const _ActivityCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: "New message from Ali Raza",
                time: "10 min ago",
              ),

              const SizedBox(height: 10),

              const _ActivityCard(
                icon: Icons.description_outlined,
                title: "Ayesha uploaded a document",
                time: "1 hour ago",
              ),

              const SizedBox(height: 10),

              const _ActivityCard(
                icon: Icons.calendar_today_outlined,
                title: "Appointment confirmed",
                time: "3 hours ago",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ================================================================
// STAT CARD
// ================================================================

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 27,
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


// ================================================================
// SECTION HEADER
// ================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13294B),
          ),
        ),

        TextButton(
          onPressed: onTap,
          child: const Text(
            "View All",
            style: TextStyle(
              color: Color(0xFF0D1B2A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}


// ================================================================
// CLIENT REQUEST
// ================================================================

class _ClientRequestCard extends StatelessWidget {
  final String name;
  final String matter;
  final String location;

  const _ClientRequestCard({
    required this.name,
    required this.matter,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFE8ECF2),
            child: Icon(
              Icons.person,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  matter,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }
}


// ================================================================
// LEGAL QUESTION
// ================================================================

class _LegalQuestionCard extends StatelessWidget {
  const _LegalQuestionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.question_answer_rounded,
                color: Color(0xFFD4AF37),
              ),

              SizedBox(width: 8),

              Text(
                "Community Question",
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            "A person has purchased a property but the seller is refusing to complete the registration. What legal remedy is available?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              const SizedBox(width: 8),

              const Expanded(
                child: Text(
                  "Anonymous User • 15 min ago",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Answer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ================================================================
// CLIENT CARD
// ================================================================

class _ClientCard extends StatelessWidget {
  final String name;
  final String caseTitle;
  final String nextAppointment;

  const _ClientCard({
    required this.name,
    required this.caseTitle,
    required this.nextAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFFE8ECF2),
            child: Icon(
              Icons.person,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF13294B),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  caseTitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  nextAppointment,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0D1B2A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }
}


// ================================================================
// RECENT ACTIVITY
// ================================================================

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE8ECF2),
            child: Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}