import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/models/user_model.dart';
import 'package:task/services/firestore_service.dart';


class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirestoreService? firestoreService,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestoreService = firestoreService ?? FirestoreService();

  Stream<AppUser?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return await _firestoreService.getUser(firebaseUser.uid);
    });
  }

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _firestoreService.getUser(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed');
    }
  }

  Future<AppUser?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      
      final user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
      
      await _firestoreService.createUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Password reset failed');
    }
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) return null;
      
      final user = AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        name: userCredential.user!.displayName,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
      
      await _firestoreService.createUser(user);
      return user;
    } catch (e) {
      throw AuthException('Google sign in failed');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}