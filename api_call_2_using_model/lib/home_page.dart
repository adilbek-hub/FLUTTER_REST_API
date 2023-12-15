import 'dart:convert';

import 'package:api_call_2_using_model/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;
            final color = user.gender == 'male' ? Colors.green : Colors.red;
            final gender = user.gender;

            return ListTile(
              leading: Text(user.nat),
              title: Text(email),
              subtitle: Text(user.cell),
              trailing: Text(gender),
              tileColor: color,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['results'] as List<dynamic>;
    final transformed = result.map((e) {
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
      );
    }).toList();

    setState(() {
      users = transformed;
    });
  }
}
