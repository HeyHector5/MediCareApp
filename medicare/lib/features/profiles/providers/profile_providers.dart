import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicare/core/providers/firebase_providers.dart';
import 'package:medicare/models/models.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(firestoreProvider));
});

class ProfileRepository {
  ProfileRepository(this._firestore);

  final FirebaseFirestore _firestore;

  /// Writes only the fields the user can edit (name, phone, birthDate).
  Future<void> updateProfile(AppUser user) {
    return _firestore
        .collection(Collections.users)
        .doc(user.id)
        .update(user.toProfileUpdateMap());
  }
}
