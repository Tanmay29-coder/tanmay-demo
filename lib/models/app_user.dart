class AppUser {
  final String id;
  final String? email;
  final String? displayName;
  final String role; // 'user' or 'admin'

  AppUser({
    required this.id,
    this.email,
    this.displayName,
    this.role = 'user', // Default is normal user
  });

  bool get isAdmin => role == 'admin';
}
