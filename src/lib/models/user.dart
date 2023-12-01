import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String? email;
  String? password;

  bool isAuth = false;

  User({
    required this.email,
    required this.password
  });

  void login() {
    isAuth = true;
    notifyListeners();
  }

  void register(String email, String password) {
    this.email = email;
    this.password = password;

    notifyListeners();
  }
}