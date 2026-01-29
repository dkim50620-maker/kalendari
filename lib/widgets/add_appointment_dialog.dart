class AddAppointmentDialog extends StatefulWidget {
  final Map<String, List<Lesson>> week;
  final List<String> teachers;
  final Function(Lesson lesson, String day) onAdd;

  const AddAppointmentDialog({
    super.key,
    required this.week,
    required this.teachers,
    required this.onAdd,
  });

  @override
  State<AddAppointmentDialog> createState() =>
      _AddAppointmentDialogState();
}
