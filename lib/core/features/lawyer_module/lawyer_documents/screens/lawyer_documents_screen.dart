import 'package:flutter/material.dart';

import '../widgets/lawyer_documents_header.dart';
import '../widgets/document_search_bar.dart';
import '../widgets/document_filter_tabs.dart';
import '../widgets/lawyer_document_card.dart';
import '../widgets/document_category_card.dart';
import '../widgets/document_empty_state.dart';

class MyDocumentsScreen extends StatefulWidget {
  const MyDocumentsScreen({super.key});

  @override
  State<MyDocumentsScreen> createState() => _MyDocumentsScreenState();
}

class _MyDocumentsScreenState extends State<MyDocumentsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _documents = [
    {
      'title': 'Legal Notice - Property Dispute',
      'type': 'PDF',
      'category': 'Client Files',
      'date': 'August 10, 2026',
      'icon': Icons.picture_as_pdf_outlined,
      'color': Color(0xFFD32F2F),
    },
    {
      'title': 'Power of Attorney Draft',
      'type': 'DOC',
      'category': 'Drafts',
      'date': 'August 9, 2026',
      'icon': Icons.description_outlined,
      'color': Color(0xFF1976D2),
    },
    {
      'title': 'Client Agreement',
      'type': 'PDF',
      'category': 'Client Files',
      'date': 'August 8, 2026',
      'icon': Icons.picture_as_pdf_outlined,
      'color': Color(0xFFD32F2F),
    },
    {
      'title': 'Civil Suit Application',
      'type': 'PDF',
      'category': 'Saved',
      'date': 'August 6, 2026',
      'icon': Icons.picture_as_pdf_outlined,
      'color': Color(0xFFD32F2F),
    },
    {
      'title': 'Bail Application Draft',
      'type': 'DOC',
      'category': 'Drafts',
      'date': 'August 5, 2026',
      'icon': Icons.description_outlined,
      'color': Color(0xFF1976D2),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDocuments {
    final searchText = _searchController.text.trim().toLowerCase();

    return _documents.where((document) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          document['category'] == _selectedCategory;

      final matchesSearch =
          searchText.isEmpty ||
          document['title'].toString().toLowerCase().contains(searchText) ||
          document['type'].toString().toLowerCase().contains(searchText) ||
          document['category']
              .toString()
              .toLowerCase()
              .contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {});
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _openDocument(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title will open here soon.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDocumentOptions(String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                ListTile(
                  leading: const Icon(
                    Icons.share_outlined,
                    color: Color(0xFF13294B),
                  ),
                  title: const Text('Share'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.download_outlined,
                    color: Color(0xFF13294B),
                  ),
                  title: const Text('Save a Copy'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final documents = _filteredDocuments;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'My Documents',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF13294B),
        elevation: 0,
      ),

      body: ListView(
        children: [
          const MyDocumentsHeader(),

          DocumentSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),

          SizedBox(
            height: 145,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                DocumentCategoryCard(
                  icon: Icons.description_outlined,
                  title: 'Drafts',
                  count: '12',
                  color: const Color(0xFF1976D2),
                  onTap: () {
                    _onCategoryChanged('Drafts');
                  },
                ),

                const SizedBox(width: 12),

                DocumentCategoryCard(
                  icon: Icons.folder_shared_outlined,
                  title: 'Client Files',
                  count: '24',
                  color: const Color(0xFF7B1FA2),
                  onTap: () {
                    _onCategoryChanged('Client Files');
                  },
                ),

                const SizedBox(width: 12),

                DocumentCategoryCard(
                  icon: Icons.bookmark_border,
                  title: 'Saved',
                  count: '8',
                  color: const Color(0xFFD4AF37),
                  onTap: () {
                    _onCategoryChanged('Saved');
                  },
                ),

                const SizedBox(width: 12),

                DocumentCategoryCard(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'PDF',
                  count: '31',
                  color: const Color(0xFFD32F2F),
                  onTap: () {
                    _onCategoryChanged('PDF');
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          DocumentFilterTabs(
            selectedCategory: _selectedCategory,
            onCategoryChanged: _onCategoryChanged,
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Recent Documents',
                  style: TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Text(
                  '${documents.length} documents',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: documents.isEmpty
                ? const DocumentEmptyState()
                : Column(
                    children: documents.map((document) {
                      return LawyerDocumentCard(
                        title: document['title'],
                        type: document['type'],
                        category: document['category'],
                        date: document['date'],
                        icon: document['icon'],
                        iconColor: document['color'],
                        onTap: () => _openDocument(
                          document['title'],
                        ),
                        onMore: () => _showDocumentOptions(
                          document['title'],
                        ),
                      );
                    }).toList(),
                  ),
          ),

          const SizedBox(height: 28),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Document creation will be available soon.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'New Document',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}