import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatefulWidget {
  const TaskFlowApp({super.key});

  @override
  State<TaskFlowApp> createState() => _TaskFlowAppState();
}

class _TaskFlowAppState extends State<TaskFlowApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TaskFlow'),
          centerTitle: true,
        ),
        body: index == 0 ? const ScheduleScreen() : const TeachersScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Teachers',
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== SCHEDULE ===================== */

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        DayBlock(day: 'Sunday', classes: []),
        DayBlock(
          day: 'Monday',
          classes: [
            ClassItem(
              teacher: 'Mr. Shvetkov',
              student: 'Ali Hassan',
              subject: 'Mathematics - Algebra review',
              time: '10:00 - 11:00',
              color: Colors.blue,
            ),
            ClassItem(
              teacher: 'Ms. Kyzembaeva',
              student: 'Amira Khalil',
              subject: 'English - Literature discussion',
              time: '14:00 - 15:00',
              color: Colors.green,
            ),
          ],
        ),
        DayBlock(
          day: 'Tuesday',
          classes: [
            ClassItem(
              teacher: 'Dr. Arafat',
              student: 'Mohamed Ali',
              subject: 'Physics - Mechanics',
              time: '09:00 - 10:00',
              color: Colors.purple,
            ),
          ],
        ),
        DayBlock(
          day: 'Wednesday',
          classes: [
            ClassItem(
              teacher: 'Mr. Shvetkov',
              student: 'Layla Ahmed',
              subject: 'Mathematics - Calculus',
              time: '11:00 - 12:00',
              color: Colors.blue,
            ),
          ],
        ),
        DayBlock(
          day: 'Thursday',
          classes: [
            ClassItem(
              teacher: 'Ms. Aiman',
              student: 'Yusuf Hassan',
              subject: 'Chemistry - Organic compounds',
              time: '16:00 - 17:00',
              color: Colors.orange,
            ),
          ],
        ),
        DayBlock(day: 'Friday', classes: []),
        DayBlock(day: 'Saturday', classes: []),
      ],
    );
  }
}

class DayBlock extends StatelessWidget {
  final String day;
  final List<ClassItem> classes;

  const DayBlock({super.key, required this.day, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (classes.isEmpty)
              const Text('No classes scheduled',
                  style: TextStyle(color: Colors.grey)),
            ...classes,
          ],
        ),
      ),
    );
  }
}

class ClassItem extends StatelessWidget {
  final String teacher;
  final String student;
  final String subject;
  final String time;
  final Color color;

  const ClassItem({
    super.key,
    required this.teacher,
    required this.student,
    required this.subject,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(teacher,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color)),
          Text(student),
          Text(subject),
          Align(
            alignment: Alignment.centerRight,
            child: Text(time,
                style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

/* ===================== TEACHERS ===================== */

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        TeacherItem(
          name: 'Mr. Shvetkov',
          status: 'Available',
          color: Colors.green,
          classes: [
            'Ali Hassan — Mon 10:00',
            'Layla Ahmed — Wed 11:00'
          ],
        ),
        TeacherItem(
          name: 'Ms. Kyzembaeva',
          status: 'Busy',
          color: Colors.red,
          classes: ['Amira Khalil — Mon 14:00'],
        ),
        TeacherItem(
          name: 'Dr. Arafat',
          status: 'Partially Available',
          color: Colors.orange,
          classes: ['Mohamed Ali — Tue 09:00'],
        ),
        TeacherItem(
          name: 'Ms. Aiman',
          status: 'Available',
          color: Colors.green,
          classes: ['Yusuf Hassan — Thu 16:00'],
        ),
        TeacherItem(
          name: 'Mr. Madi',
          status: 'Busy',
          color: Colors.red,
          classes: [],
        ),
      ],
    );
  }
}

class TeacherItem extends StatelessWidget {
  final String name;
  final String status;
  final Color color;
  final List<String> classes;

  const TeacherItem({
    super.key,
    required this.name,
    required this.status,
    required this.color,
    required this.classes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: Text(name[0]),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text(status,
                        style: TextStyle(color: color)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (classes.isEmpty)
              const Text('No upcoming classes',
                  style: TextStyle(color: Colors.grey)),
            ...classes.map((c) => Text('• $c')),
          ],
        ),
      ),
    );
  }
}
