import 'package:flutter/material.dart';
import 'package:src/models/data/users/token_data.dart';
import 'package:src/models/data/users/user_data.dart';
import 'package:src/services/authentication_api.dart';

class AuthenticationProvider extends ChangeNotifier {
  late AuthenticationAPI authenticationAPI;

  UserData? currentUser;
  TokenData? token;

  bool refreshHome = false;

  AuthenticationProvider() {
    authenticationAPI = AuthenticationAPI();
  }

  void saveLoginInfo(UserData currentUser, TokenData? token) {
    this.token = token;
    this.currentUser = currentUser;
    notifyListeners();
  }

  void clearUserInfo() {
    token = null;
    currentUser = null;
    notifyListeners();
  }
}