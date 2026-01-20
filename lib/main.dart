import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

/* ===================== APP ===================== */

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
      home: const ScheduleScreen(),
    );
  }
}

/* ===================== MODEL ===================== */

class ClassData {
  final String teacher;
  final String student;
  final String day;
  final String start;
  final String end;

  ClassData({
    required this.teacher,
    required this.student,
    required this.day,
    required this.start,
    required this.end,
  });
}

/* ===================== SCHEDULE SCREEN ===================== */

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final Map<String, List<ClassData>> schedule = {
    'Sunday': [],
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
  };

  void addClass(ClassData data) {
    setState(() {
      schedule[data.day]!.add(data);
    });
  }

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
                Text(entry.key,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                if (entry.value.isEmpty)
                  const Text(
                    'No classes scheduled',
                    style: TextStyle(color: Colors.grey),
                  ),
                ...entry.value.map((c) => ClassItem(data: c)),
              ],
            ),
          );
        }).toList(),
      ),

      /// ✅ FAB ВНУТРИ ScheduleScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE6DFFF),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddAppointmentDialog(onAdd: addClass),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/* ===================== CLASS ITEM ===================== */

class ClassItem extends StatelessWidget {
  final ClassData data;

  const ClassItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.teacher,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(data.student),
          Align(
            alignment: Alignment.centerRight,
            child: Text('${data.start} - ${data.end}',
                style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

/* ===================== ADD DIALOG ===================== */

class AddAppointmentDialog extends StatefulWidget {
  final Function(ClassData) onAdd;

  const AddAppointmentDialog({super.key, required this.onAdd});

  @override
  State<AddAppointmentDialog> createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  String? teacher;
  String? day;
  String? start;
  String? end;

  final studentCtrl = TextEditingController();

  final teachers = [
    'Mr. Shvetkov',
    'Ms. Kyzembaeva',
    'Dr. Arafat',
    'Ms. Aiman',
  ];

  final days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final times = ['09:00', '10:00', '11:00', '12:00', '14:00', '15:00'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('+ Add New Appointment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            _label('Teacher *'),
            _dropdown(teacher, teachers, (v) => setState(() => teacher = v)),

            _label('Student Name *'),
            _input(studentCtrl),

            _label('Day *'),
            _dropdown(day, days, (v) => setState(() => day = v)),

            Row(
              children: [
                Expanded(
                    child: _dropdown(start, times,
                            (v) => setState(() => start = v))),
                const SizedBox(width: 8),
                Expanded(
                    child: _dropdown(end, times,
                            (v) => setState(() => end = v))),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (teacher != null &&
                          day != null &&
                          start != null &&
                          end != null &&
                          studentCtrl.text.isNotEmpty) {
                        widget.onAdd(
                          ClassData(
                            teacher: teacher!,
                            student: studentCtrl.text,
                            day: day!,
                            start: start!,
                            end: end!,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Appointment'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 4),
    child:
    Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _input(TextEditingController c) => TextField(
    controller: c,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF1F1F1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
  );

  Widget _dropdown(String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: const Text('Select'),
      onChanged: onChanged,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
