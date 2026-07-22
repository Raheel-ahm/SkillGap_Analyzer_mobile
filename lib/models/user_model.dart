class UserModel {
  final String fullName;
  final String email;
  final String password;

  UserModel({required this.fullName, required this.email, required this.password});
}

class AuthStore {
  // In-memory user list — no database
  static final List<UserModel> _users = [];
  static UserModel? _currentUser;

  static UserModel? get currentUser => _currentUser;

  static String? signUp(String fullName, String email, String password) {
    final exists = _users.any((u) => u.email.toLowerCase() == email.toLowerCase());
    if (exists) return 'Email already registered';
    _users.add(UserModel(fullName: fullName, email: email, password: password));
    _currentUser = _users.last;
    return null; // null = success
  }

  static String? signIn(String email, String password) {
    try {
      final user = _users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      );
      _currentUser = user;
      return null; // null = success
    } catch (_) {
      return 'Invalid email or password';
    }
  }

  static void signOut() => _currentUser = null;
}
