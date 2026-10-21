import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';

/// Thin, synchronous wrapper over the `copyHouseRequests` collection.
///
/// The repository performs no validation of its own; the form and
/// the Firestore security rules enforce the constraints.
class CopyHouseRequestRepository {
  final FirebaseFirestore _firestore;

  CopyHouseRequestRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Submits a new request and returns the generated document id.
  Future<String> submitRequest(CopyHouseRequest request) async {
    final doc = await _firestore
        .collection(copyHouseRequestsCollection)
        .add(request.toCreateMap());

    return doc.id;
  }

  /// Streams the current user's requests, newest first.
  ///
  /// The query filters by `submittedBy == uid` and orders by
  /// `createdAt` descending. A composite index on
  /// (`submittedBy`, `createdAt`) is required by Firestore for this
  /// combination; the first run against a fresh project will
  /// produce an index-creation link in the debug console.
  Stream<List<CopyHouseRequest>> watchMyRequests(String uid) {
    return _firestore
        .collection(copyHouseRequestsCollection)
        .where('submittedBy', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(CopyHouseRequest.fromDoc)
              .toList(growable: false),
        );
  }
}