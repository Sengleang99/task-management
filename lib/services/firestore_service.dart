import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'users';

  // Create user in Firestore
  Future<void> createUser(AppUser user) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Get user by UID
  Future<AppUser?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollection).doc(uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
