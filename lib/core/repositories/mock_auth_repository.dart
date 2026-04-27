import 'dart:async';
import '../../models/app_user.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  AppUser? _currentUser;
  final _authStateController = StreamController<AppUser?>.broadcast();

  MockAuthRepository() {
    _authStateController.add(_currentUser);
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<AppUser?> register({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network jump
    _currentUser = AppUser(
      id: 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: 'Mock User',
    );
    _authStateController.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network jump
    if (email == 'admin@admin.com' && password == 'admin123') {
      _currentUser = AppUser(
        id: 'mock_admin_user',
        email: email,
        displayName: 'Admin User',
        role: 'admin',
      );
      _authStateController.add(_currentUser);
      return _currentUser;
    } else if (email == 'test@test.com' && password == 'password') {
      _currentUser = AppUser(
        id: 'mock_test_user',
        email: email,
        displayName: 'Test User',
        role: 'user',
      );
      _authStateController.add(_currentUser);
      return _currentUser;
    }
    // Simulate error constraint
    throw 'No user found with this email!';
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }
}
