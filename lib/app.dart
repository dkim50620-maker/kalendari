import 'package:flutter/material.dart';

class TaskFlowApp extends StatelessWidget {
  final Widget startScreen;
  
  const TaskFlowApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F4FB),
        useMaterial3: true,
      ),
      home: startScreen,
    );
  }
}
