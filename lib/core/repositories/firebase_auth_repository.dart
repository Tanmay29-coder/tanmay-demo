import 'package:firebase_auth/firebase_auth.dart';
import '../../models/app_user.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  @override
  AppUser? get currentUser => _userFromFirebase(_auth.currentUser);

  @override
  Stream<AppUser?> get authStateChanges => 
      _auth.authStateChanges().map(_userFromFirebase);

  @override
  Future<AppUser?> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e.code);
    }
  }

  @override
  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw _getErrorMessage(e.code);
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered!';
      case 'invalid-email':
        return 'Invalid email address!';
      case 'weak-password':
        return 'Password is too weak!';
      case 'user-not-found':
        return 'No user found with this email!';
      case 'wrong-password':
        return 'Wrong password!';
      default:
        return 'Something went wrong. Please try again!';
    }
  }
}
