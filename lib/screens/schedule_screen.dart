import 'package:flutter/material.dart';
import '../models/class_data.dart';
import '../widgets/class_item.dart';
import '../dialogs/add_appointment_dialog.dart';

class ScheduleScreen extends StatelessWidget {
  final Map<String, List<ClassData>> schedule;
  final Function(ClassData) onAddClass;
  final List<String> teachers;

  const ScheduleScreen({
    super.key,
    required this.schedule,
    required this.onAddClass,
    required this.teachers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: schedule.entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EFFB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                if (entry.value.isEmpty)
                  const Text(
                    'Нет запланированных занятий',
                    style: TextStyle(color: Colors.grey),
                  ),
                ...entry.value.map((c) => ClassItem(data: c)),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE6DFFF),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddAppointmentDialog(
              onAdd: onAddClass,
              teachers: teachers,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
