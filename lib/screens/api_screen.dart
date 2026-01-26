import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<User> fetchUser() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/users'),
  );

  if (response.statusCode == 200) {
    return User.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception(
      'Ошибка загрузки данных: ${response.statusCode}',
    );
  }
}

class ApiScreen extends StatefulWidget {
  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API • Fetch Data'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_done, size: 60),
                  Text('ID: ${snapshot.data!.id}'),
                  Text(
                    snapshot.data!.firstName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}



