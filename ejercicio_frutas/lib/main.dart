import 'package:flutter/material.dart';
import 'package:ejercicio_frutas/fruit_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FruitListPage(),
    );
  }
}
