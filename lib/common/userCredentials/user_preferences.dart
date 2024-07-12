import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userCredentials = prefs.getStringList('userCredentials') ?? [];

    // Ensure no duplicate entries
    final newCredential = '$email:$password';
    if (!userCredentials.contains(newCredential)) {
      userCredentials.add(newCredential);
      await prefs.setStringList('userCredentials', userCredentials);
    }
  }

    static Future<List<Map<String, String>>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final userCredentials = prefs.getStringList('userCredentials') ?? [];

    return userCredentials.map((cred) {
      final parts = cred.split(':');
      return {'email': parts[0], 'password': parts[1]};
    }).toList();
  }
}

