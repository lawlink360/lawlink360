import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/copy_house_request.dart';
import '../repositories/copy_house_request_repository.dart';

/// Single repository instance.
final copyHouseRequestRepositoryProvider =
    Provider<CopyHouseRequestRepository>((ref) {
  return CopyHouseRequestRepository();
});

/// Streams the current user's requests, keyed by uid.
///
/// Callers are expected to pass the uid from
/// `FirebaseAuth.instance.currentUser?.uid`. A null uid should not be
/// passed; the My Requests screen handles the signed-out case before
/// reading this provider.
final myCopyHouseRequestsProvider =
    StreamProvider.autoDispose.family<List<CopyHouseRequest>, String>(
  (ref, uid) {
    final repository = ref.watch(copyHouseRequestRepositoryProvider);
    return repository.watchMyRequests(uid);
  },
);