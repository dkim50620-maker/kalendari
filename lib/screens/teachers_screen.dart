import 'package:flutter/material.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Явно указываем тип
    final List<Map<String, dynamic>> teachers = [
      {'name': 'Mr. Shvetkov', 'status': 'Available', 'classes': 2},
      {'name': 'Ms. Kyzembaeva', 'status': 'Busy', 'classes': 1},
      {'name': 'Dr. Arafat', 'status': 'Partially Available', 'classes': 1},
      {'name': 'Ms. Aiman', 'status': 'Available', 'classes': 1},
      {'name': 'Mr. Madi', 'status': 'Busy', 'classes': 0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Teachers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: teachers.length,
        itemBuilder: (_, index) {
          final Map<String, dynamic> t = teachers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(t['name'][0]), // первый символ имени
              ),
              title: Text(t['name']),      // имя
              subtitle: Text(t['status']), // статус
              trailing: Text('${t['classes']} Classes'),
            ),
          );
        },
      ),
    );
  }
}

