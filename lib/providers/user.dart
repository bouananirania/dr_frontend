import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/userServices.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final UserService _userService = UserService();

  User? get user => _user;
  String message = '';

  Future<String> inscrire(
      String userName, String password, String confirmPassword) async {
    try {
      String result =
          await _userService.inscrire(userName, password, confirmPassword);

      // Mettre à jour l'état interne en fonction du résultat
      if (result == 'success') {
        message = 'Inscription réussie';
        // Vous pouvez également mettre à jour `_user` si nécessaire
        _user = User(
            userName: userName, password: password); // Exemple de mise à jour
      } else {
        message = 'Échec de l\'inscription';
      }

      // Notifier les écouteurs
      notifyListeners();

      // Retourner le résultat (success ou error)
      return result;
    } catch (e) {
      message = 'Erreur: $e';
      notifyListeners();
      return 'error';
    }
  }

  Future<void> login(String userName, String password) async {
    try {
      _user = await _userService.login(userName, password);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> changePassword(String userName, String oldPassword,
      String newPassword, String confirmNewPassword) async {
    try {
      _user = await _userService.changePassword(
          userName, oldPassword, newPassword, confirmNewPassword);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
