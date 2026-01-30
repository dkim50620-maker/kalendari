import 'package:flutter/material.dart';
import '../models/class_data.dart';

class AddAppointmentDialog extends StatefulWidget {
  final Function(ClassData) onAdd;
  final List<String> teachers;

  const AddAppointmentDialog({
    super.key, 
    required this.onAdd, 
    required this.teachers,
  });

  @override
  State<AddAppointmentDialog> createState() =>
      _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  String? teacher;
  String? day;
  String? start;
  String? end;

  final studentCtrl = TextEditingController();

  final days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final times = ['09:00', '10:00', '11:00', '12:00', '14:00', '15:00', '16:00', '17:00'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '+ Добавить занятие',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
    
              _label('Учитель *'),
              _dropdown(teacher, widget.teachers, (v) => setState(() => teacher = v)),
    
              _label('Имя ученика *'),
              _input(studentCtrl),
    
              _label('День *'),
              _dropdown(day, days, (v) => setState(() => day = v)),
    
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Начало', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        _dropdown(start, times, (v) => setState(() => start = v)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Конец', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        _dropdown(end, times, (v) => setState(() => end = v)),
                      ],
                    ),
                  ),
                ],
              ),
    
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Добавить'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );

  Widget _input(TextEditingController c) => TextField(
    controller: c,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF1F1F1),
      hintText: 'Имя ученика',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
  );

  Widget _dropdown(
      String? value,
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: const Text('Выбрать'),
      onChanged: onChanged,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
