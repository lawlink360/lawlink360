import 'package:flutter/material.dart';

import '../data/case_data.dart';
import '../widgets/case_card.dart';
import '../widgets/case_filter_tabs.dart';
import '../widgets/case_search_bar.dart';
import '../widgets/case_statistics_card.dart';

class MyCasesScreen extends StatefulWidget {
  const MyCasesScreen({super.key});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("My Cases"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const CaseSearchBar(),

          const SizedBox(height: 20),

          Row(
            children: const [

              CaseStatisticsCards(
                title: "Active",
                value: "1",
                icon: Icons.gavel_outlined,
                color: Colors.green,
              ),

              SizedBox(width: 10),

              CaseStatisticsCards(
                title: "Pending",
                value: "1",
                icon: Icons.schedule,
                color: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: const [

              CaseStatisticsCards(
                title: "Completed",
                value: "1",
                icon: Icons.check_circle_outline,
                color: Colors.blue,
              ),

              SizedBox(width: 10),

              CaseStatisticsCards(
                title: "Archived",
                value: "1",
                icon: Icons.archive_outlined,
                color: Colors.grey,
              ),
            ],
          ),

          const SizedBox(height: 24),

          CaseFilterTabs(
            selectedIndex: selectedTab,
            onChanged: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: 20),

          ...CaseData.cases.map(
            (item) => CaseCard(
              caseItem: item,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}