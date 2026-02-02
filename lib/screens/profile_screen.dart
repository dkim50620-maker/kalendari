import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String login;
  final int teachersCount;
  final int classesCount;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.login,
    required this.teachersCount,
    required this.classesCount,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      appBar: AppBar(
        title: const Text('TaskFlow'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(Icons.person_outline, color: Colors.white, size: 35),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        login,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Администратор',
                        style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Info Section
            _buildSection(
              title: 'Информация об аккаунте',
              child: Column(
                children: [
                  _buildInfoRow(Icons.person_outline, 'Логин', login, Colors.blue),
                  const Divider(height: 24),
                  _buildInfoRow(Icons.security_outlined, 'Роль', 'Администратор', Colors.purple),
                  const Divider(height: 24),
                  _buildInfoRow(Icons.calendar_today_outlined, 'Дата регистрации', '2 февраля 2026 г.', Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Statistics Section
            _buildSection(
              title: 'Статистика',
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      teachersCount.toString(),
                      'Преподавателей',
                      const Color(0xFFE8F0FE),
                      const Color(0xFF1A73E8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      classesCount.toString(),
                      'Занятий',
                      const Color(0xFFE6F4EA),
                      const Color(0xFF1E8E3E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: onLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Выйти из аккаунта'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'TaskFlow v1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const Text(
              '© 2026 Все права защищены',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
