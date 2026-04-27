import '../../models/app_user.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Stream<AppUser?> get authStateChanges;

  Future<AppUser?> register({
    required String email,
    required String password,
  });

  Future<AppUser?> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
