import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/draft_model.dart';
import '../providers/draft_providers.dart';

class MyDraftsScreen extends ConsumerStatefulWidget {
  const MyDraftsScreen({super.key});

  @override
  ConsumerState<MyDraftsScreen> createState() =>
      _MyDraftsScreenState();
}

class _MyDraftsScreenState
    extends ConsumerState<MyDraftsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filters = [
    'All',
    'Draft',
    'Sent',
    'Finalized',
  ];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DraftModel> _filteredDrafts(
    List<DraftModel> drafts,
  ) {
    return drafts.where((draft) {
      final matchesFilter =
          _selectedFilter == 'All' ||
          draft.status.toLowerCase() ==
              _selectedFilter.toLowerCase();

      final matchesSearch =
          _searchQuery.isEmpty ||
          draft.title.toLowerCase().contains(_searchQuery) ||
          draft.category.toLowerCase().contains(_searchQuery) ||
          (draft.clientName?.toLowerCase().contains(
                _searchQuery,
              ) ??
              false) ||
          (draft.caseTitle?.toLowerCase().contains(
                _searchQuery,
              ) ??
              false);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final drafts = ref.watch(draftProvider);
    final filteredDrafts = _filteredDrafts(drafts);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Drafts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 2,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/drafting/create',
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          _buildHeader(drafts.length),

          _buildSearchBar(),

          _buildFilterTabs(),

          Expanded(
            child: filteredDrafts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      90,
                    ),
                    itemCount: filteredDrafts.length,
                    itemBuilder: (context, index) {
                      final draft = filteredDrafts[index];

                      return _MyDraftCard(
                        draft: draft,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/drafting/preview',
                            arguments: draft.id,
                          );
                        },
                        onEdit: () {
                          Navigator.pushNamed(
                            context,
                            '/drafting/editor',
                            arguments: draft.id,
                          );
                        },
                        onDelete: () {
                          _deleteDraft(draft);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int totalDrafts) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        18,
        16,
        14,
      ),
      color: const Color(0xFFF5F7FB),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Drafts',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF13294B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage your legal documents.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  '$totalDrafts',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF13294B),
                  ),
                ),
                const Text(
                  'Drafts',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        12,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search drafts...',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 21,
            color: Color(0xFF13294B),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF13294B),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final selected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF13294B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF13294B)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF13294B),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final hasSearch =
        _searchQuery.isNotEmpty ||
        _selectedFilter != 'All';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFF13294B)
                    .withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 38,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              hasSearch
                  ? 'No drafts found'
                  : 'No drafts yet',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              hasSearch
                  ? 'Try another search or filter.'
                  : 'Create your first legal draft.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

            if (!hasSearch) ...[
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/drafting/create',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF13294B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.add,
                  size: 18,
                ),
                label: const Text(
                  'Create Draft',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _deleteDraft(DraftModel draft) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Draft?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${draft.title}"?',
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF13294B),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(draftProvider.notifier)
                    .deleteDraft(draft.id);

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Draft deleted successfully.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13294B),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// MY DRAFT CARD
// ============================================================

class _MyDraftCard extends StatelessWidget {
  const _MyDraftCard({
    required this.draft,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final DraftModel draft;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF13294B)
                      .withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: Color(0xFF13294B),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      draft.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      draft.clientName ??
                          draft.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37)
                                .withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                          child: Text(
                            draft.category,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9A7A00),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          _formatDate(draft.updatedAt),
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              Column(
                children: [
                  _StatusBadge(
                    status: draft.status,
                  ),

                  const SizedBox(height: 4),

                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit();
                      } else if (value == 'preview') {
                        onTap();
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: Color(0xFF13294B),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'preview',
                        child: Row(
                          children: [
                            Icon(
                              Icons.visibility_outlined,
                              size: 18,
                              color: Color(0xFF13294B),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Preview',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'finalized':
        backgroundColor =
            const Color(0xFFD4AF37).withValues(alpha: 0.15);
        textColor = const Color(0xFF9A7A00);
        break;

      case 'sent':
        backgroundColor =
            Colors.blue.withValues(alpha: 0.10);
        textColor = Colors.blue.shade700;
        break;

      case 'draft':
      default:
        backgroundColor =
            const Color(0xFF13294B).withValues(alpha: 0.08);
        textColor = const Color(0xFF13294B);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}