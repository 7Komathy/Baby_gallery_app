import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final String _hardcodedUsername = "admin";
  final String _hardcodedPassword = "password";

  bool login(String username, String password) {
    if (username == _hardcodedUsername && password == _hardcodedPassword) {
      return true;
    }
    return false;
  }
}
