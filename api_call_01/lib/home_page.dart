import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> users = [];
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
            final imageUser = user['picture']['large'];
            final name = user['name']['first'];
            final email = user['email'];
            final location = user['location']['country'];
            final street = user['location']['street']['name'];
            return ListTile(
              leading: Image.network(imageUser),
              title: Text(name),
              subtitle: Text(email),
              trailing: Text('$location   $street'),
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
    setState(() {
      users = json['results'];
    });
    print('Fetch Users Completed');
  }
}
