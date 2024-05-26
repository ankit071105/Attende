import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userKey = 'user_key';

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(email) != null) {
      return false; // User already exists
    }
    prefs.setString(email, password);
    prefs.setBool('isVerified_$email', false);
    // Simulate email verification
    await Future.delayed(Duration(seconds: 1));
    prefs.setBool('isVerified_$email', true);
    return true;
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString(email);
    final isVerified = prefs.getBool('isVerified_$email') ?? false;
    if (storedPassword == password && isVerified) {
      prefs.setString(_userKey, email);
      return true;
    }
    return false;
  }

  // Sign out
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }
}
