import 'package:flutter/material.dart';
import '../models/class_data.dart';
import '../dialogs/add_appointment_dialog.dart';

class TeachersScreen extends StatefulWidget {
  final List<ClassData> allClassData;
  final Function(ClassData) onAddClass;

  const TeachersScreen({
    super.key,
    required this.allClassData,
    required this.onAddClass,
  });

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<ClassData>> teachersMap = {};
    for (var data in widget.allClassData) {
      teachersMap.putIfAbsent(data.teacher, () => []).add(data);
    }

    final teacherNames = [
      'Mr. Shvetkov',
      'Ms. Kyzembaeva',
      'Dr. Arafat',
      'Ms. Aiman',
      'Mr. Madi',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, size: 18, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Поиск учителей...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: teacherNames.length,
        itemBuilder: (context, index) {
          final teacher = teacherNames[index];
          final classes = teachersMap[teacher] ?? [];
          
          return _TeacherCard(
            name: teacher,
            classes: classes,
            status: _getStatus(teacher),
            color: _getTeacherColor(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddAppointmentDialog(onAdd: widget.onAddClass),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _getStatus(String name) {
    if (name.contains('Shvetkov')) return 'Доступен';
    if (name.contains('Kyzembaeva')) return 'Занят';
    if (name.contains('Arafat')) return 'Частично доступен';
    if (name.contains('Aiman')) return 'Доступен';
    return 'Занят';
  }

  Color _getTeacherColor(int index) {
    final colors = [Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.red];
    return colors[index % colors.length];
  }
}

class _TeacherCard extends StatelessWidget {
  final String name;
  final List<ClassData> classes;
  final String status;
  final Color color;

  const _TeacherCard({
    required this.name,
    required this.classes,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: color,
                  child: Text(
                    _getInitials(name),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 6, color: _getStatusColor(status)),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(color: Colors.grey[600], fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${classes.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text('Занятий', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FB),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    const Text(
                      'Предстоящие занятия',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (classes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Center(
                      child: Text('Нет запланированных занятий', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  )
                else
                  ...classes.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.student, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('${_translateDay(c.day)} | ${c.start}-${c.end}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                      ],
                    ),
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _translateDay(String day) {
    final map = {
      'Monday': 'Пн',
      'Tuesday': 'Вт',
      'Wednesday': 'Ср',
      'Thursday': 'Чт',
      'Friday': 'Пт',
      'Saturday': 'Сб',
      'Sunday': 'Вс',
    };
    return map[day] ?? day;
  }

  String _getInitials(String name) {
    try {
      List<String> parts = name.split(' ');
      if (parts.length >= 2) {
        String first = parts[0];
        String second = parts[1];
        String firstChar = "";
        if (first.contains('.')) {
          int dotIndex = first.indexOf('.');
          if (dotIndex + 1 < first.length) {
            firstChar = first[dotIndex + 1];
          } else { firstChar = first[0]; }
        } else { firstChar = first[0]; }
        return (firstChar + second[0]).toUpperCase();
      }
      return name.substring(0, 1).toUpperCase();
    } catch (e) { return "??"; }
  }

  Color _getStatusColor(String status) {
    if (status == 'Доступен') return Colors.green;
    if (status == 'Занят') return Colors.red;
    return Colors.orange;
  }
}
