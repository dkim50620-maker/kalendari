import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'users';
  static const String _loggedInUserKey = 'logged_in_user';

  // Хэширование пароля
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Регистрация
  Future<String?> register(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_usersKey);
    Map<String, dynamic> users = usersJson != null ? jsonDecode(usersJson) : {};

    if (users.containsKey(login)) {
      return 'Пользователь с таким логином уже существует';
    }

    users[login] = _hashPassword(password);
    await prefs.setString(_usersKey, jsonEncode(users));
    return null; // Успех
  }

  // Вход
  Future<bool> login(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return false;

    Map<String, dynamic> users = jsonDecode(usersJson);
    if (!users.containsKey(login)) return false;

    String hashedPassword = _hashPassword(password);
    if (users[login] == hashedPassword) {
      await prefs.setString(_loggedInUserKey, login);
      return true;
    }
    return false;
  }

  // Выход
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
  }

  // Проверка сессии
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_loggedInUserKey);
  }

  // Получение текущего пользователя
  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loggedInUserKey);
  }
}
