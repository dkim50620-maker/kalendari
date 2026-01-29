import 'package:flutter/material.dart';
import '../models/class_data.dart';

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
          Text(
            data.teacher,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(data.student),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${data.start} - ${data.end}',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
