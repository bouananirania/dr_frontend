import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  final String apiUrl = 'http://127.0.0.1:3000/user';

  Future<String> inscrire(
      String userName, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$apiUrl/inscrire'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      return 'succes';
    } else {
      return 'error';
    }
  }

  Future<User> login(String userName, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la connexion');
    }
  }

  Future<User> changePassword(String userName, String oldPassword,
      String newPassword, String confirmNewPassword) async {
    final response = await http.post(
      Uri.parse('$apiUrl/changepswd'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors du changement de mot de passe');
    }
  }
}
