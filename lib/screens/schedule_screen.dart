import 'package:flutter/material.dart';

class Lesson {
  final String teacher;
  final String student;
  final TimeOfDay start;
  final TimeOfDay end;

  Lesson({
    required this.teacher,
    required this.student,
    required this.start,
    required this.end,
  });
}

class ScheduleScreen extends StatefulWidget {
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final teachers = ["Mr. Shvetkov", "Ms. Kyzmabeva", "Dr. Arafat", "Ms. Airman"];

  final Map<String, List<Lesson>> week = {
    "Sunday": [],
    "Monday": [],
    "Tuesday": [],
    "Wednesday": [],
    "Thursday": [],
    "Friday": [],
    "Saturday": [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: const [
            Text(
              "Jan 25 - Jan 31",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Weekly Schedule",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: week.entries
            .map((entry) => _buildDay(entry.key, entry.value))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  Widget _buildDay(String day, List<Lesson> lessons) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${lessons.length} classes",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          if (lessons.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "No classes scheduled",
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            Column(
              children: lessons.map((e) {
                return ListTile(
                  title: Text(e.teacher),
                  subtitle: Text(
                    "${e.start.format(context)} - ${e.end.format(context)}",
                  ),
                  trailing: Text(e.student),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _showAddDialog() {
    String? teacher;
    String? day;
    TimeOfDay? start;
    TimeOfDay? end;

    final student = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Add New Appointment"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                      decoration:
                      const InputDecoration(labelText: "Teacher"),
                      items: teachers
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (v) =>
                          setStateDialog(() => teacher = v),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: student,
                      decoration:
                      const InputDecoration(labelText: "Student"),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField(
                      decoration:
                      const InputDecoration(labelText: "Day"),
                      items: week.keys
                          .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                          .toList(),
                      onChanged: (v) =>
                          setStateDialog(() => day = v),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(start == null
                          ? "Start time"
                          : start!.format(context)),
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime:
                          const TimeOfDay(hour: 9, minute: 0),
                        );
                        if (t != null) {
                          setStateDialog(() => start = t);
                        }
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(end == null
                          ? "End time"
                          : end!.format(context)),
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime:
                          const TimeOfDay(hour: 10, minute: 0),
                        );
                        if (t != null) {
                          setStateDialog(() => end = t);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (teacher == null ||
                        day == null ||
                        start == null ||
                        end == null ||
                        student.text.isEmpty) return;

                    setState(() {
                      week[day]!.add(
                        Lesson(
                          teacher: teacher!,
                          student: student.text,
                          start: start!,
                          end: end!,
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Add Appointment"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
