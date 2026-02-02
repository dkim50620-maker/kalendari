import 'package:flutter/material.dart';
import 'app.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final bool loggedIn = await authService.isLoggedIn();
  
  runApp(TaskFlowApp(startScreen: loggedIn ? const MainScreen() : const LoginScreen()));
}
