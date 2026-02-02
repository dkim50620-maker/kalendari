import 'package:flutter/material.dart';
import 'schedule_screen.dart';
import 'teachers_screen.dart';
import 'reviews_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import '../models/class_data.dart';
import '../services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _authService = AuthService();
  String _currentUser = 'админ';

  final List<String> _teacherNames = [
    'Mr. Shvetkov',
    'Ms. Kyzembaeva',
    'Dr. Arafat',
    'Ms. Aiman',
    'Mr. Madi',
  ];

  final Map<String, List<ClassData>> _schedule = {
    'Sunday': [],
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
  };

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    String? user = await _authService.getCurrentUser();
    if (user != null) {
      setState(() => _currentUser = user);
    }
  }

  void _addClass(ClassData data) {
    setState(() {
      _schedule[data.day]!.add(data);
    });
  }

  void _addTeacher(String name) {
    setState(() {
      if (!_teacherNames.contains(name)) {
        _teacherNames.add(name);
      }
    });
  }

  List<ClassData> get _allClasses {
    return _schedule.values.expand((element) => element).toList();
  }

  void _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      ScheduleScreen(
        schedule: _schedule, 
        onAddClass: _addClass,
        teachers: _teacherNames,
      ),
      TeachersScreen(
        allClassData: _allClasses,
        teacherNames: _teacherNames,
        onAddTeacher: _addTeacher,
      ),
      ProfileScreen(
        login: _currentUser,
        teachersCount: _teacherNames.length,
        classesCount: _allClasses.length,
        onLogout: _logout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Teachers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
