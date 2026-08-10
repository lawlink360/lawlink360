import 'package:flutter/material.dart';

import '../data/document_data.dart';

import '../widgets/document_card.dart';
import '../widgets/documents_filter_tabs.dart';
import '../widgets/document_search_bar.dart';
import '../widgets/document_statistics_cards.dart';
import '../widgets/empty_documents_widget.dart';
import '../widgets/recent_documents_card.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final documents = DocumentData.documents;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("My Documents"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const DocumentSearchBar(),

            const SizedBox(height: 18),

            Row(
              children: const [
                DocumentStatisticsCards(
                  title: "Documents",
                  value: "3",
                  icon: Icons.folder,
                  color: Colors.indigo,
                ),

                SizedBox(width: 12),

                DocumentStatisticsCards(
                  title: "Favorites",
                  value: "2",
                  icon: Icons.star,
                  color: Colors.amber,
                ),

                SizedBox(width: 12),

                DocumentStatisticsCards(
                  title: "Verified",
                  value: "1",
                  icon: Icons.verified,
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 18),

            DocumentFilterTabs(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            const SizedBox(height: 18),

            const RecentDocumentsCard(),

            const SizedBox(height: 18),

            Expanded(
              child: documents.isEmpty
                  ? const EmptyDocumentsWidget()
                  : ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return DocumentCard(
                          document: documents[index],
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}