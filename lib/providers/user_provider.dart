import 'package:bankroll_app/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      token: '',
      id: '',
      email: '',
      username: '',
      password: '',
      ofsessions: [],
      oftransactions: [],
      ofbaknroll: '');

  User get user => _user;

  void setUser(dynamic user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
