import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _sessionkey = "isLoggedIn";
  static const String _userskey = "registered_users";

  Future<void> doRegister(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final String? usersJson = prefs.getString(_userskey);
    Map<String, dynamic> users = usersJson != null ? jsonDecode(usersJson) : {};

    if (users.containsKey(email)) {
      throw Exception("Este e-mail já está cadastrado");
    }

    users[email] = password;
    await prefs.setString(_userskey, jsonEncode(users));
  }

  Future<void> doLogin(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_userskey);

    if (usersJson == null) {
      throw Exception("Nenhum usuário encontrado nesse dispositivo");
    }

    final Map<String, dynamic> users = jsonDecode(usersJson);


    if (users.containsKey(email) && users[email] == password){
      await prefs.setBool(_sessionkey, true);
    } else {
      throw Exception('E-mail ou senha inválidos.');
    }
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_sessionkey) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionkey);
  }
}