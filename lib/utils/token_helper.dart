import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }




   static Future<String?> getUserId() async {
    final token = await getToken();
    if (token == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = base64.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(payload));
      final payloadMap = jsonDecode(decoded);

      return payloadMap['Uid'] as String?; // 👈 ده هو الـ User ID
    } catch (e) {
      print("Token decode error: $e");
      return null;
    }
  }
}
