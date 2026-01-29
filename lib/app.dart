import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F4FB),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
