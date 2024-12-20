import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  String _username = '';
  String _password = '';
  String _errorMessage = '';

  String get username => _username;
  String get password => _password;
  String get errorMessage => _errorMessage;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateCredentials() {
    if (_username.isEmpty || _password.isEmpty) {
      _errorMessage = "Please enter both username and password";
      notifyListeners();
      return false;
    }

    if (_username == "admin" && _password == "admin") {
      _errorMessage = '';
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Invalid credentials";
      notifyListeners();
      return false;
    }
  }
}
