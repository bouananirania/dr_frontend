import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/userServices.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final UserService _userService = UserService();

  User? get user => _user;

  Future<void> inscrire(
      String userName, String password, String confirmPassword) async {
    try {
      _user = await _userService.inscrire(userName, password, confirmPassword);
      notifyListeners();
    } catch (e) {
      // Gérez les erreurs ici
    }
  }

  Future<void> login(String userName, String password) async {
    try {
      _user = await _userService.login(userName, password);
      notifyListeners();
    } catch (e) {
      // Gérez les erreurs ici
    }
  }

  Future<void> changePassword(String userName, String oldPassword,
      String newPassword, String confirmNewPassword) async {
    try {
      _user = await _userService.changePassword(
          userName, oldPassword, newPassword, confirmNewPassword);
      notifyListeners();
    } catch (e) {
      // Gérez les erreurs ici
    }
  }
}
