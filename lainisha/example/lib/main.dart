import 'package:flutter/material.dart';
import 'package:lainisha/lainisha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final restDataProvider =
        RestDataProvider('https://jsonplaceholder.typicode.com');

    return LainishaAdmin(
      title: 'Lainisha Admin Portal',
      dataProvider: restDataProvider,
      resources: [
        Resource(name: 'users'),
        Resource(name: 'posts'),
        Resource(
          name: 'users',
          list: (context) => const Center(child: Text('Users List')),
          create: (context) => const Center(child: Text('Create User')),
          edit: (context, data) =>
              Center(child: Text('Edit User: ${data['name']}')),
        ),
        Resource(
          name: 'posts',
          list: (context) => const Center(child: Text('Posts List')),
        ),
      ],
    );
  }
}
