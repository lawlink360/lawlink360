import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/client_post_model.dart';
import '../providers/client_post_provider.dart';
import 'package:lawlink360/core/features/lawyer_module/client_queries/screens/client_queries_screen.dart';

class LawyerClientPostCard extends ConsumerWidget {
  const LawyerClientPostCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);
    const background = Color(0xFFF5F7FB);

    final posts = ref.watch(clientPostProvider);

    // Show only the first 2 posts on Lawyer Home.
    final previewPosts = posts.take(2).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // SECTION HEADER
          // =====================================================

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.forum_outlined,
                  color: gold,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client Posts',
                      style: TextStyle(
                        color: navy,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Cases, questions & legal queries',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================
              // VIEW ALL
              // =================================================

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ClientQueriesScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =====================================================
          // ONLY 2 PREVIEW POSTS
          // =====================================================

          if (previewPosts.isEmpty)
            const _EmptyPostsState()
          else
            ...previewPosts.map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PostCard(
                  post: post,
                  onReply: () {
                    _openPost(context, post);
                  },
                ),
              ),
            ),

          const SizedBox(height: 4),

          // =====================================================
          // INFORMATION NOTE
          // =====================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: gold,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Reply to a client post to provide legal guidance. '
                    'Your response will be sent to the client through notification.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openPost(
    BuildContext context,
    ClientPostModel post,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _ReplyBottomSheet(post: post);
      },
    );
  }
}

// ============================================================
// POST CARD
// ============================================================

class _PostCard extends StatelessWidget {
  final ClientPostModel post;
  final VoidCallback onReply;

  const _PostCard({
    required this.post,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);

    final typeColor = _typeColor(post.postType);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withOpacity(0.045),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: gold,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  post.clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  post.postType,
                  style: TextStyle(
                    color: typeColor,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            post.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: navy,
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            post.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                color: Colors.grey,
                size: 14,
              ),

              const SizedBox(width: 4),

              Text(
                _formatTime(post.postedAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10.5,
                ),
              ),

              const SizedBox(width: 12),

              const Icon(
                Icons.chat_bubble_outline,
                color: gold,
                size: 14,
              ),

              const SizedBox(width: 4),

              Text(
                '${post.replyCount} replies',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10.5,
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 34,
                child: IntrinsicWidth(
                  child: ElevatedButton.icon(
                    onPressed: onReply,
                    icon: const Icon(
                      Icons.reply_rounded,
                      size: 15,
                    ),
                    label: const Text(
                      'Reply',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      minimumSize: const Size(60, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'case':
        return Colors.orange;

      case 'question':
        return Colors.blue;

      case 'query':
        return Colors.purple;

      default:
        return Colors.blueGrey;
    }
  }

  static String _formatTime(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    return '${difference.inDays} days ago';
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _EmptyPostsState extends StatelessWidget {
  const _EmptyPostsState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 15,
      ),
      child: const Column(
        children: [
          Icon(
            Icons.forum_outlined,
            color: Color(0xFFD4AF37),
            size: 36,
          ),
          SizedBox(height: 10),
          Text(
            'No Client Posts',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'There are currently no public cases or questions.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REPLY BOTTOM SHEET
// ============================================================

class _ReplyBottomSheet extends StatefulWidget {
  final ClientPostModel post;

  const _ReplyBottomSheet({
    required this.post,
  });

  @override
  State<_ReplyBottomSheet> createState() => _ReplyBottomSheetState();
}

class _ReplyBottomSheetState extends State<_ReplyBottomSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitReply() {
    final reply = _controller.text.trim();

    if (reply.isEmpty) {
      return;
    }

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Reply submitted. The client will receive a notification.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Reply to Client',
                    style: TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  color: navy,
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              widget.post.title,
              style: const TextStyle(
                color: navy,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Client: ${widget.post.clientName}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11.5,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your legal guidance or answer...',
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E7EB),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: gold,
                    width: 1.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _submitReply,
                icon: const Icon(Icons.send_rounded),
                label: const Text(
                  'Send Reply',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
