
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/client_post_model.dart';

final clientPostProvider =
    StateNotifierProvider<ClientPostNotifier, List<ClientPostModel>>(
  (ref) => ClientPostNotifier(),
);

class ClientPostNotifier extends StateNotifier<List<ClientPostModel>> {
  ClientPostNotifier()
      : super([
          ClientPostModel(
            id: 'post_001',
            clientId: 'client_001',
            clientName: 'Ali Raza',
            clientImageUrl: null,
            postType: 'Case',
            title: 'Property ownership dispute',
            description:
                'I have a dispute regarding ownership of inherited property. I need legal guidance about the available procedure.',
            postedAt: DateTime.now().subtract(
              const Duration(hours: 2),
            ),
            replyCount: 3,
          ),

          ClientPostModel(
            id: 'post_002',
            clientId: 'client_002',
            clientName: 'Ahmed Khan',
            clientImageUrl: null,
            postType: 'Question',
            title: 'How can I recover my unpaid amount?',
            description:
                'A person has taken money from me and has not returned it despite repeated requests. What legal options are available?',
            postedAt: DateTime.now().subtract(
              const Duration(hours: 5),
            ),
            replyCount: 5,
          ),

          ClientPostModel(
            id: 'post_003',
            clientId: 'client_003',
            clientName: 'Sara Malik',
            clientImageUrl: null,
            postType: 'Query',
            title: 'Family property legal guidance',
            description:
                'I want to understand my legal rights regarding distribution of family property.',
            postedAt: DateTime.now().subtract(
              const Duration(days: 1),
            ),
            replyCount: 2,
          ),

          ClientPostModel(
            id: 'post_004',
            clientId: 'client_004',
            clientName: 'Usman Ali',
            clientImageUrl: null,
            postType: 'Question',
            title: 'Legal notice received',
            description:
                'I have received a legal notice and want to understand what steps I should take next.',
            postedAt: DateTime.now().subtract(
              const Duration(days: 1, hours: 4),
            ),
            replyCount: 4,
          ),
        ]);

  void addPost(ClientPostModel post) {
    state = [
      post,
      ...state,
    ];
  }

  void removePost(String postId) {
    state = state
        .where((post) => post.id != postId)
        .toList();
  }

  void updatePost(ClientPostModel updatedPost) {
    state = state.map((post) {
      if (post.id == updatedPost.id) {
        return updatedPost;
      }

      return post;
    }).toList();
  }

  void incrementReplyCount(String postId) {
    state = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          replyCount: post.replyCount + 1,
        );
      }

      return post;
    }).toList();
  }
}
